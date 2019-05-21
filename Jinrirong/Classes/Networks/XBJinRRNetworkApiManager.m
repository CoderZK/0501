//
//  XBJinRRNetworkApiManager.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRNetworkApiManager.h"
#import "XBJinRRNetwork.h"
#import "SVProgressHUD.h"
#import "Security.h"

@implementation XBJinRRNetworkApiManager
#pragma mark - 首页banner
+ (void)getAdsWithAid:(NSString *)aid num:(NSString *)num block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"home/home/ads";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"aid":aid,
                            @"num":num
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 滚动字幕
+ (void)getNoticeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"Home/home/getnotice";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}


#pragma mark - 获取 首页板块 列表
+ (void)getPlateWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
    //    [SVProgressHUD show];
    NSString *url = @"Home/home/getplate";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
        //        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
        //        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}


#pragma mark - 获取贷款类型
+ (void)getCateWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"Home/home/getcate";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"rows":@"8"
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 获取智能推荐网贷，热门网贷列表
+ (void)getItemsWithIsrec:(NSString *)isrec rows:(NSString *)rows block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"Home/home/getitems";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"isrec":isrec,
                            @"rows":rows
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 获取 金额类型信息  列表
+ (void)getMoneyTypeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"Home/items/getmoneytype";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}



#pragma mark - 获取借贷期限
+ (void)getMoneyJktimesBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"Home/items/getjktimes";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}

#pragma mark - 获取 我有的贷款类型  列表
+ (void)getCateTypeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"Home/items/getcate";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 获取 所需材料  列表
+ (void)getNeedTypeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"Home/items/getneed";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}

#pragma mark - 获取 网贷信息 列表
+ (void)getItemsWithPage:(NSInteger)page rows:(NSInteger)rows tid:(NSString *)tid cid:(NSString *)cid nids:(NSString *)nids  jkday:(NSString *)jkday block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSString *url = @"Home/Items/getitems";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"page":@(page),
                            @"rows":@(rows),
                            @"tid":[NSString stringWithFormat:@"%@",tid],
                            @"cid":[NSString stringWithFormat:@"%@",cid],
                            @"nids":[NSString stringWithFormat:@"%@",nids],
                            @"jkday":[NSString stringWithFormat:@"%@",jkday]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
#pragma mark - 验证图形验证码接口
+ (void)getCheckImgCodeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"core/public/checkimgcode";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 获取手机验证码
+ (void)getPhoneCodeWithMobile:(NSString *)mobile type:(NSString *)type code:(NSString *)code block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
    [SVProgressHUD show];
    NSString *url = @"core/tool/getcode";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"Mobile":mobile,
                            @"type":type,
                            @"code":code
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 会员注册接口
+ (void)registerWithMobile:(NSString *)mobile code:(NSString *)code password:(NSString *)password rid:(NSString *)rid block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"center/Register/reg";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"Mobile":[NSString stringWithFormat:@"%@",mobile],
                            @"Code":[NSString stringWithFormat:@"%@",code],
                            @"Password":[NSString stringWithFormat:@"%@",password]
                            };
    [XBJinRRNetwork postWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 登录
+ (void)loginWithMobile:(NSString *)mobile token:(NSString *)token device_token:(NSString *)device_token block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail{
//    [SVProgressHUD show];
    NSString *url = @"center/member/login";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"mobile":mobile,
                            @"token":token,
                            @"DeviceToken":device_token,
                            @"ticksid":[[NSUserDefaults standardUserDefaults] stringForKey:TICKSID],
                            @"ticks":[[NSUserDefaults standardUserDefaults] stringForKey:TICKSVAL]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 获取时间戳
+ (void)requestTimestampWithPhone:(NSString *)phone Psw:(NSString *)psw block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
    NSString *url = @"core/tool/timestamp";
    NSDictionary *param = @{
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"client":@"ios",
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
        [SVProgressHUD dismiss];
        
        block(data);
    } fail:^(NSError *errorString) {
        [SVProgressHUD dismiss];
        fail(errorString);
    }];
    
}
#pragma mark - 获取会员信息
+ (void)getPersonInfoBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"center/member/info";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"token":isEmptyStr([UDefault getObject:TOKEN])?@"f007":[UDefault getObject:TOKEN]
                            };
    [XBJinRRNetwork postWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        if (rusultIsCorrect) {
            NSDictionary *dataDic = [[Security shareSecurity] decryptDicAES256Data:data[@"data"]];
            block(dataDic);
        }else{
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            NSError *err;
            fail(err);
        }
        
        
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 获取  单页信息（关于我们，注册协议等）   页面
+ (void)getPageWithID:(NSString *)ID block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
    [SVProgressHUD show];
    NSString *url = @"Home/News/getpages";
    NSDictionary *param = @{
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"client":@"ios",
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"id":ID
                            };
    [XBJinRRNetwork getWithUrl:url param:param block:^(id data) {
        [SVProgressHUD dismiss];
        
        block(data);
    } fail:^(NSError *errorString) {
        [SVProgressHUD dismiss];
        fail(errorString);
    }];
    
}
#pragma mark - 获取 我的消息
+ (void)getMyMsgWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"center/member/mynews";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"token":[UDefault getObject:TOKEN]
                            };
    [XBJinRRNetwork postWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}
