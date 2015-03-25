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
@interface MapViewController ()

@end

@implementation MapViewController
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.navigationItem setHidesBackButton:YES];
    
   self.mapView.showsUserLocation = YES;
    
   // UILongPressGestureRecognizer *toqueLongoMapa =
    //[[UILongPressGestureRecognizer alloc] initWithTarget:self
    //                                              action:@selector(adicionaPinoDoBanco:)];
    //toqueLongoMapa.minimumPressDuration = 0.2;
  //  [self.mapView addGestureRecognizer:toqueLongoMapa];
    
    
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
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(! error)
        {
            [animais addObjectsFromArray: objects];
            for(id animal in animais)
            {
                PFGeoPoint *pf = animal[@"location"];
                CLLocationCoordinate2D coordenadas = CLLocationCoordinate2DMake(pf.latitude, pf.longitude);
                MKPointAnnotation *pino = [[MKPointAnnotation alloc] init];
                pino.coordinate = coordenadas;
               // pino.image = [UIImage imageNamed:@"pinDog.png"];
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
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [self.mapView setRegion:region animated:YES];
    
    
    [self adicionaPinoDoBanco];
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *) pino
{
    NSLog(@"Pino %@ selecionado", pino);
   [self performSegueWithIdentifier:@"showDetail" sender:self];
}


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
            pinView.image = [UIImage imageNamed:@"pinDog.png"];
            pinView.calloutOffset = CGPointMake(0, 32);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
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
    MKAnnotationView *v = [views objectAtIndex:0];
    CLLocationDistance distancia = 400;
    MKCoordinateRegion regiao = MKCoordinateRegionMakeWithDistance(
                                                                   [v.annotation coordinate], distancia, distancia);
    [self.mapView setRegion:regiao animated:YES];
    
}

- (IBAction)logOutFacebook:(UIBarButtonItem *)sender {
    
    if (FBSession.activeSession.isOpen)
    {
        [FBSession.activeSession closeAndClearTokenInformation];
    }
    
}




@end
