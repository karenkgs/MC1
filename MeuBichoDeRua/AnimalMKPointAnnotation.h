//
//  AnimalMKPointAnnotation.h
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 27/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Animal.h"

@interface AnimalMKPointAnnotation : MKPointAnnotation

@property (strong, nonatomic) Animal *animalMk;

@end
