//
//  SearchViewController.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 23/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor: [UIColor colorWithRed:116.0/255.0 green:159.0/255.0 blue:160.0/255.0 alpha:1]];*/ 
    
    self.tabBarItem.selectedImage = [[UIImage imageNamed: @"SearchSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem.image = [[UIImage imageNamed:@"Search.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