#pragma mark - 分享推广
+ (void)shareWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
//    [SVProgressHUD show];
    NSString *url = @"center/member/share";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"token":[UDefault getObject:TOKEN]
                            };
    [XBJinRRNetwork postWithUrl:url param:param block:^(id data) {
//        [SVProgressHUD dismiss];
        block(data);
    } fail:^(NSError *errorString) {
//        [SVProgressHUD dismiss];
        fail(errorString);
    }];
}





#pragma mark - 退出登录
+ (void)logOutBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSString *url = @"center/Member/layout";
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"token":[UDefault getObject:TOKEN]
                            };
    [XBJinRRNetwork postWithUrl:url param:param block:^(id data) {
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 获取网页
+ (void)getTitleContentWithID:(NSInteger)ID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"id":[NSString stringWithFormat:@"%ld",(long)ID]
                            };
    [XBJinRRNetwork getWithUrl:@"Home/News/getpages" param:param block:^(id data) {
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
    
}


#pragma mark -- 修改密码
+ (void)changePwdWithParams:(NSDictionary *)params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = [@{@"client":@"ios",
                                    @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                    @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                    @"token":[UDefault getObject:TOKEN],
                                    @"dynamic":[[Security shareSecurity] encryptAES256Data:params]
                                    } mutableCopy];
//    [paramDic addEntriesFromDictionary:params];
    MyLog(@"更改密码传参 -- %@",paramDic);
    NSDictionary *dataDic = [[Security shareSecurity] decryptDicAES256Data:paramDic[@"dynamic"]];
    MyLog(@"加密后解密出来的字典 -- %@",dataDic);
    
    [XBJinRRNetwork postWithUrl:@"center/Member/change_psd" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}




#pragma mark -- 修改密码页面验证手机号和验证码是否正确
+ (void)checkCodeIsMatchWithPhoneByParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            
                            }.mutableCopy;
    [param addEntriesFromDictionary:Params];
    [SVProgressHUD show];
    [XBJinRRNetwork getWithUrl:@"center/register/forgetOne" param:param block:^(id data) {
        block(data);
        [SVProgressHUD dismiss];
    } fail:^(NSError *errorString) {
        fail(errorString);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark -- 修改密码-重置密码
+ (void)resetPwdWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *param = @{@"client":@"ios",
                                   @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                   @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                   
                                   }.mutableCopy;
    [param addEntriesFromDictionary:Params];
    [XBJinRRNetwork getWithUrl:@"center/register/forgetTwo" param:param block:^(id data) {
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}



#pragma mark  上传图片获取url
+ (void )postImage:(NSData *)imageData Block:(void (^)(id data,NSError * error))block{
    [XBJinRRNetwork uplodatImageWithpath:@"Upload/Upload/index" imgeData:imageData name:@"image" Block:^(id data, NSError *error) {
        if (!error) {
            block(data,nil);
        }else{
            block(nil,error);
        }
    }];
}


#pragma mark -- 更新用户信息
+ (void)updateUserInfoWithParams:(NSDictionary *)params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = [@{@"client":@"ios",
                                       @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                       @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                       @"token":[UDefault getObject:TOKEN],
                                       @"dynamic":[[Security shareSecurity] encryptAES256Data:params]
                                       } mutableCopy];
    [XBJinRRNetwork postWithUrl:@"center/member/modify" param:paramDic block:^(id data) {
        
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

//#pragma mark -- 获取贷款分销banner
//+ (void)getposterBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
//    NSDictionary *paramDic = @{@"client":@"ios",
//                                       @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
//                                       @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
//                                       @"token":[UDefault getObject:TOKEN]};
//    [XBJinRRNetwork postWithUrl:@"center/member/getposter" param:paramDic block:^(id data) {
//        MyLog(@"返回的数据 -- %@",data);
//        block(data);
//    } fail:^(NSError *errorString) {
//        fail(errorString);
//    }];
//}

#pragma mark -- 获取贷款产品新品推荐模块数据
+ (void)getposterWithItype:(NSString *)Itype Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    //Itype 类别:1贷款商品 2信用卡商品
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               @"Itype":Itype
                               };
    [XBJinRRNetwork postWithUrl:@"Home/Loan/getrec" param:paramDic block:^(id data) {
        //MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 获取贷款产品列表模块数据
+ (void)getposterWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    //Itype 类别:1贷款商品 2信用卡商品
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN]
                               }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    MyLog(@"paramDic --- %@",paramDic);
    [XBJinRRNetwork postWithUrl:@"Home/Loan/getproduct" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 获取贷款分销客户列表（排行榜信息）
+ (void)getLoadShareCustomerWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               @"id":aID
                               };
    [XBJinRRNetwork postWithUrl:@"center/member/getpromote" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 获取贷款分销我的专属海报
+ (void)getLoadShareMyPosterWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               @"id":aID
                               };
    [XBJinRRNetwork postWithUrl:@"center/member/getposter" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}



#pragma mark -- 获取贷款分销融客店推广图
+ (void)getRongkePosterBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN]
                               };
    [XBJinRRNetwork postWithUrl:@"center/member/rongke" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 获取 网贷平台 详情
+ (void)getLoadOpenUrlDetailWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"id":aID
                               };
    [XBJinRRNetwork getWithUrl:@"Home/Items/getdetail" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 统计
+ (void)productStatisticsWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN],@"productId":aID
                                      };
    [XBJinRRNetwork postWithUrl:@"center/member/productStatistics" param:paramDic block:^(id data) {
       
    } fail:^(NSError *errorString) {
        
    }];
}


#pragma mark -- 获取信用卡中心页推荐卡和热门卡列表
+ (void)getcreditWithIsrec:(NSString *)isrec rows:(NSString *)rows Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"isrec":isrec,
                               @"rows":@"6"
                               };
    [XBJinRRNetwork getWithUrl:@"Home/Items/getcredit" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
#pragma mark -- 获取 信用卡中心页 银行列表
+ (void)getbankBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                               };
    [XBJinRRNetwork getWithUrl:@"Home/Items/getbank" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 获取 信用卡中心页 筛选条件数据
+ (void)getCreditCardsCetegoryListWithType:(NSString *)type Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"type":type
                               };
    [XBJinRRNetwork getWithUrl:@"Home/items/gettype" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 获取 信用卡中心页 信用卡列表
+ (void)getCreditCardListWithParams:(NSDictionary *)parmas Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                               }.mutableCopy;
    [paramDic addEntriesFromDictionary:parmas];
    [XBJinRRNetwork getWithUrl:@"Home/Items/getclist" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 获取信用卡中心 卡贷信息详情
+ (void)getcreditCardDetailWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],@"id":aID
                                      };
    [XBJinRRNetwork getWithUrl:@"Home/items/getcdetail" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 获取 客户列表页 信息
+ (void)getclientWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN]
                               }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    MyLog(@"%@",paramDic);
    [XBJinRRNetwork postWithUrl:@"Home/Home/getclient" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
#pragma mark -- 获取 我的钱包 信息
+ (void)getwalletWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN]
                                      }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    MyLog(@"%@",paramDic);
    [XBJinRRNetwork postWithUrl:@"center/member/getwallet" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 申请提现
+ (void)drawWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN],
                                      @"dynamic":[[Security shareSecurity] encryptAES256Data:Params]
                                      }.mutableCopy;
    [XBJinRRNetwork postWithUrl:@"center/member/draw" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 推荐会员收入  （一级和二级合并）
+ (void)referincomeWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN]
                                      }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    MyLog(@"%@",paramDic);
    [XBJinRRNetwork postWithUrl:@"center/member/referincome" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 推广收入网贷and信用卡列表
+ (void)getpromotdataWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN]
                                      }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    MyLog(@"%@",paramDic);
    [XBJinRRNetwork postWithUrl:@"center/member/getpromotdata" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}




