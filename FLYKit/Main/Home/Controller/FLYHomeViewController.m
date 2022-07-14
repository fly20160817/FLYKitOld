//
//  FLYHomeViewController.m
//  FLYKit
//
//  Created by fly on 2021/9/7.
//

#import "FLYHomeViewController.h"
#import "UICollectionView+FLYRefresh.h"
#import "FLYExceptionView.h"

@interface FLYHomeViewController () < UICollectionViewDataSource >

@property (nonatomic, strong) UICollectionView * tableView;

@end

@implementation FLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showNavLine = YES;
    
    [self testAtion];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)testAtion
{
    UICollectionViewLayout * layout = [[UICollectionViewLayout alloc] init];
    self.tableView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:self.tableView.cellReuseIdentifier];
    [self.view addSubview:self.tableView];
    
    FLYExceptionView * view = [[FLYExceptionView alloc] init];
    view.title = @"凤凰网iu划分为iu好";
    view.subtitle = @"fhwiufhwih";
    view.image = [UIImage imageNamed:@"Message.ico_on"];
    self.tableView.exceptionView = view;
    
    
    
    NSArray * array = @[@"", @"", @"", @"", @""];
    NSArray * array2 = @[];
    [self.tableView loadDataSuccess:array2];
    
    //[self.tableView loadDataFailed:nil];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    FLYScanCodeViewController * vc = [[FLYScanCodeViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - UITableViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return collectionView.dataList.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionView.cellReuseIdentifier forIndexPath:indexPath];
    
//    UILabel * label = [[UILabel alloc] initWithFrame:cell.bounds];
//    label.backgroundColor = [UIColor orangeColor];
//    [cell.contentView addSubview:label];
//    label.textColor = [UIColor redColor];
//
//    label.text = [NSString stringWithFormat:@"fly - %ld", (long)indexPath.item];
    
    cell.contentView.backgroundColor = [UIColor yellowColor];
    
    return cell;
}



/*
 
//解密
- (void)decrypt
{
    NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCs38lU+0hBvf4Q+tFbsY6phKmvBT1m++VTGVRLsbuNP3hwI2mnz7dlXXHnfWNpTras1A7XvKHXlLlvHC0ii+slp9KUUEJc2pZ6JjqOTQyvJGXJRb+l8YTrkEQnqyeRJqHIJBtXjWvGJr+m44dHGOMSzzULhXXuNIyCRZRy/Phu7wIDAQAB\n-----END PUBLIC KEY-----";
    
    NSString *privkey = @"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKzfyVT7SEG9/hD60VuxjqmEqa8FPWb75VMZVEuxu40/eHAjaafPt2Vdced9Y2lOtqzUDte8odeUuW8cLSKL6yWn0pRQQlzalnomOo5NDK8kZclFv6XxhOuQRCerJ5EmocgkG1eNa8Ymv6bjh0cY4xLPNQuFde40jIJFlHL8+G7vAgMBAAECgYBzWffrnqh+RZpMFjCwcG/zKTRYNrTcDOTeaB5ZS8UL4PgqS1bqxK1pE8s3XfGBiSZXeEBXL+UGBpUdUL3FOXuzTTKcoMkJLvO+EXupOYhbFek2gKbUS5DZftbxRbxVk3nNMBPeueUvCQjp2SDU3CP8o1rrEdCqlL4kxbKbTh2RoQJBAPx+lWhdzvmDLeHzPo1Z9F24te3Tl/SQ8gFR5ayJYmDqFVZKmuQmKL75tb89ED1FFWQTqnJPZ5tPXuea32Tep2cCQQCvRjdXykT75Lp4Csmi0QPebic5iw7sJSGjLPBNbZv/1D07F/cKK2sMDShnfbUCFdqgItQaijgHO7NtAwrohO85AkEArs8Ap8ISssJ0OLPMgdZejah9JEvTL3pOYkWOCncPSmOmJBkAxaX5ncaKYv1mydSTa7cF0aBR7b/0x8p8kXxpTwJADoWs1DNIH+7FnGiYaEsVHPrXeScSZ3J0JQb2KhQo1ruJDzpfF5KdXfRBIsIBm1igMqBwHnrRRZgmt6OG5dkN0QJBAOd1UpfyQqot0tGeHjppTNGOvcfoqIz7zT1DLtd++lb4vjSlETTH7loEZMBz+rbkjuUbrVCDL/o4GZVy2/i2ukU=\n-----END PRIVATE KEY-----";
    
    
    
    //key的密文
    NSString * string1 = @"cOnNOCsVhdd6HDij5NPHXs4L4IRdgrrlDIr+HA56598iLEqsr5vYWzILo4R3FI5CQ+Mel28g6PE7sujdsC8loJu2dKrE1Dark1l9eAbRtOhfAfc4vdXST/tn35J4r9OrfArwEOX8s4tYiAjqLk9zrtKhADwd/i8Zr1Yvdx8eqhM=";
    
    NSString * decryptString = [FLYRSA decryptString:string1 privateKey:privkey];
    NSLog(@"RSA解密完成，获取到AES的key: %@", decryptString);
    

    //内容的密文
    NSString * string2 = @"aL9MQlWiusSr0LgoIODPrLZ8kwrwFMIwdwDhGg/SA9waGYGJDpE4noN8+2p+VA/ioLrX3bs4It17qGNuZOhamQ==";
    
    NSString * content = [FLYAES aes128DecryptionReturnString:string2 key:decryptString];
    NSLog(@"AES解密完成，解密得到的内容:%@", content);
}

 */


@end


