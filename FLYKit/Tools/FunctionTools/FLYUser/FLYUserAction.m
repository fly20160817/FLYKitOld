//
//  FLYUserAction.m
//  ElevatorStandard
//
//  Created by fly on 2020/6/1.
//  Copyright © 2020 fly. All rights reserved.
//

#import "FLYUserAction.h"
//#import "FLYTabBarViewController.h"
//#import "FLYLoginViewController.h"
//#import "JPUSHService.h"

@implementation FLYUserAction

//+ (void)loginAction:(FLYUserModel *)info;
//{
//    //保存用户信息
//    [self saveUserInfo:info];
//    
//    
//    //设置别名
//    NSString * alias = [NSString stringWithFormat:@"%@", [FLYUser sharedUser].uid];
//    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//        
//        if ( iResCode == 0 )
//        {
//            FLYLog(@"别名设置成功: %@", iAlias);
//        }
//        else
//        {
//            FLYLog(@"别名设置失败：iResCode = %ld, iAlias = %@", (long)iResCode, iAlias);
//        }
//        
//    } seq:100];
//}
//
//
//+ (void)exitAction
//{
//    //清空用户信息
//    [FLYUser clearUser];
//    
//    
//    //删除别名
//    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//        if ( iResCode == 0 )
//        {
//            FLYLog(@"别名删除成功!");
//        }
//        else
//        {
//            FLYLog(@"别名删除失败：iResCode = %ld, iAlias = %@", (long)iResCode, iAlias);
//        }
//    } seq:100];
//    
//    
//    FLYTabBarViewController * tabVC = [[FLYTabBarViewController alloc] init];
//    [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
//    [tabVC presentViewController:[FLYLoginViewController loginNavVC] animated:YES completion:nil];
//}
//
//
//
//#pragma mark - private methods
//
//+ (void)saveUserInfo:(FLYUserModel *)userModel
//{
//    if ( [userModel.status isEqualToString:@"普通用户"] )
//    {
//        userModel.userType = FLYUserTypeNormal;
//    }
//    else if ( [userModel.status isEqualToString:@"艺术家"] )
//    {
//        if ( userModel.reviewStatus == 1)
//        {
//            userModel.userType = FLYUserTypeArtist;
//        }
//        else
//        {
//            userModel.userType = FLYUserTypeNormal;
//        }
//    }
//    else if ( [userModel.status isEqualToString:@"VIP"] )
//    {
//        userModel.userType = FLYUserTypeVIP;
//    }
//    
//    FLYUser * user = [FLYUser sharedUser];
//    user.uid = userModel.uid;
//    user.userName = userModel.userName;
//    user.nickName = userModel.nickName;
//    user.attention = userModel.attention;
//    user.attentionCount = userModel.attentionCount;
//    user.collectCount = userModel.collectCount;
//    user.commentCount = userModel.commentCount;
//    user.headPortrait = userModel.headPortrait;
//    user.isPerfect = userModel.isPerfect;
//    user.userType = userModel.userType;
//    user.token = userModel.token;
//    user.reviewStatus = userModel.reviewStatus;
//    user.status = userModel.status;
//    [FLYUser saveUser];
//}

@end
