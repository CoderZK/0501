//
//  AppDelegate.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "AppDelegate.h"
#import "XBJinRRBaseTabbarViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LF_ShowVersionView.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>

#import "kkkkTabBarVC.h"


#endif
//#import "WXApi.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate/*,WXApiDelegate*/>
{
    LF_ShowVersionView *versionView;
}
/**
 *  友盟推送消息
 */
@property(nonatomic, strong)NSDictionary *userInfo;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        
        JPUSHRegisterEntity *entityJUP = [[JPUSHRegisterEntity alloc] init];
        if (@available(iOS 10.0, *)) {
            entityJUP.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        }
        [JPUSHService registerForRemoteNotificationConfig:entityJUP delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    } else {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKeyRock channel:rocketChan apsForProduction:isProductionChan advertisingIdentifier:nil];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [XBUMManager initUmManagerWithLaunchOptions:launchOptions Delegate:self];
    [XBUMManager initIQKeyboardManager];
    
    //真实界面
    self.window.rootViewController = [[XBJinRRBaseTabbarViewController alloc]init];
    
    //假界面
//    self.window.rootViewController = [[kkkkTabBarVC alloc] init];
    
    
    [self checkNewVersionWithAppid:@[@"1462607266",@"1462613312",@"1462843477"] atViewController:self.window.rootViewController];

    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    [db open];
    
//    NSLog(@"%@",<#成功#>);


//    d9aa716391a74051f671f548
    
    return YES;
}
/*************************************************************/
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * device_token = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                stringByReplacingOccurrencesOfString: @">" withString: @""]
                               stringByReplacingOccurrencesOfString: @" " withString: @""];
    [UMessage registerDeviceToken:deviceToken];//1.2.7版本不用设置
    
    MyLog(@"device_token---  %@",device_token);
//    [XBJinRRNetworkApiManager ].device_token = device_token;
    
    [UDefault setObject:device_token keys:@"device_token"];
    
     [JPUSHService registerDeviceToken:deviceToken];
    

    
    
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
    } else {
        
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    } else {
        
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler();
}
#endif




- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    //关闭U-Push自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    self.userInfo = userInfo;
    /*
     // app was already in the foreground
     if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
     {
     UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"许多鲜通知"
     message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
     delegate:self
     cancelButtonTitle:@"确定"
     otherButtonTitles:nil];
     [alert show];
     }
     */
    
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // 统计消息点击事件
    [UMessage sendClickReportForRemoteNotification:self.userInfo];
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [self checkVersion];
}


- (void )checkVersion{
    [XBJinRRNetworkApiManager checkVersionBlock:^(id data) {
        NSDictionary *dataDic = data[@"data"];
        if ([dataDic allValues].count>0) {
            NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];//当前版本
            if ([dataDic[@"Ver"] compare: localVersion] == NSOrderedDescending) {
                NSString *str = [LLUtils filterHTMLByVersionDes:dataDic[@"Updates"]];
                MyLog(@"%@",data);
                if ([[NSString stringWithFormat:@"%@",dataDic[@"isForced"]] isEqualToString:@"2"]) {
                    //非强制更新
                    [self->versionView removeFromSuperview];
                    //强制更新版本
                    self->versionView = [LF_ShowVersionView alterViewWithTitle:[NSString stringWithFormat:@"发现新版本v%@",dataDic[@"Ver"]] content:str cancel:@"取消" sure:@"前往更新" cancelBtClcik:^{
                        
                    } sureBtClcik:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dataDic[@"Url"]]];
                    }];
                }else{
                    //强制更新
                    [self->versionView removeFromSuperview];
                    //强制更新版本
                    self->versionView = [LF_ShowVersionView alterViewWithTitle:[NSString stringWithFormat:@"发现新版本v%@",dataDic[@"Ver"]] content:str cancel:@"" sure:@"前往更新" cancelBtClcik:^{
                        
                    } sureBtClcik:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dataDic[@"Url"]]];
                    }];
                }
            }
        }
        
    } fail:^(NSError *errorString) {
        
    }];
}

