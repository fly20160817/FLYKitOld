//
//  NSString+FLYHandle.m
//  FLYKit
//
//  Created by fly on 2021/10/13.
//

#import "NSString+FLYHandle.h"

@implementation NSString (FLYHandle)

/// 给电话号码中间部位打码 (手机号、固定电话都行)
- (NSString *)phoneNumEncode
{
    NSString * string = @"";
    
    if ( self.length >= 7 )
    {
        //判断是否是纯数字，固定电话里可能包含()-等符号
        NSScanner * scanner = [NSScanner scannerWithString:self];
        int value;
        //scanInt:扫描整形数字
        //isAtEnd 扫描是否正常结束，如果扫描遇到非数字，都会异常结束。
        BOOL isNumber = [scanner scanInt:&value] && [scanner isAtEnd];
        
        
        //固定电话打码
        if ( isNumber == NO )
        {
            //0518-873***76  倒数第二位往前3个打码
            NSRange range = NSMakeRange(self.length - 5, 3);
            string = [self stringByReplacingCharactersInRange:range withString:@"***"];
        }
        //手机号打码
        else
        {
            //183****2905   第3位往后4个打码
            NSRange range = NSMakeRange(3, 4);
            string = [self stringByReplacingCharactersInRange:range withString:@"****"];
        }
    }
    else
    {
        //号码小于7位，其实已经不是号码了，这里还是做了处理，除了第一位和最后一位，其他位全部打码
        
        NSMutableString * string1 = [NSMutableString stringWithString:self];
        
        for ( int i = 0; i < self.length; i++ )
        {
            if ( i != 0 && i != self.length - 1 )
            {
                [string1 replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        
        string = string1.copy;
    }
    
    return string;
}


/// 给邮箱中间部位打码
- (NSString *)emailEncode
{
    if( [self containsString:@"@"] == NO )
    {
        NSLog(@"邮箱格式错误，无法打码");
        return self;
    }
    
    
    NSArray * array = [self componentsSeparatedByString:@"@"];
    NSString * firstString = array.firstObject;
    
    
    //号码小于4位，除了第一位和最后一位，其他位全部打码
    if ( firstString.length < 4 )
    {
        NSMutableString * string = [NSMutableString stringWithString:self];
        
        for ( int i = 0; i < firstString.length; i++ )
        {
            if ( i != 0 && i != firstString.length - 1 )
            {
                [string replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        
        firstString = string.copy;
    }
    //小于8位，打2个*
    else if ( firstString.length < 8 )
    {
        NSRange range = NSMakeRange(firstString.length - 4, 2);
        firstString = [firstString stringByReplacingCharactersInRange:range withString:@"**"];
    }
    //大于等于8位，打3个*
    else
    {
        NSRange range = NSMakeRange(firstString.length - 5, 3);
        firstString = [firstString stringByReplacingCharactersInRange:range withString:@"***"];
    }
    
    
    NSString * emailString = [NSString stringWithFormat:@"%@@%@", firstString, array.lastObject];
    
    return emailString;
}


/// 从字符串里提取数字 (只能提取一处数字，多处数字提取不出来。例："原价66元"可以提取；"原价66元10个"无法提取)
- (NSString *)extractNum
{
    NSCharacterSet * nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString * numString = [self stringByTrimmingCharactersInSet:nonDigits];
    
    return numString;
}


@end
