//
//  CommentViewController.m
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 19/04/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "CommentViewController.h"
#import <Parse/Parse.h>
#import "AnimalDetailViewController.h"
#import "UsuarioSingleton.h"
#import "Comment.h"
#import "CommentTableViewCell.h"
#import <ParseUI/ParseUI.h>



@interface CommentViewController ()
@property (strong, nonatomic) IBOutlet UITextField *descTextField;
@property (strong, nonatomic) IBOutlet UIButton *enviarButton;

@end

@implementation CommentViewController


- (IBAction)addComment:(UIButton *)sender {
    
    self.enviarButton.enabled = false;
    PFObject *comment = [PFObject objectWithClassName:@"Comment"];
    comment[@"description"] = self.descTextField.text;
    comment[@"commentOwner"] = [UsuarioSingleton sharedInstance].user;
    [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [[[UIAlertView alloc] initWithTitle:@"Sucesso"
                                        message:@"Cadastrado com sucesso!"
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            self.descTextField.text = @"";
            
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Erro"
                                        message:@"Algum erro ocorreu!"
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
        }
    }
     ];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
  
}


- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
}



- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Comment";
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Comment *c = [[Comment alloc]init];
    c.desc = object[@"description"];
    c.commentOwner = object[@"commentOwner"];
    c.date = [object updatedAt];
    
    
    cell.comment = c;
    
    // Configure the cell

    //[object ]
    
    UILabel *descriptionLabel = (UILabel*) [cell viewWithTag:100];
    descriptionLabel.text = c.desc;
    
    UILabel *dataLabel = (UILabel*) [cell viewWithTag:102];
    NSDate *date = [object updatedAt];
    
    NSDateFormatter *dataFormatada = [[NSDateFormatter alloc] init];
    [dataFormatada setDateFormat:@"DD/MMM/yyyy"];
    dataLabel.text = [dataFormatada stringFromDate:date];
    
    UILabel *ownerLabel= (UILabel *) [cell viewWithTag:101];
    
    NSString *ownerName = [[NSString alloc] init];
    ownerName = @"Por: ";
    
    ownerLabel.text = [ownerName stringByAppendingString: c.commentOwner];
    
    return cell;
}



//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return 150.0f;
    
    
//}



@end
