//
//  VetDetailViewController.h
//  MeuBichoDeRua
//
//  Created by Julia de Lemos Santos on 3/30/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Vet.h"

@interface VetDetailViewController : UIViewController

@property (strong, nonatomic) Vet *vet;
@property (weak, nonatomic) IBOutlet PFImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionVetLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;

@end

