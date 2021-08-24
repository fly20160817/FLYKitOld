//
//  ViewController.m
//  FLYKit
//
//  Created by fly on 2021/3/20.
//

#import "ViewController.h"
#import "FLYFileManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [FLYFileManager fileSizeWithPath:[[FLYFileManager documentsPath] stringByAppendingPathComponent:@"ffffs"] completion:^(long long size) {
        
        NSLog(@"%lld", size);
        
    }];
 
}




@end