#pragma mark -- 推荐的会员贷款、查征信时我的收入
+ (void)makeincomeWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN]
                                      }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    MyLog(@"%@",paramDic);
    [XBJinRRNetwork postWithUrl:@"center/member/makeincome" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}



#pragma mark -- 提交 征信查询的信息
+ (void)submitinfoWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN],
                                      @"dynamic":[[Security shareSecurity] encryptAES256Data:Params]
                                      };
    
    MyLog(@"%@",paramDic);
    [XBJinRRNetwork postWithUrl:@"center/member/submitinfo" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 征信支付
+ (void)orderpayWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               @"dynamic":[[Security shareSecurity] encryptAES256Data:Params]
                               };
    
    MyLog(@"%@",paramDic);
    [XBJinRRNetwork postWithUrl:@"center/member/orderpay" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 购买代理
+ (void)payagentWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               @"dynamic":[[Security shareSecurity] encryptAES256Data:Params]
                               };
    
    MyLog(@"%@",paramDic);
    [XBJinRRNetwork postWithUrl:@"center/member/payagent" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

///api.php/center/member/getpaihang

+ (void)productBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":isEmptyStr([UDefault getObject:TOKEN])?@"f007":[UDefault getObject:TOKEN]
                               };
    [XBJinRRNetwork postWithUrl:@"center/member/getproductpaihang" param:paramDic block:^(id data) {
        MyLog(@"product === %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
    
}
+ (void)newsBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                               };
    [XBJinRRNetwork getWithUrl:@"/Home/News/zixunfenlei" param:paramDic block:^(id data) {
        MyLog(@"news === %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
+ (void)getNewsWithPage:(NSInteger)page rows:(NSInteger)rows cid:(NSString *)cid block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail{
    
    NSDictionary *param = @{@"client":@"ios",
                            @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                            @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                            @"page":@(page),
                            @"rows":@(rows),
                            @"cid":cid
                            };
    [XBJinRRNetwork getWithUrl:@"/Home/News/zixunlist" param:param block:^(id data) {
        MyLog(@"新闻列表返回的数据 === %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
+ (void)commissionBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":isEmptyStr([UDefault getObject:TOKEN])?@"f007":[UDefault getObject:TOKEN]
                               };
    [XBJinRRNetwork postWithUrl:@"center/member/getpaihang" param:paramDic block:^(id data) {
        MyLog(@"commissionBlock === %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

+ (void)centersWithType:(NSString *)type  MemberRecommendBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail {
    
    
//    NSLog(@" ++++++ === %@",isEmptyStr([UDefault getObject:TOKEN])?@"f007":[UDefault getObject:TOKEN]);
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"type":type,
//                               @"pages":@"1",
//                               @"rows":@"20",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":isEmptyStr([UDefault getObject:TOKEN])?@"f007":[UDefault getObject:TOKEN]
                               };
    

    [XBJinRRNetwork postWithUrl:@"center/member/getRecommend" param:paramDic block:^(id data) {
//        MyLog(@"我的团队 ===== %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
    
}

#pragma mark -- 价格列表
+ (void)pricelistBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                               };
    [XBJinRRNetwork getWithUrl:@"Home/News/pricelist" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
#pragma mark -- 征信列表
+ (void)getcredibilityWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN]
                               }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    [XBJinRRNetwork postWithUrl:@"center/member/getcredibility" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
#pragma mark -- 征信列表单条详情
+ (void)getcredibilityDetailWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN]
                                      }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    [XBJinRRNetwork postWithUrl:@"center/member/getdetail" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 会员中心四板块
+ (void)getbankuaisBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN]
                                      };
    [XBJinRRNetwork postWithUrl:@"center/member/bankuais" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 获取 系统公告和常见问题 列表
+ (void)getnewslistWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN]
                                      }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
    [XBJinRRNetwork getWithUrl:@"Home/News/getnewslist" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
#pragma mark -- 获取 系统公告 详情
+ (void)getnoticeWithID:(NSString *)aID isNews:(BOOL)isNews Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"id":aID
                                      };
    NSString *url;
    if (isNews == YES) {
        url = @"Home/News/getzixun";
    }else{
        url = @"Home/News/getnotice";
    }
    [XBJinRRNetwork getWithUrl:@"Home/News/getzixun" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 获取 代理级别 信息
+ (void)getnoticeBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                      @"token":[UDefault getObject:TOKEN]
                                      };
    [XBJinRRNetwork getWithUrl:@"Center/Member/getlevel" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 首页弹窗
+ (void)tanimgBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                               };
    [XBJinRRNetwork getWithUrl:@"home/home/tanimg" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
    
#pragma mark -- 新手帮助 列表
+ (void)newerhelpsWithParams:(NSDictionary *)params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                                      }.mutableCopy;
    [paramDic addEntriesFromDictionary:params];
    [XBJinRRNetwork getWithUrl:@"Home/News/newerhelps" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}
#pragma mark -- 再次查询征信
+ (void)regetCredibilityWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN]
                               }.mutableCopy;
    [paramDic addEntriesFromDictionary:Params];
//    [SVProgressHUD show];

    [XBJinRRNetwork postWithUrl:@"center/member/againcheck" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
//        [SVProgressHUD dismiss];
    } fail:^(NSError *errorString) {
        fail(errorString);
//        [SVProgressHUD dismiss];
    }];
}
#pragma mark -- 是否有未读消息
+ (void)isnoreadmsgBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN]
                               };
    [XBJinRRNetwork postWithUrl:@"center/member/isnoreadmsg" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 根据客户端和版本号与后台设置的匹配版本号，提示更新下载
+ (void)checkVersionBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSMutableDictionary *paramDic = @{@"client":@"ios",
                                      @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                      @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                                      }.mutableCopy;
    [XBJinRRNetwork getWithUrl:@"Home/home/version" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}

#pragma mark -- 把消息标记为已读状态
+ (void)setreadsWithType:(NSString *)type Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               @"type":type
                               };
    [XBJinRRNetwork postWithUrl:@"center/member/setreads" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 1.发送支付短信
+ (void)Center_Payment_NowPayWithOrderNo:(NSString *)OrderNo BankNo:(NSString *)BankNo CertNo:(NSString *)CertNo CertName:(NSString *)CertName CertPhone:(NSString *)CertPhone Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               @"dynamic":@{@"OrderNo":OrderNo,
                                     @"BankNo":BankNo,
                                     @"CertNo":CertNo,
                                     @"CertName":CertName,
                                     @"CertPhone":CertPhone}
                               };
    [XBJinRRNetwork postWithUrl:@"Center/Payment/NowPay" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 2.支付短信认证
+ (void)Center_Payzenxin_NowPayConfirmWithOrderNo:(NSString *)OrderNo Smscode:(NSString *)Smscode Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               
                               @"dynamic":@{@"OrderNo":OrderNo,
                                            @"Smscode":Smscode}
                               };
    [XBJinRRNetwork postWithUrl:@"Center/Payzenxin/NowPayConfirm" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}




