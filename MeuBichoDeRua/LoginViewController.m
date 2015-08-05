//
//  ViewController.m
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 22/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "LoginViewController.h"
#import "MapViewController.h"
#import "UsuarioSingleton.h"

@interface LoginViewController (){
    NSString *usuario;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self toggleHiddenState:YES];
    self.loginStatusLabel.text = @"";
    
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor: [UIColor colorWithRed:189.0/255.0
                                                                                            green:210.0/255.0
                                                                                             blue:210.0/255.0
                                                                                            alpha:1]];
    
    
//    [[UITabBar appearance]
//     setBarTintColor:
//     [UIColor
//      colorWithRed:236.0/255.0
//      green:211.0/255.0
//      blue:195.0/255.0
//      alpha:0.2]];
    
    

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
                                @"email",
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
    
    UsuarioSingleton* singleton = [UsuarioSingleton sharedInstance];
    
    singleton.username = user.name;
    singleton.user = [user objectForKey:@"email"];
    singleton.userFirstName = user.first_name;
    singleton.userLastName = user.last_name;
    singleton.isAuthenticated = TRUE;
    //[UsuarioSingleton sharedInstance].user = [user objectForKey:@"email"];
    //[UsuarioSingleton sharedInstance].username = [user.name];
    
    usuario = user.name;
    self.profilePicture.profileID = user.objectID;
    self.userNameLabel.text = user.name;
    self.emailLabel.text = [user objectForKey:@"email"];
    [self performSegueWithIdentifier:@"showMap" sender:self];
    
    
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.loginStatusLabel.text = @"Você não está logado!";
    
    [self toggleHiddenState:YES];
    
     self.mapButton.enabled = NO;
    
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}

-(void)logout{
    [FBSession.activeSession closeAndClearTokenInformation];
     [UsuarioSingleton sharedInstance].isAuthenticated = FALSE;
}
- (IBAction)mapaButtonClick:(UIButton *)sender {
    [self performSegueWithIdentifier:@"vaiMapa" sender:self];
}

@end
