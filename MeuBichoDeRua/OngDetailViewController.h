//
//  OngDetailViewController.h
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 28/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Ong.h"

@interface OngDetailViewController : UIViewController

@property(strong, nonatomic) Ong *ong;
@property (weak, nonatomic) IBOutlet PFImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *telefoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;

@end