#pragma mark -- 1.发送支付短信
+ (void)Center_Payzenxin_NowPayWithOrderNo:(NSString *)OrderNo BankNo:(NSString *)BankNo CertNo:(NSString *)CertNo CertName:(NSString *)CertName CertPhone:(NSString *)CertPhone Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               @"dynamic":@{@"OrderNo":OrderNo,
                                            @"BankNo":BankNo,
                                            @"CertNo":CertNo,
                                            @"CertName":CertName,
                                            @"CertPhone":CertPhone}
                               };
    [XBJinRRNetwork postWithUrl:@"Center/Payzenxin/NowPay" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


#pragma mark -- 2.支付短信认证
+ (void)Center_Payment_NowPayConfirmWithOrderNo:(NSString *)OrderNo Smscode:(NSString *)Smscode Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               
                               @"dynamic":@{@"OrderNo":OrderNo,
                                            @"Smscode":Smscode}
                               };
    [XBJinRRNetwork postWithUrl:@"Center/Payment/NowPayConfirm" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}



#pragma mark -- 获取微信号和微信二维码
+ (void)Core_public_getWechatBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                               };
    [XBJinRRNetwork getWithUrl:@"Core/public/getWechat" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}


///center/member/modifyAdd
#pragma mark -- 修改会员登录IP、所在城市、和手机类型
+ (void)center_member_modifyAddWithip:(NSString *)ip city:(NSString *)city Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail{
    NSDictionary *paramDic = @{@"client":@"ios",
                               @"package":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                               @"ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"token":[UDefault getObject:TOKEN],
                               
                               @"dynamic":@{@"city":city,
                                            @"ip":ip}
                               };
    [XBJinRRNetwork postWithUrl:@"center/member/modifyAdd" param:paramDic block:^(id data) {
        MyLog(@"返回的数据 -- %@",data);
        block(data);
    } fail:^(NSError *errorString) {
        fail(errorString);
    }];
}



@end
