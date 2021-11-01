//
//  FLYKeychain.m
//  FLYKit
//
//  Created by fly on 2021/11/1.
//

#import "FLYKeychain.h"
#import <Security/Security.h>
#import <UIKit/UIKit.h>

@implementation FLYKeychain

//构建存取条件
+ (NSMutableDictionary *)keychainDicWithAccountId:(NSString *)accountId andServiceId:(NSString *)serviceId
{
    /****************************
     构建存取条件，实质就是一个字典。
     这些条件指定了要存取的这条内容的存取类型、唯一性、存取策略和内容。
     ****************************/
    
    
    NSString *classKey = (__bridge NSString *)kSecClass;
    //指定服务类型是普通密码
    NSString *classValue = (__bridge NSString *)kSecClassGenericPassword;
    
    NSString *accessibleKey = (__bridge NSString *)kSecAttrAccessible;
    //指定安全类型是任何时候都可以访问
    NSString *accessibleValue = (__bridge NSString *)kSecAttrAccessibleAlways;
    
    
    /*
    账户名需要预防重名,因为keychain是系统级的,配置了keychain-sharing的其他App也可以访问,一般使用类似bundleId的写法
    服务名称就好像给宏取名字,表示存储的这个东西是做什么的.
    通过这两个key就可以指定唯一性
     */
    
    NSString *accountKey = (__bridge NSString *)kSecAttrAccount;
    //指定服务的账户名 （可以与服务名相同，账户名可以对应多个服务名）
    NSString *accountValue = accountId;
    
    NSString *serviceKey = (__bridge NSString *)kSecAttrService;
    //指定服务的名字 可以与服务账户名相同
    NSString *serviceValue = serviceId;
    
    NSDictionary *keychainItems = @{classKey      : classValue,
                                    accessibleKey : accessibleValue,
                                    accountKey    : accountValue,
                                    serviceKey    : serviceValue};
    
    return keychainItems.mutableCopy;
}


/// 新增数据
/// @param data 数据
/// @param accountId 账户名 (账户名需要预防重名,因为keychain是系统级的,配置了keychain-sharing的其他App也可以访问,一般使用类似bundleId的写法)
/// @param serviceId 服务名 (服务名称就好像给宏取名字，表示存储的这个东西是做什么的，可以与账户名相同，账户名可以对应多个服务名)
+ (BOOL)keychainSaveData:(id)data accountId:(NSString *)accountId serviceId:(NSString *)serviceId
{
    // 获取存储的数据的条件
    NSMutableDictionary * saveQueryDic = [self keychainDicWithAccountId:accountId andServiceId:serviceId];
    // 删除旧的数据
    SecItemDelete((CFDictionaryRef)saveQueryDic);
    // 设置新的数据
    [saveQueryDic setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    // 添加数据
    OSStatus saveState = SecItemAdd((CFDictionaryRef)saveQueryDic, nil);
    // 释放对象
    saveQueryDic = nil ;
    // 判断是否存储成功
    if (saveState == errSecSuccess)
    {
        NSLog(@"服务：%@，保存成功", serviceId);
        return YES;
    }
    
    NSLog(@"服务：%@，保存失败", serviceId);
    return NO;
}

/// 查询数据
/// @param accountId 账户名
/// @param serviceId 服务名
+ (id)keychainGetDataWithAccountId:(NSString *)accountId serviceId:(NSString *)serviceId
{
    id idObject = nil ;
    // 通过标记获取数据查询条件
    NSMutableDictionary * readQueryDic = [self keychainDicWithAccountId:accountId andServiceId:serviceId];
    // 查询结果返回到 kSecValueData (此项必选)
    [readQueryDic setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    // 只返回搜索到的第一条数据 (此项必选)
    [readQueryDic setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    // 创建一个对象接受结果
    CFDataRef keyChainData = nil ;
    
    // 通过条件查询数据
    if (SecItemCopyMatching((CFDictionaryRef)readQueryDic , (CFTypeRef *)&keyChainData) == noErr)
    {
        @try
        {
            //转换类型
            idObject = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)(keyChainData)];
        }
        @catch (NSException * exception)
        {
            NSLog(@"keychain没有搜索到任何数据，serviceId = %@，exception = %@",serviceId, exception);
        }
    }
    
    if (keyChainData)
    {
        CFRelease(keyChainData);
    }
    readQueryDic = nil;
    
    // 返回数据
    return idObject ;
}

/// 更新数据
/// @param data 数据
/// @param accountId 账户名
/// @param serviceId 服务名
+ (BOOL)keychainUpdataData:(id)data accountId:(NSString *)accountId serviceId:(NSString *)serviceId
{
    // 通过标记获取数据更新的条件
    NSMutableDictionary * updataQueryDic = [self keychainDicWithAccountId:accountId andServiceId:serviceId];
    // 创建更新数据字典
    NSMutableDictionary * newDic = @{}.mutableCopy;
    // 存储数据
    [newDic setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    // 获取存储的状态
    OSStatus  updataStatus = SecItemUpdate((CFDictionaryRef)updataQueryDic, (CFDictionaryRef)newDic);
    updataQueryDic = nil;
    newDic = nil;
    // 判断是否更新成功
    if (updataStatus == errSecSuccess)
    {
        NSLog(@"服务：%@，更新成功", serviceId);
        return  YES ;
    }
    NSLog(@"服务：%@，更新失败", serviceId);
    return NO;
}

/// 删除数据
/// @param accountId 账户名
/// @param serviceId 服务名
+ (void)keychainDeleteDataWithAccountId:(NSString *)accountId serviceId:(NSString *)serviceId
{
    // 获取删除数据的查询条件
    NSMutableDictionary * deleteQueryDic = [self keychainDicWithAccountId:accountId andServiceId:serviceId];
    // 删除指定条件的数据
    SecItemDelete((CFDictionaryRef)deleteQueryDic);
    deleteQueryDic = nil ;
}




/*
 本方法是得到 IDFV 后存入系统中的 keychain 的方法
 程序删除后重装，仍可以得到相同的唯一标示。
 但是当还原设备或者刷机后，系统中的钥匙串会被清空，获取到的就是新的IDFV。
 */
+ (NSString *)getIDFVInKeychain;
{
    //从 Keychain 中获取保存的difv
    NSString * difv = [FLYKeychain keychainGetDataWithAccountId:APP_BUNDLEIDENTIFIER serviceId:@"IDFV"];
    
    //如果在Keychain中没获取到，通过UIDevice获取，然后保存到Keychain中。
    if( difv == nil)
    {
        difv = UIDevice.currentDevice.identifierForVendor.UUIDString;
        
        [FLYKeychain keychainSaveData:difv accountId:APP_BUNDLEIDENTIFIER serviceId:@"IDFV"];
    }
    
    return difv;
}

@end
