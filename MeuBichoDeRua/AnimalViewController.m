//
//  DogsViewController.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 24/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "AnimalViewController.h"
#import <Parse/Parse.h>
#import "Animal.h"
#import "AnimalTableViewCell.h"
#import "AnimalDetailViewController.h"
#import "UsuarioSingleton.h"

@interface AnimalViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *animaisFiltro;

@end

@implementation AnimalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animaisFiltro.selectedSegmentIndex = 0;
    
    [self loadObjects];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor: [UIColor colorWithRed:116.0/255.0 green:159.0/255.0 blue:160.0/255.0 alpha:1]]; 
    
   /* self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed: @"ListaSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"Lista.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];*/
    
    [self.navigationController.tabBarController.tabBar setBackgroundColor:[UIColor clearColor]];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [self loadObjects];

}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    
    //self.noDataButton.hidden = ([self.objects count] != 0);
}



- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Animal";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"objectId";
        
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
}
    return self;
}
- (IBAction)filtraAnimais:(UISegmentedControl *)sender {
    [self loadObjects];
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query whereKey:@"status" equalTo:@YES];
    if(self.animaisFiltro.selectedSegmentIndex == 1){
        [query whereKey:@"owner" equalTo:[UsuarioSingleton sharedInstance].user];
        
    }
    
    return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    AnimalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[AnimalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Animal *a = [[Animal alloc]init];
    a.especie = object[@"specie"];
    a.genero = object[@"gender"];
    a.size = object[@"size"];
    a.age = object[@"age"];
    a.owner = object[@"owner"];
    a.owner_name = object[@"owner_name"];
    a.owner_surname = object[@"owner_surname"];
    a.situation = object[@"situation"];
    a.imageFile = [object objectForKey:@"photo"];
    a.date = [object updatedAt];
    a.animalId = [object objectId];
    a.status = [object[@"status"] boolValue];

    cell.animal = a;
    
    PFImageView *foto = (PFImageView *) [cell viewWithTag:120];
    
    //Arredonda a imagem
    foto.layer.masksToBounds = YES;
    foto.layer.cornerRadius = 15.0;
    
    UIActivityIndicatorView *acvView = (UIActivityIndicatorView*) [cell viewWithTag:200];
    
    [acvView startAnimating];
    
    foto.file = a.imageFile;
    
    [foto loadInBackground:^(UIImage *image, NSError *error){
        
        if(!error){
            [acvView stopAnimating];
            acvView.hidden = TRUE;
            foto.image = image;
        }
        
    }];
    
    UILabel *specieLabel = (UILabel*) [cell viewWithTag:101];
    specieLabel.text = a.especie;
    
    
    UILabel *genderLabel = (UILabel*) [cell viewWithTag:102];
    
    if(![a.genero isEqual:@"Não identificado"]){
        genderLabel.text = a.genero;
    } else {
        genderLabel.hidden = YES;
    }
    
    UILabel *dataLabel = (UILabel*) [cell viewWithTag:103];
      NSDate *date = [object updatedAt];
    
     NSDateFormatter *dataFormatada = [[NSDateFormatter alloc] init];
     [dataFormatada setDateFormat:@"MMM/yyyy"];
    
    
    
    NSString *data = [[NSString alloc] init];
    data = @"Atualizado em: ";
    
    dataLabel.text = [data stringByAppendingString:[dataFormatada stringFromDate:date]];
    
    UILabel *ownerLabel = (UILabel *) [cell viewWithTag:104];
    
    NSString *ownerName = [[NSString alloc] init];
    ownerName = @"Por: ";
    
    
    if([[UsuarioSingleton sharedInstance].user isEqualToString: a.owner]){
        ownerLabel.text = [ownerName stringByAppendingString: @"mim"];
    } else{
        ownerLabel.text = [[[[ownerName stringByAppendingString:
                              a.owner_name]
                             stringByAppendingString: @" "]
                             stringByAppendingString:[a.owner_surname substringWithRange:NSMakeRange(0,1)]]
                                stringByAppendingString:@"."];
        
    }
    
        return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AnimalDetailViewController *animalDetail = [self.storyboard instantiateViewControllerWithIdentifier: @"detail"];
    
    AnimalTableViewCell *selectedCell = (AnimalTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    animalDetail.animal = selectedCell.animal;
    
    [self.navigationController pushViewController:animalDetail animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0f;
    

}



@end
