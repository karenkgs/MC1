//
//  VetViewController.m
//  MeuBichoDeRua
//
//  Created by Julia de Lemos Santos on 3/30/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "Vet.h"
#import "VetViewController.h"
#import "VetTableViewCell.h"
#import "VetDetailViewController.h"
#import <Parse/Parse.h>

@interface VetViewController ()

@end

@implementation VetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor: [UIColor colorWithRed:92.0/255.0 green:162.0/255.0 blue:157.0/255.0 alpha:1]];
    
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed: @"VetSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"Vet.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        self.parseClassName = @"Vet";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"objectId";
        
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    return query;
}

- (VetTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"SimpleTableCellVet";
    
    VetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[VetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Vet *vet = [[Vet alloc]init];
    vet.imageIcon = [object objectForKey:@"icon"];
    vet.headerImage = [object objectForKey:@"header"];
    vet.name = object[@"name"];
    vet.descriptionVet = object[@"description"];
    vet.address = object[@"address"];
    vet.phone = object[@"phone"];
    vet.email = object[@"email"];
    vet.site = object[@"site"];
    
    
    cell.vet = vet;
    
    
    // Configure the cell
    
    PFImageView *imgIcon = (PFImageView *) [cell viewWithTag:120];
    
    //Arredonda a imagem
    imgIcon.layer.masksToBounds = YES;
    imgIcon.layer.cornerRadius = 15.0;
    
    UIActivityIndicatorView *acvView = (UIActivityIndicatorView*) [cell viewWithTag:200];
    
    [acvView startAnimating];
    
    imgIcon.file = vet.imageIcon;
    
    [imgIcon loadInBackground:^(UIImage *image, NSError *error){
        
        if(!error){
            [acvView stopAnimating];
            acvView.hidden = TRUE;
            imgIcon.image = image;
        }
        
    }];
    
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [object objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VetDetailViewController *vetDetail = [self.storyboard instantiateViewControllerWithIdentifier: @"vetDetail"];
    VetTableViewCell *selectedCell = (VetTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    vetDetail.vet = selectedCell.vet;
    
    [self.navigationController pushViewController:vetDetail animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
    
    
}


@end
