//
//  MapViewController.m
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 20/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "MapViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AnimalDetailViewController.h"
#import "AnimalMKPointAnnotation.h"
#import "AnimalViewController.h"

@interface MapViewController ()
{
    BOOL zoomInUser;
}

@end

@implementation MapViewController
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed: @"pinDogSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"pinDog.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    self.mapView.showsUserLocation = YES;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
#endif
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
    
}



-(void) adicionaPinoDoBanco
{
    NSMutableArray *animais = [NSMutableArray array];
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    [query whereKey:@"status" equalTo:@YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(! error)
        {
            [animais addObjectsFromArray: objects];
            for(id animal in animais)
            {
                PFGeoPoint *pf = animal[@"location"];
                CLLocationCoordinate2D coordenadas = CLLocationCoordinate2DMake(pf.latitude, pf.longitude);
                AnimalMKPointAnnotation *pino = [[AnimalMKPointAnnotation alloc] init];
                pino.coordinate = coordenadas;
                
                Animal *a = [[Animal alloc]init];
                a.especie = animal[@"specie"];
                a.genero = animal[@"gender"];
                a.size = animal[@"size"];
                a.age = animal[@"age"];
                a.owner = animal[@"owner"];
                a.situation = animal[@"situation"];
                a.imageFile = [animal objectForKey:@"photo"];
                a.date = [animal updatedAt];
                a.animalId = [animal objectId];
                
                pino.animalMk = a;
                
                pino.title = animal[@"specie"];
                [self.mapView addAnnotation:pino];
            }
            
        }
        else
        {
            NSLog(@"Deu caca");
        }
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    
    
    NSArray *a = self.mapView.annotations;
    [self.mapView removeAnnotations: a];
    [self adicionaPinoDoBanco];
    
    
}


- (IBAction)listarAnimais:(id)sender {
    [self performSegueWithIdentifier:@"lista" sender:self];
}


//quando clica no pino abre balao

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *) pino
{
    NSLog(@"Pino %@ selecionado", pino);
    //AnimalMKPointAnnotation *animalMK  =  pino.annotation;
    // self.selectedAnimal = animalMK.animalMk;
}

//quando clica no balao

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    AnimalMKPointAnnotation *animalMK  =  view.annotation;
    [self performSegueWithIdentifier:@"detail" sender:animalMK.animalMk];
}

//personaliza o pino

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"pinDogSelected.png"];
            pinView.calloutOffset = CGPointMake(0, 5);
            UIButton * detailView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = detailView;
            pinView.frame = CGRectMake(0, 0, 32, 45);
            //igor
            pinView.centerOffset = CGPointMake(0, -(pinView.image.size.height)/2);
        } else {
            pinView.annotation = annotation;
        }
        
        
        
        
        return pinView;
    }
    return nil;
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(!zoomInUser)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
        
        [self.mapView setRegion:region animated:YES];
        
        zoomInUser = YES;
    }
    
    
    //[self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}
- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}


-(void) mapView:(MKMapView *)mapView
didAddAnnotationViews:(NSArray *)views {
    //MKAnnotationView *v = [views objectAtIndex:0];
    //CLLocationDistance distancia = 400;
    //MKCoordinateRegion regiao = MKCoordinateRegionMakeWithDistance([v.annotation coordinate], distancia, distancia);
    //[self.mapView setRegion:regiao animated:YES];
    
}

- (IBAction)logOutFacebook:(UIBarButtonItem *)sender {
    
    if (FBSession.activeSession.isOpen)
    {
        [FBSession.activeSession closeAndClearTokenInformation];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"detail"]){
        
        ((AnimalDetailViewController *)segue.destinationViewController).animal = sender;
        
    }
    
}


@end
