//
//  Ong.h
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 28/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>

@interface Ong : NSObject

@property (strong, nonatomic) PFFile *imageFile;
@property (strong, nonatomic) PFFile *headerImageFile;
@property (strong, nonatomic) NSString *nome;
@property (strong, nonatomic) NSString *descriptionONG;
@property (strong, nonatomic) NSString *telefone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *site;

@end
