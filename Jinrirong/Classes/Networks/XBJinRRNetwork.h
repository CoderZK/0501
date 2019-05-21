//
//  XBJinRRNetwork.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRNetwork : NSObject

+ (void)postWithUrl:(NSString *)URL param:(NSDictionary *)param block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;
+ (void)getWithUrl:(NSString *)URL param:(NSDictionary *)param block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 上传图片
+ (void)uplodatImageWithpath:(NSString *)url imgeData:(NSData *)data name:(NSString *)name Block:(void (^)(id data, NSError * error))block;
@end
