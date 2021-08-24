//
//  FLYMacros.h
//  Elevator
//
//  Created by fly on 2018/11/8.
//  Copyright © 2018年 fly. All rights reserved.
//

#ifndef FLYMacros_h
#define FLYMacros_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height


#ifdef DEBUG
#define FLYLog(...) NSLog(__VA_ARGS__)
#else
#define FLYLog(...)
#endif

#define kWeakSelf __weak typeof(self) weakSelf = self;
#define kStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

#define RGB(r,g,b,a) [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:a]

//状态栏高度
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

//导航栏高度
#define NAVBAR_HEIGHT self.navigationController.navigationBar.frame.size.height

//状态栏高度+导航栏高度
#define STATUSADDNAV_HEIGHT (STATUSBAR_HEIGHT + NAVBAR_HEIGHT)

//tabber高度
#define TABBER_HEIGHT self.tabBarController.tabBar.frame.size.height


#define COLORHEX(hex) [UIColor colorWithHexString:hex]

#define FONT_R(font) [UIFont fontWithName:PFSCR size:font]
#define FONT_M(font) [UIFont fontWithName:PFSCM size:font]
#define FONT_S(font) [UIFont fontWithName:PFSCS size:font]
#define FONT_L(font) [UIFont fontWithName:PFSCL size:font]
#define FONT_U(font) [UIFont fontWithName:PFSCU size:font]
#define FONT_T(font) [UIFont fontWithName:PFSCT size:font]


//苹方-简 常规体
#define PFSCR @"PingFangSC-Regular"
//苹方-简 中黑体
#define PFSCM @"PingFangSC-Medium"
//苹方-简 中粗体
#define PFSCS @"PingFangSC-Semibold"
//苹方-简 细体
#define PFSCL @"PingFangSC-Light"
//苹方-简 极细体
#define PFSCU @"PingFangSC-Ultralight"
//苹方-简 纤细体
#define PFSCT @"PingFangSC-Thin"



//正确返回码
#define CODE_CORRECT @"200"
//服务器状态码字段
#define SERVER_STATUS @"status"
//服务器消息字段
#define SERVER_MSG @"msg"
//服务器数据字段
#define SERVER_DATA @"data"



#pragma mark - 高度封装

#define FLYRequestErrorHUD [HttpTool getNetType:^(BOOL network) { [SVProgressHUD showInfoWithStatus:network ? @"服务器异常，请稍后重试。" : @"您的网络好像出现了问题"];[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];}];


#endif

