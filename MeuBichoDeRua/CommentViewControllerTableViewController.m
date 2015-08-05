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
@property (strong, nonatomic) IBOutlet UIButton *enviarButton;
@property (strong, nonatomic) IBOutlet UITextView *descTextView;

@end

@implementation CommentViewController


- (IBAction)addComment:(UIButton *)sender {
    
    self.enviarButton.enabled = false;
    PFObject *comment = [PFObject objectWithClassName:@"Comment"];
    comment[@"description"] = self.descTextView.text;
    comment[@"commentOwner"] = [UsuarioSingleton sharedInstance].user;
    comment[@"animalId"] = self.animalId;
    [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [[[UIAlertView alloc] initWithTitle:@"Sucesso"
                                        message:@"Salvo com sucesso!"
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
                       self.descTextView.text = @"";
                       self.enviarButton.enabled = true;
                       [self loadObjects];
            
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Erro"
                                        message:@"Algum erro ocorreu!"
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
        }
    }
     ];
    
  
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (void)viewDidAppear:(BOOL)animated{

    if(![UsuarioSingleton sharedInstance].isAuthenticated)
    {
        self.enviarButton.enabled = false;
        self.descTextView.editable = false;
        
        [[[UIAlertView alloc] initWithTitle:@"Erro"
                                    message:@"Você precisa estar logado para fazer comentários!"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }


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
    
    [query whereKey:@"animalId" equalTo:self.animalId];
    
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
    [dataFormatada setDateFormat:@"dd/MMM/yyyy"];
    dataLabel.text = [dataFormatada stringFromDate:date];
    
    UILabel *ownerLabel= (UILabel *) [cell viewWithTag:101];
    
    NSString *ownerName = [[NSString alloc] init];
    ownerName = @"Por: ";
    ownerLabel.text = [ownerName stringByAppendingString: c.commentOwner];
    
    return cell;
}


@end
