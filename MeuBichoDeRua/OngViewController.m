//
//  ONGsViewController.m
//  MeuBichoDeRua
//
//  Created by Julia de Lemos Santos on 3/26/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "OngViewController.h"
#import <Parse/Parse.h>
#import "OngTableViewCell.h"
#import "Ong.h"
#import "OngDetailViewController.h"

@interface OngViewController ()

@end

@implementation OngViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor: [UIColor colorWithRed:92.0/255.0 green:162.0/255.0 blue:157.0/255.0 alpha:1]];
    
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed: @"ONGsSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"ONGs.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    //self.noDataButton.hidden = ([self.objects count] != 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Ong";
        
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

- (OngTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"SimpleTableCellONG";
    
    OngTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[OngTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
  
    
    Ong *ong = [[Ong alloc]init];
    ong.nome = object[@"name"];
    ong.descriptionONG = object[@"description"];
    ong.telefone = object[@"phone"];
    ong.email = object[@"email"];
    ong.site = object[@"site"];
    ong.imageFile = [object objectForKey:@"images"];
    ong.headerImageFile = [object objectForKey:@"photoHeader"];

    
    cell.ong = ong;
    
    
    
    // Configure the cell
    
    
    PFImageView *imgIcon = (PFImageView *) [cell viewWithTag:120];
    
    //Arredonda a imagem
    imgIcon.layer.masksToBounds = YES;
    imgIcon.layer.cornerRadius = 15.0;
    
    UIActivityIndicatorView *acvView = (UIActivityIndicatorView*) [cell viewWithTag:200];
    
    [acvView startAnimating];
    
    imgIcon.file = ong.imageFile;
    
    [imgIcon loadInBackground:^(UIImage *image, NSError *error){
        
        if(!error){
            [acvView stopAnimating];
            acvView.hidden = TRUE;
            imgIcon.image = image;
        }
        
    }];

    
    UILabel *nomeLabel = (UILabel*) [cell viewWithTag:101];
    nomeLabel.text = [object objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OngDetailViewController *ongDetail = [self.storyboard instantiateViewControllerWithIdentifier: @"ongDetail"];
    OngTableViewCell *selectedCell = (OngTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    ongDetail.ong = selectedCell.ong;
    
    [self.navigationController pushViewController:ongDetail animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
    
    
}


@end
