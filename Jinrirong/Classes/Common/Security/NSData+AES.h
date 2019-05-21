//
//  NSData+AES.h
//  Smile
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //AES128加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //AES128解密
- (NSData *) AES256_Encrypt:(NSString *)key withIV:(NSString *)gIv;    //AES256加密
- (NSData *) AES256_Decrypt:(NSString *)key withIV:(NSString *)gIv;    //AES256解密

@end
