//
//  settingsViewController.h
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 31/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *logoutButton;


- (IBAction)pressLogout:(id)sender;

@end
