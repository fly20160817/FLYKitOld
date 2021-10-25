//
//  NSString+FLYExtension.h
//  FLYKit
//
//  Created by fly on 2021/10/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FLYExtension)


/// 数组、字典转json字符串
/// @param object 数组或字典
+ (NSString *)objectToJson:(id)object;


@end

NS_ASSUME_NONNULL_END
