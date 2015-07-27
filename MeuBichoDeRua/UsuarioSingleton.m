//
//  UsuarioSingleton.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 27/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "UsuarioSingleton.h"

@implementation UsuarioSingleton

static UsuarioSingleton* usuario = nil;

+ (instancetype) sharedInstance
{
    @synchronized(self)
    {
        if (usuario == nil)
        {
            usuario = [[UsuarioSingleton alloc] init];
        }
        
    }
    
    return usuario;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.user = @"teste usuario";
        self.username = @"nome";
        self.userFirstName = @"primeiro";
        self.userLastName = @"ultimo";
    }
    return self;
}

//+ (NSString *)usuario{
//    if(!usuario){
//        usuario = @"teste usuario";
//    }
//    return usuario;
//    
//}

@end
