//
//  AnimalDetailViewController.m
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 26/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "AnimalDetailViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import "CommentViewController.h"
#import "UsuarioSingleton.h"
#import "SVProgressHUD.h"


@interface AnimalDetailViewController ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *acvIndicator;

@property (weak, nonatomic) IBOutlet UIButton *desativarButton;

@end

@implementation AnimalDetailViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    //seta imagem
    
    /*UIImage *photoImage = [[UIImage alloc] init];
    
    NSData *d = (NSData * )[self.animal.imageFile getData];
    photoImage = [UIImage imageWithData:d];
    self.fotoAnimal.image = photoImage;
     */
    
    self.desativarButton.hidden = YES;
    
    [self.acvIndicator startAnimating];
    self.fotoAnimal.file = self.animal.imageFile;
    self.fotoAnimal.layer.cornerRadius=20;
    self.fotoAnimal.layer.borderWidth=1.0;
    
    [self.fotoAnimal loadInBackground:^(UIImage *image, NSError *error){
        
        if(!error){
            [self.acvIndicator stopAnimating];
             self.acvIndicator.hidden = TRUE;
             self.fotoAnimal.image = image;
        }
        
    }];
    

    //seta labels
    self.specieLabel.text = self.animal.especie;
    self.genderLaber.text = self.animal.genero;
    self.sizeLabel.text = self.animal.size;
    self.ageLabel.text = self.animal.age;
    self.ownerLabel.text = self.animal.owner;
    self.situationLabel.text = self.animal.situation;
   
    
    if([[UsuarioSingleton sharedInstance].user isEqualToString: self.animal.owner]){
        self.desativarButton.hidden = NO;
    }
    
    NSDate *date = self.animal.date;
    NSDateFormatter *dataFormatada = [[NSDateFormatter alloc] init];
    [dataFormatada setDateFormat:@"MMM/yyyy"];
    
    self.dateLabel.text = [dataFormatada stringFromDate:date];
    
}

- (IBAction)desativarAction:(UIButton *)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.animal.animalId block:^(PFObject *animal, NSError *error) {
        if(!error){
            self.desativarButton.hidden = TRUE;
            [SVProgressHUD show];
            // Now let's update it with some new data.
            animal[@"status"] = @NO;
            [animal saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                if (succeeded) {
                    [SVProgressHUD dismiss];
                    [[[UIAlertView alloc] initWithTitle:@"Sucesso"
                                                message:@"Desativado com sucesso!"
                                               delegate:nil
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:nil] show];
                    //[NSNotificationCenter defaultCenter];
                    //ß[self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [SVProgressHUD dismiss];
                    [[[UIAlertView alloc] initWithTitle:@"Erro"
                                                message:@"Algum erro ocorreu!"
                                               delegate:nil
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:nil] show];
                }
            }];
        } else {
            //Animal nao encontrado
        }

        
    }];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        if([[segue identifier] isEqualToString:@"ShowComments"]){
            
            CommentViewController *c = (CommentViewController*) segue.destinationViewController;
            c.animalId = self.animal.animalId;
            
        }
    }

    
    
    



@end
