//
//  AnimalDetailViewController.h
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 26/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Animal.h"
#import "AsyncImageView.h"

@interface AnimalDetailViewController : UIViewController

@property (strong, nonatomic) Animal *animal;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLaber;
@property (weak, nonatomic) IBOutlet PFImageView *fotoAnimal;
@property (weak, nonatomic) IBOutlet UILabel *specieLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *situationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
