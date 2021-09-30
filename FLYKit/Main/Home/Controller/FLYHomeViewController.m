//
//  FLYHomeViewController.m
//  FLYKit
//
//  Created by fly on 2021/9/7.
//

#import "FLYHomeViewController.h"
#import "FLYNavigationController.h"
#import "NSString+FLYEncryption.h"

@interface FLYHomeViewController ()

@end

@implementation FLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ((FLYNavigationController*)(self.navigationController)).isLine = YES;
    
    
    [self initUI];
}




- (void)initUI
{
   /**
    
    http
    摄像头
    相册 （读取）
    相册 （写入）
    蓝牙 （使用时）
    蓝牙 （始终）
    定位 （使用时）
    定位 （始终）
    定位 （始终和使用时）
    麦克风
    通讯录
    */
    
    NSString * s = @"fly";
    NSLog(@"s = %@", [s md5String]);
    NSLog(@"length = %lu", (unsigned long)[s md5String].length);
}


@end
