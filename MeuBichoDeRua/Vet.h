//
//  Vet.h
//  MeuBichoDeRua
//
//  Created by Julia de Lemos Santos on 3/30/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>

@interface Vet : NSObject

@property (strong, nonatomic) PFFile *imageIcon;
@property (strong, nonatomic) PFFile *headerImage;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *descriptionVet;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *site;

@end
