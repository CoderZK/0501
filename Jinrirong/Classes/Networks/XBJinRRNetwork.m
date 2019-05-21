//
//  XBJinRRNetwork.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRNetwork.h"
#import "SVProgressHUD.h"

@implementation XBJinRRNetwork
+ (void)postWithUrl:(NSString *)URL param:(NSDictionary *)param block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    //post请求
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,URL];
    //MyLog(@"请求url = %@",url);
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //MyLog(@"响应 = %@", responseObject);
        if ([responseObject[@"result"] integerValue] != 1) {
//            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
//            [Dialog toastCenter:responseObject[@"message"]];
        }
        if ([responseObject[@"result"] integerValue] == -1) {
            [UDefault setObject:@"" keys:TOKEN];
        }
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //数据请求失败，返回错误信息原因 error
        MyLog(@"出错 = %@", error);
//        [SVProgressHUD dismiss];
        fail(error);
    }];
}

+ (void)getWithUrl:(NSString *)URL param:(NSDictionary *)param block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    //get请求
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,URL];
    MyLog(@"请求url = %@",url);
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"响应 = %@", responseObject);
        if(responseObject!=NULL){
            if ([responseObject[@"result"] integerValue] != 1) {
                [Dialog toastCenter:responseObject[@"message"]];
            }
            if ([responseObject[@"result"] integerValue] == -1) {
                [UDefault setObject:@"" keys:TOKEN];
            }
        }
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"出错 = %@", error);
        fail(error);
    }];
}









#pragma mark -- 上传图片
+ (void)uplodatImageWithpath:(NSString *)url imgeData:(NSData *)data name:(NSString *)name Block:(void (^)(id data, NSError * error))block
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableDictionary * param = [@{@"client":@"ios",
                                                                     @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                                                     @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                                                     @"token":[UDefault getObject:TOKEN],
                                     
                                     } mutableCopy];
    NSString *URLString = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    MyLog(@"%@",URLString);
    
    //上传服务器
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png", nil];
    [manager POST:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
        [formData appendPartWithFileData:data name:@"img" fileName:fileName mimeType:@"image/png"];
        //        MYLog(@"%@",formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        MyLog(@"%f",uploadProgress.fractionCompleted);
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        block(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        block(nil,error);
        
    }];
    
}





@end
