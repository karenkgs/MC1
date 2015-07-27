//
//  OngDetailViewController.m
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 28/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "OngDetailViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface OngDetailViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *acvIndicator;

@end

@implementation OngDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor: [UIColor colorWithRed:116.0/255.0 green:159.0/255.0 blue:160.0/255.0 alpha:1]];
    
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed: @"ONGsSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"ONGs.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //seta imagem
    
    [self.acvIndicator startAnimating];
    self.headerImageView.file = self.ong.headerImageFile;
    
    [self.headerImageView loadInBackground:^(UIImage *image, NSError *error){
        
        if(!error){
            [self.acvIndicator stopAnimating];
            self.acvIndicator.hidden = TRUE;
            self.headerImageView.image = image;
        }
        
    }];
    //seta label
    self.nomeLabel.text = self.ong.nome;
    self.telefoneLabel.text = self.ong.telefone;
    self.emailLabel.text = self.ong.email;
    self.siteLabel.text = self.ong.site;
    self.descriptionLabel.text = self.ong.descriptionONG;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
