//
//  Animal.h
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 27/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>

@interface Animal : NSObject

@property (strong, nonatomic)  NSString *genero;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *owner_name;
@property (strong, nonatomic) NSString *owner_surname;
@property (strong, nonatomic) PFFile *imageFile;
@property (strong, nonatomic) NSString *especie;
@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *situation;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *animalId;
@property  BOOL *status;
@end
