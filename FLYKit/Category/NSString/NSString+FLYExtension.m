//
//  NSString+FLYExtension.m
//  FLYKit
//
//  Created by fly on 2021/10/15.
//

#import "NSString+FLYExtension.h"

@implementation NSString (FLYExtension)

/// 数组、字典转json字符串
/// @param object 数组或字典
+ (NSString *)objectToJson:(id)object
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end
