//
//  FLYHomeViewController.m
//  FLYKit
//
//  Created by fly on 2021/9/7.
//

#import "FLYHomeViewController.h"
#import "FLYNavigationController.h"

#import "FLYRSA.h"
#import "FLYAES.h"


@interface FLYHomeViewController ()

@end

@implementation FLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ((FLYNavigationController*)(self.navigationController)).isLine = YES;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testAtion];
}

- (void)testAtion
{
    NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCs38lU+0hBvf4Q+tFbsY6phKmvBT1m++VTGVRLsbuNP3hwI2mnz7dlXXHnfWNpTras1A7XvKHXlLlvHC0ii+slp9KUUEJc2pZ6JjqOTQyvJGXJRb+l8YTrkEQnqyeRJqHIJBtXjWvGJr+m44dHGOMSzzULhXXuNIyCRZRy/Phu7wIDAQAB\n-----END PUBLIC KEY-----";
    
    NSString *privkey = @"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKzfyVT7SEG9/hD60VuxjqmEqa8FPWb75VMZVEuxu40/eHAjaafPt2Vdced9Y2lOtqzUDte8odeUuW8cLSKL6yWn0pRQQlzalnomOo5NDK8kZclFv6XxhOuQRCerJ5EmocgkG1eNa8Ymv6bjh0cY4xLPNQuFde40jIJFlHL8+G7vAgMBAAECgYBzWffrnqh+RZpMFjCwcG/zKTRYNrTcDOTeaB5ZS8UL4PgqS1bqxK1pE8s3XfGBiSZXeEBXL+UGBpUdUL3FOXuzTTKcoMkJLvO+EXupOYhbFek2gKbUS5DZftbxRbxVk3nNMBPeueUvCQjp2SDU3CP8o1rrEdCqlL4kxbKbTh2RoQJBAPx+lWhdzvmDLeHzPo1Z9F24te3Tl/SQ8gFR5ayJYmDqFVZKmuQmKL75tb89ED1FFWQTqnJPZ5tPXuea32Tep2cCQQCvRjdXykT75Lp4Csmi0QPebic5iw7sJSGjLPBNbZv/1D07F/cKK2sMDShnfbUCFdqgItQaijgHO7NtAwrohO85AkEArs8Ap8ISssJ0OLPMgdZejah9JEvTL3pOYkWOCncPSmOmJBkAxaX5ncaKYv1mydSTa7cF0aBR7b/0x8p8kXxpTwJADoWs1DNIH+7FnGiYaEsVHPrXeScSZ3J0JQb2KhQo1ruJDzpfF5KdXfRBIsIBm1igMqBwHnrRRZgmt6OG5dkN0QJBAOd1UpfyQqot0tGeHjppTNGOvcfoqIz7zT1DLtd++lb4vjSlETTH7loEZMBz+rbkjuUbrVCDL/o4GZVy2/i2ukU=\n-----END PRIVATE KEY-----";
    
    
    NSString * string = @"cOnNOCsVhdd6HDij5NPHXs4L4IRdgrrlDIr+HA56598iLEqsr5vYWzILo4R3FI5CQ+Mel28g6PE7sujdsC8loJu2dKrE1Dark1l9eAbRtOhfAfc4vdXST/tn35J4r9OrfArwEOX8s4tYiAjqLk9zrtKhADwd/i8Zr1Yvdx8eqhM=";
    
    //公钥加密的结果
    //NSString * encString = [FLYRSA encryptString:string publicKey:pubkey];
    
    //私钥解密的结果
    NSString * decString = [FLYRSA decryptString:string privateKey:privkey];
    
    //NSLog(@"公钥加密的结果: %@", encString);
    NSLog(@"私钥解密的结果: %@", decString);
    
    
    
    //私钥加密的结果
    //NSString * encString1 = [FLYRSA encryptString:string privateKey:privkey];
    
    //公钥解密的结果
    //NSString * decString1 = [FLYRSA decryptString:string publicKey:pubkey];
    
    //NSLog(@"私钥加密的结果: %@", encString1);
    //NSLog(@"公钥解密的结果: %@", decString1);
    

    NSString * asa = @"aL9MQlWiusSr0LgoIODPrLZ8kwrwFMIwdwDhGg/SA9waGYGJDpE4noN8+2p+VA/ioLrX3bs4It17qGNuZOhamQ==";
    NSString * aes111 = [FLYAES aes128DecryptionReturnString:asa key:decString];
    
    NSLog(@"aes111 = %@", aes111);
    
}



@end


