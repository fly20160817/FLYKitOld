//
//  NSString+FLYEncryption.h
//  FLYKit
//
//  Created by fly on 2021/8/31.
//

/**
 加密
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FLYEncryption)

/// md5加密 （32位小写）
- (NSString *)md5;

@end

NS_ASSUME_NONNULL_END
