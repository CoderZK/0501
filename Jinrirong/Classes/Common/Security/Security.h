//
//  Security.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/3/15.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Security : NSObject

+(instancetype)shareSecurity;

//-(NSString *)SecurityMD5WithString:(NSString *)psd;
/////计算Token
//-(NSString *)getTokenWithName:(NSString *)name withPsd:(NSString *)psd;
//
//-(NSString *)psdMD5WithString:(NSString *)psd;
//
//-(NSString *)nameMD5WithString:(NSString *)name;
//
//-(NSString *)keyMD5WIthName:(NSString *)md5name;
//
//-(NSString *)ivMD5WIthName:(NSString *)md5iv;
//
//
//- (NSString*)decryptAESData256:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv;
//
//- (NSString*)decryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv;
//
//
//- (NSString*)EncryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv;
//
-(NSString *)SecurityMD5WithString:(NSString *)psd;
//
-(NSString *)getTwoResultsForMD5:(NSString *)phoneString;
//
//手机号+时间戳（val）md5加密 前30位
-(NSString *)getMD5StringWithphoneStr:(NSString *)phoneString timeVal:(NSString *)timeV;
//
//client客户端 +密码（规则是注册时候的规则）+timeid 后md5 截取 2-30位
-(NSString *)getMD5StringWithClientStr:(NSString *)client timeID:(NSString *)timeidd pwdStr:(NSString *)pwsString;
//
//-(NSString *)getMD5Key;
//
//-(NSString *)getMD5Iv;
//
//- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//
//- (NSString*)dictionaryToJson:(NSDictionary *)dic;
//
////加密数据
//- (NSString*)encryptAES256Data:(NSDictionary *)dic;
//
////加密数据
//- (NSString*)encryptAES256DataStr:(NSString *)str;
//
//
////解密数据
//- (NSDictionary*)decryptDicAES256Data:(NSString *)string;
//
////解密数据
//- (NSString*)decryptStringAES256Data:(NSString *)string;

///计算Token
-(NSString *)getTokenWithName:(NSString *)name withPsd:(NSString *)psd;

-(NSString *)psdMD5WithString:(NSString *)psd;

-(NSString *)nameMD5WithString:(NSString *)name;
///计算key
-(NSString *)keyMD5WIthName:(NSString *)md5name;
///计算IV
-(NSString *)ivMD5WIthName:(NSString *)md5iv;

- (NSString*)decryptAESData256:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv;

- (NSString*)decryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv;

- (NSString*)EncryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv;

-(NSString *)getMD5Key;

-(NSString *)getMD5Iv;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

- (NSString*)dictionaryToJson:(NSDictionary *)dic;

//加密数据
- (NSString*)encryptAES256Data:(NSDictionary *)dic;

//加密数据
- (NSString*)encryptAES256DataStr:(NSString *)str;


//解密数据
- (NSDictionary*)decryptDicAES256Data:(NSString *)string;

//解密数据
- (NSString*)decryptStringAES256Data:(NSString *)string;
//存储 token key iv
-(void)storeToken:(NSString *)token Key:(NSString*)key IV:(NSString *)iv;
@end

