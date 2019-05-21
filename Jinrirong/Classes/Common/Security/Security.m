//
//  Security.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/3/15.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "Security.h"
#import "NSString+MD5Extension.h"
#import "SecurityUtil.h"

#import "GTMBase64.h"
#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import "JSONKit.h"

//#import "NSString+Hash.h"

static Security *security = nil;



@implementation Security

+(instancetype)shareSecurity{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        security = [[Security alloc] init];
    });
    
    return security;
    
}



//-(NSString *)getTokenWithName:(NSString *)name withPsd:(NSString *)psd{
//
//
//    NSString *md5Name = [self nameMD5WithString:name];
//
//    md5Name = [md5Name md5].uppercaseString;
//
//    md5Name = [md5Name substringToIndex:30];
//
//    NSString *md5Psd = [self psdMD5WithString:psd];
//
//    md5Psd = [md5Psd md5].uppercaseString;
//
//    md5Psd = [md5Psd substringFromIndex:2];
//
//    NSString *result = [NSString stringWithFormat:@"%@%@",md5Name,md5Psd];
//
//    return result;
//}
//
//-(NSString *)psdMD5WithString:(NSString *)psd{
//
//    NSString *psdMD5 = [psd md5];
//
//    //后30位
//    psdMD5 = [psdMD5 substringFromIndex:2];
//
//    psdMD5 = psdMD5.uppercaseString;
//
//    psdMD5 = [psdMD5 md5];
//
//    //前30位
//    psdMD5 = [psdMD5 substringToIndex:30];
//
//
//    psdMD5 = psdMD5.uppercaseString;
//
//
//    NSString *result = [NSString stringWithFormat:@"XB%@",psdMD5];
//
//    return result;
//
//
//}
//
//-(NSString *)nameMD5WithString:(NSString *)name{
//
//    NSString *nameMD5 = [name md5];
//
//    nameMD5 = nameMD5.uppercaseString;
//
//    nameMD5 = [nameMD5 md5];
//
//    nameMD5 = nameMD5.uppercaseString;
//
//    nameMD5 = [nameMD5 substringFromIndex:2];
//
//    return nameMD5;
//}
//
//-(NSString *)keyMD5WIthName:(NSString *)md5name{
//
//    NSString *md5mobile = [[md5name md5] md5];
//
//    md5mobile =  [md5mobile substringWithRange:NSMakeRange(2 , 30)];
//
//    NSString *key = [NSString stringWithFormat:@"%@%@",md5mobile,[UDefault getObject:TICKS]];
//
//    key = [[key md5] substringWithRange:NSMakeRange(2 , 30)];
//
//    NSString *result = [NSString stringWithFormat:@"XB%@",key];
//
//    return result;
//}
//
//-(NSString *)ivMD5WIthName:(NSString *)md5name{
//
//    NSString *iv = [NSString stringWithFormat:@"%@%@",[md5name md5],[UDefault getObject:TICKSID]];
//
//    iv = [iv md5];
//
//    iv = [iv substringWithRange:NSMakeRange(2 , 14)];
//
//    NSString *result = [NSString stringWithFormat:@"XB%@",iv];
//
//    return result;
//}
//
//-(NSString *)getMD5Key{
//
//    NSString *key = [self keyMD5WIthName:[UDefault getObject:Key_Mobile]];
//
//    return key;
//}
//
//-(NSString *)getMD5Iv{
//
//    NSString *iv = [self ivMD5WIthName:[UDefault getObject:Key_Psw]];
//
//    return iv;
//}
//
//#pragma mark -256 AES加密
//
//- (NSString*)EncryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv{
//
//    NSString *encodeData = [SecurityUtil encryptAESData256:string withKey:key withIv:iv];
//    //    NSString *encodeData = [SecurityUtil encryptAESData128:string withKey:key withIv:iv];
//
//    return encodeData;
//}
//
//
//#pragma mark - 128AES解密
//
////- (NSString*)decryptAESData128:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv{
//
////    NSString *encodeData = [SecurityUtil decryptAESData128:string withKey:key withIv:iv];
//
////    return encodeData;
////}
//
//
//#pragma mark - 256AES解密
//
//- (NSString*)decryptAESData256:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv{
//
//    NSString *encodeData = [SecurityUtil decryptAESData256:string withKey:key withIv:iv];
//
//    return encodeData;
//
//}
////字符串转字典
//- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
//    if (jsonString == nil) {
//        return nil;
//    }
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    if(err) {
//        NSLog(@"json解析失败：%@",err);
//        return nil;
//    }
//    return dic;
//}
////字典转换为字符串
//- (NSString*)dictionaryToJson:(NSDictionary *)dic
//{
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//}
//
////256加密数据
//- (NSString*)encryptAES256Data:(NSDictionary *)dic{
//
//    return  [self EncryptAESData:[self dictionaryToJson:dic] withKey:[self getMD5Key] withIv:[self getMD5Iv]];
//
//}
////256加密数据
//- (NSString *)encryptAES256DataStr:(NSString *)str{
//
//    return   [self EncryptAESData:str withKey:[self getMD5Key] withIv:[self getMD5Iv]];
//
//}
//
////256解密数据
//- (NSDictionary*)decryptDicAES256Data:(NSString *)string{
//
//    NSString *key = [self keyMD5WIthName:[UDefault getObject:Key_Mobile]];
//
//    NSString *iv  = [self ivMD5WIthName:[UDefault getObject:Key_Psw]];
//
//    NSString *str = [self decryptAESData256:string withKey:key withIv:iv];
//
//    NSDictionary *dic = [self dictionaryWithJsonString:str];
//
//    return dic;
//}
//
////256解密数据 返回字符串
//- (NSString*)decryptStringAES256Data:(NSString *)string{
//
//    NSString *key = [self keyMD5WIthName:[UDefault getObject:Key_Mobile]];
//
//    NSString *iv  = [self ivMD5WIthName:[UDefault getObject:Key_Psw]];
//
//    NSString *str = [self decryptAESData256:string withKey:key withIv:iv];
//
//    return str;
//}
//
#pragma makr-----20180328wg 添加
-(NSString *)SecurityMD5WithString:(NSString *)psd{
    NSString *psdMD5 = [psd md5];
    psdMD5 = [psdMD5 substringWithRange:NSMakeRange(2, 30)];
    psdMD5 = [psdMD5 md5];
    return psdMD5;
}
//手机号加密两次  再取2-30位
-(NSString *)getTwoResultsForMD5:(NSString *)phoneString{

    return [[[phoneString md5] md5] substringWithRange:NSMakeRange(2 , 30)];
}
//手机号+时间戳（val）md5加密 前30位
-(NSString *)getMD5StringWithphoneStr:(NSString *)phoneString timeVal:(NSString *)timeV{

    NSString *phone = [self getTwoResultsForMD5:phoneString];
    return [[[NSString stringWithFormat:@"%@%@",phone,timeV] md5] substringToIndex:30];
}
//client客户端 +密码（规则是注册时候的规则）*md5+timeid 后md5 截取 2-30位
-(NSString *)getMD5StringWithClientStr:(NSString *)client timeID:(NSString *)timeidd pwdStr:(NSString *)pwsString{
//    NSString *mdPwdStr =[self SecurityMD5WithString:pwsString];
    return [[[NSString stringWithFormat:@"%@%@%@",client,[pwsString md5],timeidd] md5] substringWithRange:NSMakeRange(2, 30)];
}

///计算token并保存
-(NSString *)getTokenWithName:(NSString *)name withPsd:(NSString *)psd
{
    //设置的key
    [UDefault setObject:[self getKeyWithName:name] keys:MD5KEY];
    //设置的IV
    [UDefault setObject:[self getIvWithPwd:psd] keys:MD5IV];
    
    NSString *k = [self nameMD5WithString:name];
    
    NSString *c = [self psdMD5WithString:psd];
    //token
    NSString *result = [NSString stringWithFormat:@"%@%@",k,c];
    
    //    [UDefault setObject:result keys:TOKEN];本项目注释
    
    return result;
}

//对name md5加密
-(NSString *)nameMD5WithString:(NSString *)name{
    
    NSString *val = [UDefault getObject:TICKSVAL];
    
    name = [[name md5] md5];
    
    name =  [name substringWithRange:NSMakeRange(2 , 30)];
    
    NSString *nameMD5 = [NSString stringWithFormat:@"%@%@",name,val];
    
    nameMD5 = [nameMD5 md5];
    
    nameMD5 = [nameMD5 substringWithRange:NSMakeRange(0, 30)];
    
    return nameMD5;
}

//对psd md5加密
-(NSString *)psdMD5WithString:(NSString *)psd{
    
    NSString *ID = [UDefault getObject:TICKSID];
    
    NSString *psdMD5 = [NSString stringWithFormat:@"ios%@%@",[psd md5],ID];
    
    psdMD5 = [[psdMD5 md5] substringWithRange:NSMakeRange(2, 30)];
    
    return psdMD5;
    
}

///获取key
-(NSString *)getKeyWithName:(NSString *)name
{
    
    NSString *md5mobile = [[name md5] md5];
    
    md5mobile =  [md5mobile substringWithRange:NSMakeRange(2 , 30)];
    
    NSString *key = [NSString stringWithFormat:@"%@%@",md5mobile,[UDefault getObject:TICKSVAL]];
    
    key = [[key md5] substringWithRange:NSMakeRange(2 , 30)];
    
    NSString *result = [NSString stringWithFormat:@"XB%@",key];
    
    return result;
}

///获取Iv
-(NSString *)getIvWithPwd:(NSString *)pwd
{
    NSString *iv = [NSString stringWithFormat:@"%@%@",[pwd md5],[UDefault getObject:TICKSID]];
    
    iv = [iv md5];
    
    iv = [iv substringWithRange:NSMakeRange(2 , 14)];
    
    NSString *result = [NSString stringWithFormat:@"XB%@",iv];
    
    return result;
}

-(NSString *)getMD5Key{
    
    NSString *key = [UDefault getObject:MD5KEY];//[self keyMD5WIthName:[UDefault getObject:PHONENUM]];
    
    return key;
}

-(NSString *)getMD5Iv{
    
    NSString *iv = [UDefault getObject:MD5IV];//[self ivMD5WIthName:[UDefault getObject:PASSWORD]];
    
    return iv;
}

#pragma mark -256 AES加密

- (NSString*)EncryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv{
    
    NSString *encodeData = [SecurityUtil encryptAESData256:string withKey:key withIv:iv];
    //    NSString *encodeData = [SecurityUtil encryptAESData128:string withKey:key withIv:iv];
    
    return encodeData;
}


#pragma mark - 128AES解密

//- (NSString*)decryptAESData128:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv{

//    NSString *encodeData = [SecurityUtil decryptAESData128:string withKey:key withIv:iv];

//    return encodeData;
//}


#pragma mark - 256AES解密

- (NSString*)decryptAESData256:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv{
    
    NSString *encodeData = [SecurityUtil decryptAESData256:string withKey:key withIv:iv];
    
    return encodeData;
    
}
///字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
///字典转换为字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//256加密数据
- (NSString*)encryptAES256Data:(NSDictionary *)dic{
    
    return  [self EncryptAESData:[self dictionaryToJson:dic] withKey:[self getMD5Key] withIv:[self getMD5Iv]];
    
}
///256加密数据
- (NSString *)encryptAES256DataStr:(NSString *)str{
    
    return   [self EncryptAESData:str withKey:[self getMD5Key] withIv:[self getMD5Iv]];
    
}

///256解密数据
- (NSDictionary*)decryptDicAES256Data:(NSString *)string{
    
    NSString *key = [UDefault getObject:MD5KEY];
    
    NSString *iv  = [UDefault getObject:MD5IV];
    
    NSString *str = [self decryptAESData256:string withKey:key withIv:iv];
    
    
//    NSDictionary *dic = [str objectFromJSONStringWithParseOptions:JKParseOptionValidFlags error:nil];
    
    NSDictionary *dic = [self dictionaryWithJsonString:str];
    
    return dic;
}

///256解密数据 返回字符串
- (NSString*)decryptStringAES256Data:(NSString *)string{
    NSString *key = [UDefault getObject:MD5KEY];
    NSString *iv  = [UDefault getObject:MD5IV];
    NSString *str = [self decryptAESData256:string withKey:key withIv:iv];
    return str;
}

//存储 token key iv
-(void)storeToken:(NSString *)token Key:(NSString*)key IV:(NSString *)iv
{
    [UDefault setObject:token keys:TOKEN];
    [UDefault setObject:key keys:MD5KEY];
    [UDefault setObject:iv keys:MD5IV];
    
}
@end

