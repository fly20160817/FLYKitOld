//
//  FLYHomeViewController.m
//  FLYKit
//
//  Created by fly on 2021/9/7.
//

#import "FLYHomeViewController.h"
#import "FLYNavigationController.h"
#import "FLYNetworkTool.h"

@interface FLYHomeViewController ()

@end

@implementation FLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ((FLYNavigationController*)(self.navigationController)).isLine = YES;
    
    
    [self initUI];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self initUI];
}


- (void)initUI
{
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIImage * image = [UIImage imageNamed:@"Home.ico_on"];
    
    [FLYNetwork setTokenHTTPHeaders:@"668837b6-407c-47a2-a66f-74486848d4dd"];
    [FLYNetworkTool uploadImageWithPath:@"http://47.115.77.197:8002/sys/oss/upload" params:@{@"sysType" : @"1"} thumbName:@"file" images:@[image] success:^(id  _Nonnull json) {
        
        NSLog(@"json = %@", json);
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"error = %@", error);
        
    } progress:^(double progress) {
        
        NSLog(@"progress = %f", progress);
        
    }];
    
}


@end
