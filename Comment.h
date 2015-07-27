//
//  Comment.h
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 19/04/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>

@interface Comment : NSObject

@property (strong, nonatomic) NSString *commentOwner;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *animalId;
@end
