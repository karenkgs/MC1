//
//  DogsViewController.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 24/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "DogsViewController.h"
#import <Parse/Parse.h>

@interface DogsViewController ()

@end

@implementation DogsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
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

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"imageFile"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    UILabel *genderLabel = (UILabel*) [cell viewWithTag:101];
    genderLabel.text = [object objectForKey:@"gender"];
    
        return cell;
}




@end
