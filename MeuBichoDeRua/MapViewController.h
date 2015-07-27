//
//  MapViewController.h
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 20/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "Animal.h"

@interface MapViewController : UIViewController <MKMapViewDelegate,  CLLocationManagerDelegate>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@property (strong, nonatomic) IBOutlet UIBarButtonItem *listaBtn;

- (IBAction)listarAnimais:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

//@property (weak, nonatomic)  Animal *selectedAnimal;
@property(nonatomic, retain) CLLocationManager *locationManager;
@end
