//
//  settingsViewController.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 31/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "AnimalViewController.h"
#import "UsuarioSingleton.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor: [UIColor colorWithRed:116.0/255.0 green:159.0/255.0 blue:160.0/255.0 alpha:1]];
    
    
    self.tabBarItem.selectedImage = [[UIImage imageNamed: @"settingsSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem.image = [[UIImage imageNamed:@"settings.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
}

-(void)viewDidAppear:(BOOL)animated{

    if(![UsuarioSingleton sharedInstance].isAuthenticated)
    {
        
        [self.logoutButton setTitle:@"Ir para login" forState:UIControlStateNormal];
        
    }
    else{
        
        [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"logoutSegue"]){
        [(LoginViewController *)segue.destinationViewController logout];
    }

}

- (IBAction)pressLogout:(id)sender {
    
    [self performSegueWithIdentifier:@"logoutSegue" sender:self];
    
}

@end
