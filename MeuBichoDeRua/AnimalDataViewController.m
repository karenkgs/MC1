//
//  DogDataViewController.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 24/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "AnimalDataViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UsuarioSingleton.h"
#import "SVProgressHUD.h"


@interface AnimalDataViewController ()
{
    NSString *parameter;
    
    CLLocationManager *locationManager;
    
    NSString *usuario;
    
    PFGeoPoint *point;
    
    
    NSArray *especies;
    NSArray *generos;
    NSArray *portes;
    NSArray *idades;
    NSArray *situacoes;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *photo;


- (void)itWasSelected:(NSNumber *)selectedIndex element:(id)element;

@end

@implementation AnimalDataViewController


@synthesize generoBtn = _generoBtn;
@synthesize especieBtn = _especieBtn;
@synthesize porteBtn = _porteBtn;
@synthesize idadeBtn = _idadeBtn;
@synthesize cadBtn = _cadBtn;

@synthesize selectedIndex = _selectedIndex;

@synthesize p = _p;


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)setImagem:(UIImage*)imagem{
    self.p=imagem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.photo setImage:self.p];
    
    //self.animalTextField.enabled = NO;
    
    especies = @[@"Gato", @"Cão", @"Outro"];
    
    generos = @[@"Fêmea", @"Macho", @"Não identificado"];
    
    portes = @[@"Pequeno", @"Médio", @"Grande"];
    
    idades = @[@"Filhote", @"Adulto", @"Idoso"];
    
    situacoes = @[@"Ferido", @"Doente", @"Abandonado", @"Prenhe", @"Bem"];
    
    locationManager = [[CLLocationManager alloc] init];
    point = [[PFGeoPoint alloc] init];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - IBActions

- (IBAction)selecionaEspecie:(UIControl *)sender {
    parameter = @"Especie";
    [ActionSheetStringPicker showPickerWithTitle:@"Selecione a Espécie" rows:especies initialSelection:self.selectedIndex target:self successAction:@selector(itWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    
}


- (IBAction)selecionaGenero:(UIControl *)sender {
    parameter = @"Generos";
    [ActionSheetStringPicker showPickerWithTitle:@"Selecione o Gênero" rows:generos initialSelection:self.selectedIndex target:self successAction:@selector(itWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    
}

- (IBAction)selecionaPorte:(UIControl *)sender{
    parameter = @"Portes";
    [ActionSheetStringPicker showPickerWithTitle:@"Selecione o Porte" rows:portes initialSelection:self.selectedIndex target:self successAction:@selector(itWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (IBAction)selecionaIdade:(UIControl *)sender{
    parameter = @"Idades";
    [ActionSheetStringPicker showPickerWithTitle:@"Selecione a Idade" rows:idades initialSelection:self.selectedIndex target:self successAction:@selector(itWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (IBAction)selecionaSituacao:(UIControl *)sender{
    parameter = @"Situacoes";
    [ActionSheetStringPicker showPickerWithTitle:@"Selecione a Situação" rows:situacoes initialSelection:self.selectedIndex target:self successAction:@selector(itWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

#pragma mark - Implementation

- (void)itWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedIndex = [selectedIndex intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    
    if([parameter isEqualToString:@"Especie"]){
        [self.especieBtn setTitle:(especies)[(NSUInteger) self.selectedIndex] forState:UIControlStateNormal];
        
    } else if ([parameter isEqualToString:@"Generos"]){
        [self.generoBtn setTitle:(generos)[(NSUInteger) self.selectedIndex] forState:UIControlStateNormal];
        
    }else if ([parameter isEqualToString:@"Idades"]){
        [self.idadeBtn setTitle:(idades)[(NSUInteger) self.selectedIndex] forState:UIControlStateNormal];
        
    }else if ([parameter isEqualToString:@"Portes"]){
        [self.porteBtn setTitle:(portes)[(NSUInteger) self.selectedIndex] forState:UIControlStateNormal];
        
    }else if ([parameter isEqualToString:@"Situacoes"]){
        [self.situacaoBtn setTitle:(situacoes)[(NSUInteger) self.selectedIndex] forState:UIControlStateNormal];
        
    }
    
}


- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}


- (void) pickerButtonPressed:(id)sender {
    NSLog(@"Picker");
    
    ActionSheetStringPicker * picker = [[ActionSheetStringPicker alloc] initWithTitle:@"Title"  rows:@[@"Row1",@"Row2",@"Row3"] initialSelection:0  doneBlock:^(ActionSheetStringPicker *stringPicker, NSInteger selectedIndex, id selectedValue) {
        //NSLog(@"selectedIndex = %i", selectedIndex);
    } cancelBlock:^(ActionSheetStringPicker *stringPicker) {
        NSLog(@"picker = %@", stringPicker);
    } origin: (UIView*)sender ];
    
    
    
    [picker showActionSheetPicker];
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        [point setLatitude:currentLocation.coordinate.latitude];
        [point setLongitude:currentLocation.coordinate.longitude];
    }
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    [self cadastrar];
}

-(IBAction)pegarPosicao:(id)sender{
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}


-(void)cadastrar
{
    if([self.idadeBtn.titleLabel.text isEqualToString: @"Selecione a idade"] || [self.self.generoBtn.titleLabel.text isEqualToString: @"Selecione o gênero"] || [self.porteBtn.titleLabel.text isEqualToString: @"Selecione o porte"] || [self.especieBtn.titleLabel.text isEqualToString: @"Selecione a Espécie"] || [self.situacaoBtn.titleLabel.text  isEqualToString: @"Selecione a situação"])
    {
        [[[UIAlertView alloc] initWithTitle:@"Erro"
                                    message:@"Você precisa selecionar todos os campos!"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
        
    }
    
    else
    {
        [self.cadBtn setEnabled: NO];
        [SVProgressHUD show];
        NSData *imageData = UIImagePNGRepresentation(self.p);
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        
        PFObject *animal = [PFObject objectWithClassName:@"Animal"];
        animal[@"age"] = self.idadeBtn.titleLabel.text;
        animal[@"gender"] = self.generoBtn.titleLabel.text;
        animal[@"location"] = point;
        animal[@"owner"] = [UsuarioSingleton sharedInstance].user;
        animal[@"owner_name"] = [UsuarioSingleton sharedInstance].userFirstName;
        animal[@"owner_surname"] = [UsuarioSingleton sharedInstance].userLastName;
        animal[@"photo"] = imageFile;
        animal[@"size"] = self.porteBtn.titleLabel.text;
        animal[@"specie"] = self.especieBtn.titleLabel.text;
        animal[@"situation"] = self.situacaoBtn.titleLabel.text;
        animal[@"status"] = @YES;
        [animal saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [SVProgressHUD dismiss];
                [[[UIAlertView alloc] initWithTitle:@"Sucesso"
                                            message:@"Cadastrado com sucesso!"
                                           delegate:nil
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil] show];
                //[NSNotificationCenter defaultCenter];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.cadBtn setEnabled: YES];
            } else {
                [SVProgressHUD dismiss];
                [[[UIAlertView alloc] initWithTitle:@"Erro"
                                            message:@"Algum erro ocorreu!"
                                           delegate:nil
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil] show];
                [self.cadBtn setEnabled: YES];
            }
        }
         ];
        //[self.navigationController performSegueWithIdentifier:@"acabouCadastro" sender:self];
    }
    
}


@end