//切换界面用
- (void)updateApp {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",@"1445514961"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                         
                                         if (data)
                                         {
                                             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                             
                                             if (dic)
                                             {
                                                 NSArray * arr = [dic objectForKey:@"results"];
                                                 if (arr.count>0)
                                                 {
                                                     NSDictionary * versionDict = arr.firstObject;
                                                     
                                                     //服务器版本
                                                     NSString * version = [[versionDict objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                                                     //当前版本
                                                     NSString * currentVersion = [[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                                                     
                                                     
                                                     
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         
                                                         if ([version integerValue] < [currentVersion integerValue]) {
//                                                             TabBarViewController *tabbar = [[TabBarViewController alloc] init];
//                                                             self.window.rootViewController = tabbar;
//                                                             [self.window makeKeyAndVisible];
                                                         }else {
//                                                             kkKaYouHuiVC * vc = [[kkKaYouHuiVC alloc] init];
//                                                             self.window.rootViewController = vc;
//                                                             [self.window makeKeyAndVisible];
                                                         }
                                                         
                                                         
                                                     });
                                                     
                                                     
                                                     
                                                     //                                                     if ([version integerValue]>[currentVersion integerValue])
                                                     //                                                     {
                                                     //                                                         NSString * str=[versionDict objectForKey:@"releaseNotes"];
                                                     //
                                                     //                                                         UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:str preferredStyle:UIAlertControllerStyleAlert];
                                                     //                                                         UIView *subView1 = alert.view.subviews[0];
                                                     //                                                         UIView *subView2 = subView1.subviews[0];
                                                     //                                                         UIView *subView3 = subView2.subviews[0];
                                                     //                                                         UIView *subView4 = subView3.subviews[0];
                                                     //                                                         UIView *subView5 = subView4.subviews[0];
                                                     //                                                         UILabel *message = subView5.subviews[1];
                                                     //                                                         message.textAlignment = NSTextAlignmentCenter;
                                                     //
                                                     //                                                         [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
                                                     //                                                         [alert addAction:[UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                     //
                                                     //                                                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",@"1435758559"]]];
                                                     //                                                             exit(0);
                                                     //
                                                     //                                                         }]];
                                                     //                                                         [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                                                     //                                                     }
                                                     
                                                     
                                                 }
                                             }
                                         }
                                     }] resume];
    
    
}

//检查更新
-(void)checkNewVersionWithAppid:(NSArray *)arr atViewController:(UIViewController *)viewController
{
    for (int i  = 0 ; i < arr.count; i++) {
        
        NSString * strOfAppid = arr[i];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",strOfAppid]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                         completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                             
                                             if (data)
                                             {
                                                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                 
                                                 if (dic)
                                                 {
                                                     NSArray * arr = [dic objectForKey:@"results"];
                                                     if (arr.count>0)
                                                     {
                                                         NSDictionary * versionDict = arr.firstObject;
                                                         
                                                         NSString * version = [[versionDict objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                                                         NSString * currentVersion = [[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                                                         
                                                         if ([version integerValue]>[currentVersion integerValue])
                                                         {
                                                             NSString * str=[versionDict objectForKey:@"releaseNotes"];
                                                             
                                                             UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"发现新版本,去appStore下载稳定版本" preferredStyle:UIAlertControllerStyleAlert];
                                                             //                                                         UIView *subView1 = alert.view.subviews[0];
                                                             //                                                         UIView *subView2 = subView1.subviews[0];
                                                             //                                                         UIView *subView3 = subView2.subviews[0];
                                                             //                                                         UIView *subView4 = subView3.subviews[0];
                                                             //                                                         UIView *subView5 = subView4.subviews[0];
                                                             //                                                         UILabel *message = subView5.subviews[1];
                                                             //                                                         message.textAlignment = NSTextAlignmentLeft;
                                                             
                                                             //                                                         [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
                                                             [alert addAction:[UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",strOfAppid]]];
                                                                 exit(0);
                                                                 
                                                             }]];
                                                             [viewController presentViewController:alert animated:YES completion:nil];
                                                         }
                                                         
                                                         
                                                     }
                                                 }
                                             }
                                         }] resume];
        
        
    }
  
}





- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    /*
    if([url.absoluteString rangeOfString:@"wx7db7e5982abe238e"].location != NSNotFound){
        //微信支付返回
        return  [WXApi handleOpenURL:url delegate:self];
    };
     */
    if (result == FALSE) {
       
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                NSLog(@"result = %@",resultDic);
            }];
            if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
                
                [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                    //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                    NSLog(@"result = %@",resultDic);
                }];
            }
            
        }
     }
    
    return result;
}

//ios9.0之后
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    /*
     //微信回调成功了，但是不携带任何信息，无法作出回调处理
    if ([options[@"UIApplicationOpenURLOptionsSourceApplicationKey"] isEqualToString:@"com.tencent.xin"]&& [url.absoluteString containsString:@"jrr.ahceshi.com://"]){
        //微信支付返回
        return  [WXApi handleOpenURL:url delegate:self];
    }
     */
    //支付宝支付回调
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"listenAlipayResults" object:self userInfo:@{@"resultDic":resultDic}];
        }];
    }
    
    return result;
}


    
    
/*
// 微信支付成功或者失败回调
-(void)onResp:(BaseResp*)resp
{
    NSInteger result = 0;
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"恭喜您,支付成功!";
                result = 1;
                break;
            }
            case WXErrCodeUserCancel:{
                strMsg = @"已取消支付!";
                result = 2;
                break;
            }
            default:{
                strMsg = [NSString stringWithFormat:@"支付失败!"];
                result = 0;
                break;
            }
        }
        [NSNotic_Center postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":strMsg,@"result":@(result)}];
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
    
   */
@end
