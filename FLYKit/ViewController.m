//
//  ViewController.m
//  FLYKit
//
//  Created by fly on 2021/3/20.
//

#import "ViewController.h"
#import "FLYFileManager.h"
#import "NSDictionary+FLYUnicode.h"
#import "NSDate+FLYExtension.h"
#import "FLYTime.h"
#import "NSString+FLYEncryption.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    //两个date是否时同一天
    BOOL r = [calendar isDate:[NSDate date] inSameDayAsDate:[NSDate dateWithTimeIntervalSince1970:10]];
 
    NSLog(@"r = %d", r);
    
    
    NSLog(@"string = %@", [NSDate currentTimeStamp]);
    
    NSString * time = @"2020-8-31 11:18:00";
    NSDate * date2 = [FLYTime stringToDateWithString:time dateFormat:(FLYDateFormatTypeYMDHMS)];
    
    NSLog(@"date2 = %@", date2);
    
    NSInteger restrl = [NSDate calculateApartWithDate:[NSDate date] targetDate:date2 unitFlag:(FLYCalendarUnitHour)];
    NSLog(@"restrl = %ld", (long)restrl);
    
    
    
//    NSDate * date3 = [NSDate getDateAfter:[NSDate date] unitFlag:(NSCalendarUnitSecond) number:1];
//    NSLog(@"date3 = %@", [FLYTime dateToStringWithDate:date3 dateFormat:(FLYDateFormatTypeYMDHMS)]);
    
    NSInteger i = [NSDate compareDate:date2 targetDate:[NSDate date] unitFlag:FLYCalendarUnitHour];
    NSLog(@"i = %ld", (long)i);
    
    
    
    NSLog(@"timeString = %@", [NSDate timeString:date2]);
    
    
    NSString * str = @"fly!123*&%1FsF";
    
    NSLog(@"md5 = %@", [str md5]);
}




@end
