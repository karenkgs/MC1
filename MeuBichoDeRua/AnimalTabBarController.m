//
//  AnimalTabBarController.m
//  MeuBichoDeRua
//
//  Created by Manuela Bezerra on 02/08/15.
//  Copyright (c) 2015 BEPID. All rights reserved.
//

#import "AnimalTabBarController.h"
#import "UsuarioSingleton.h"

@implementation AnimalTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
 
  
  if([UsuarioSingleton sharedInstance].isAuthenticated)
  {
      
    [[self.tabBar.items objectAtIndex:1] setEnabled:TRUE];
      
  }else{
      
    [[self.tabBar.items objectAtIndex:1] setEnabled:FALSE];
      
  }

}



/*- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"controller class: %@", NSStringFromClass([viewController class]));
    NSLog(@"controller title: %@", viewController.title);
    
    
    if(![UsuarioSingleton sharedInstance].isAuthenticated)
    {
        [self performSegueWithIdentifier:@"voltaLogin" sender:self];
        return;
        
    }
}

*/

@end
