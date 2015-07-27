//
//  DogDataViewController.h
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 24/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ActionSheetPicker.h"


@class AbstractActionSheetPicker;

@interface AnimalDataViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *generoBtn;
@property (nonatomic, strong) IBOutlet UIButton *especieBtn;
@property (strong, nonatomic) IBOutlet UIButton *porteBtn;
@property (strong, nonatomic) IBOutlet UIButton *idadeBtn;
@property (strong, nonatomic) IBOutlet UIButton *situacaoBtn;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
@property (nonatomic) UIImage * p;

@property (strong, nonatomic) IBOutlet UIButton *cadBtn;

- (IBAction)selecionaEspecie:(id)sender;
- (IBAction)selecionaGenero:(id)sender;
- (IBAction)selecionaPorte:(id)sender;
- (IBAction)selecionaIdade:(id)sender;
- (IBAction)selecionaSituacao:(id)sender;
- (void)setImagem: (UIImage *)hue;

@end
