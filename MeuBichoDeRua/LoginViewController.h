//
//  LoginViewController.h
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 22/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController  <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *loginStatusLabel;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *mapButton;

-(void)toggleHiddenState:(BOOL)shouldHide;
-(void)logout;
@end

