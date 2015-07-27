//
//  SiginDogViewController.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 23/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "SiginDogViewController.h"
#import "AnimalDataViewController.h"

@interface SiginDogViewController ()

@end

@implementation SiginDogViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tabBarItem.selectedImage = [[UIImage imageNamed: @"CadastrarSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem.image = [[UIImage imageNamed:@"Cadastrar.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self.takePhoto.layer setBorderWidth: 1.0f];
    [self.takePhoto.layer setBorderColor:[[UIColor
                                           colorWithRed:231.0/255.0
                                           green:201.0/255.0
                                           blue:183.0/255.0
                                           alpha:1]
                                          CGColor]];
    
    [self.selectPhoto.layer setBorderWidth:1.0f];
    [self.selectPhoto.layer setBorderColor:[[UIColor
                                             colorWithRed:231.0/255.0
                                             green:201.0/255.0
                                             blue:183.0/255.0
                                             alpha:1]
                                            CGColor]];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Erro"
                                                              message:@"Camera não detectada"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }
    
    
    
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier: @"ok" sender: self];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ok"]){
        
        
        UINavigationController *nav = (UINavigationController*) segue.destinationViewController;
        
        [(AnimalDataViewController*)nav.viewControllers[0] setImagem:self.imageView.image];
        self.imageView.image = [UIImage imageNamed: @"fundo.png"];
    }
}


@end