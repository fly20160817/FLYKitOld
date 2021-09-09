//
//  FLYHomeViewController.m
//  FLYKit
//
//  Created by fly on 2021/9/7.
//

#import "FLYHomeViewController.h"
#import "FLYNavigationController.h"

@interface FLYHomeViewController ()

@end

@implementation FLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ((FLYNavigationController*)(self.navigationController)).isLine = YES;
}

@end
