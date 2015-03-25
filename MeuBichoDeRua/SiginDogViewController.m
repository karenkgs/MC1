//
//  SiginDogViewController.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 23/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "SiginDogViewController.h"
#import "DogDataViewController.h"

@interface SiginDogViewController ()

@end

@implementation SiginDogViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.takePhoto.layer setBorderWidth: 1.0f];
    [self.takePhoto.layer setBorderColor:[[UIColor
                                           colorWithRed:116.0/255.0
                                           green:159.0/255.0
                                           blue:160.0/255.0
                                           alpha:1]
                                          CGColor]];
    
    [self.selectPhoto.layer setBorderWidth:1.0f];
    [self.selectPhoto.layer setBorderColor:[[UIColor
                                           colorWithRed:116.0/255.0
                                           green:159.0/255.0
                                           blue:160.0/255.0
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
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self performSegueWithIdentifier: @"ok" sender: self];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ok"]){
        [(DogDataViewController*)segue.destinationViewController setHue:self.imageView.image];
    }
}


@end