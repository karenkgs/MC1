//
//  DogDataViewController.m
//  MeuBichoDeRua
//
//  Created by Karen Garcia dos Santos on 24/03/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "DogDataViewController.h"

@interface DogDataViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@end

@implementation DogDataViewController

UIImage * p;

-(void)setHue:(UIImage*)hue{
    p=hue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.photo setImage:p];
    // Do any additional setup after loading the view.
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
