//
//  XBUMManager.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/13.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBUMManager.h"


@implementation XBUMManager

+(void)initUmManagerWithLaunchOptions:(NSDictionary *)launchOptions Delegate:(id)delegate
{
    //友盟分享
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5c3ed8b2f1f556b808000029"];//5b2e0bd6f43e482dd8000037
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx4fb69db3e61b5f28" appSecret:@"71737dbbcf980251f365a3f57230ef9b" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101545858"  appSecret:@"9a41534bb8d97b47109f153c10fb9e7f" redirectURL:@"http://mobile.umeng.com/social"];
    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1996373625"  appSecret:@"86e6913558c7716676726495311c0f02" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];//暂时没有key
    
    //友盟统计
    UMConfigInstance.appKey = @"5c3ed8b2f1f556b808000029";
    UMConfigInstance.channelId = @"App Store";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    [MobClick setCrashReportEnabled:YES];
    
    //友盟推送
    [UMessage startWithAppkey:@"5c3ed8b2f1f556b808000029" launchOptions:launchOptions httpsenable:YES];
    
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = delegate;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
}

+(void)initIQKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager]; //处理键盘遮挡
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

@end
