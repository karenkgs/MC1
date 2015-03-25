//
//  ViewController.m
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 22/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "LoginViewController.h"
#import "MapViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem hidesBackButton];
    
    [self toggleHiddenState:YES];
    self.loginStatusLabel.text = @"";
    
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    //isso aqui serve para verifica se tá logado e manda para o mapa, se não pede para se logar
    if (FBSession.activeSession.isOpen)
    {
        
        self.mapButton.enabled = YES;
        
    } else {
        // try to open session with existing valid token
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes",
                                @"read_stream",
                                @"publish_actions",
                                nil];
        FBSession *session = [[FBSession alloc] initWithPermissions:permissions];
        [FBSession setActiveSession:session];
        if([FBSession openActiveSessionWithAllowLoginUI:NO]) {
            self.mapButton.enabled = YES;
        } else {
            self.mapButton.enabled = NO;
        }
    }

}


-(void)toggleHiddenState:(BOOL)shouldHide{
    self.userNameLabel.hidden = shouldHide;
    self.emailLabel.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    self.loginStatusLabel.text = @"You are logged in.";
    
    [self toggleHiddenState:NO];
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"%@", user);
    self.profilePicture.profileID = user.objectID;
    self.userNameLabel.text = user.name;
    self.emailLabel.text = [user objectForKey:@"email"];
    [self performSegueWithIdentifier:@"showMap" sender:self];
    
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.loginStatusLabel.text = @"You are logged out";
    
    [self toggleHiddenState:YES];
    
     self.mapButton.enabled = NO;
    
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}


@end
