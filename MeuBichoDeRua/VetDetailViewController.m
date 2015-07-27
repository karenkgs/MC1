//
//  VetDetailViewController.m
//  MeuBichoDeRua
//
//  Created by Julia de Lemos Santos on 3/30/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "VetDetailViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface VetDetailViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *acvIndicator;

@end

@implementation VetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //Seta Imagem
    
    [self.acvIndicator startAnimating];
    self.headerImageView.file = self.vet.headerImage;
    
    [self.headerImageView loadInBackground:^(UIImage *image, NSError *error){
        
        if(!error){
            [self.acvIndicator stopAnimating];
            self.acvIndicator.hidden = TRUE;
            self.headerImageView.image = image;
        }
        
    }];
    //seta label
    self.nameLabel.text = self.vet.name;
    self.descriptionVetLabel.text = self.vet.descriptionVet;
    self.phoneLabel.text = self.vet.phone;
    self.addressLabel.text = self.vet.address;
    self.emailLabel.text = self.vet.email;
    self.siteLabel.text = self.vet.site;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
