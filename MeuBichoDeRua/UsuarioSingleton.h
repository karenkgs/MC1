//
//  UsuarioSingleton.h
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 27/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsuarioSingleton : NSObject

@property(nonatomic) NSString *user;
@property(nonatomic) NSString *username;
@property(nonatomic) NSString *userLastName;
@property(nonatomic) NSString *userFirstName;

+ (instancetype) sharedInstance;

@end
