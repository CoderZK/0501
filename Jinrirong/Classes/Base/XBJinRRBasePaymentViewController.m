//
//  XBJinRRBasePaymentViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBasePaymentViewController.h"
#import <WebKit/WebKit.h>
#import <AlipaySDK/AlipaySDK.h>

@interface XBJinRRBasePaymentViewController ()<WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *myWebView;
/**
 *  支付链接
 */
@property(nonatomic, copy)NSString *URLString;
@end

@implementation XBJinRRBasePaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:@"支付" isShowBack:YES];
    self.myWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.myWebView.navigationDelegate = self;
    [self.view addSubview:self.myWebView];
    
    self.URLString = [UDefault getObject:@"payweburl"];
    NSURL *url = [NSURL URLWithString:self.URLString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    [request setHTTPMethod:@"GET"];
    [request setValue:@"http://jrr.ahceshi.com://" forHTTPHeaderField: @"Referer"];
    [self.myWebView loadRequest:request];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [UDefault removeObject:@"payweburl"];
}



#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    /*
        WS(wself);
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    NSString*urlString = [navigationAction.request.URL absoluteString];
    
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlString containsString:@"https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb?"]) {
        //解决wkwebview weixin://无法打开微信客户端的处理
        NSURL*url = [NSURL URLWithString:urlString];
        if ([[UIApplication sharedApplication]respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {}];
            } else {
                // Fallback on earlier versions
            }
            actionPolicy = WKNavigationActionPolicyCancel;
        } else {
            [[UIApplication sharedApplication]openURL:webView.URL];
            actionPolicy = WKNavigationActionPolicyAllow;
        }
        
    }
     */
    
//    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[navigationAction.request.URL absoluteString] fromScheme:@"jrr.ahceshi.com" callback:^(NSDictionary *result) {
//            // 处理支付结果
//            // isProcessUrlPay 代表 支付宝已经处理该URL
//            if ([result[@"isProcessUrlPay"]boolValue]) {
//                NSString*resultCode = result[@"resultCode"];
//                // returnUrl 代表 第三方App需要跳转的成功页URL
//                NSString* urlStr = result[@"returnUrl"];
//                if ([resultCode isEqual:@"6001"]) {//当不是取消支付的时候，重新加载支付前的页面
//                    urlStr = self.URLString;
//                    [Dialog toastCenter:@"取消支付了"];
//                }else {
//                    if (urlStr.length==0) {
//                        urlStr = self.URLString;
//                    }
//                }
//                [wself loadWithUrlStr:urlStr];
//            }
//        }];
//    if (isIntercepted) {
//        actionPolicy =WKNavigationActionPolicyCancel;
//    }
    
    
    
    
    NSString *url = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    NSString* reUrl=[[webView URL] absoluteString];
    if ([url containsString:BaseUrl]) {
        reUrl=url;
    }
    
    if ([url containsString:@"alipay://"]) {
        NSInteger subIndex = 23;
        NSString* dataStr=[url substringFromIndex:subIndex];
        //编码
        NSString *encodeString = [self encodeString:dataStr];
        NSMutableString* mString=[[NSMutableString alloc] init];
        [mString appendString:[url substringToIndex:subIndex]];
        [mString appendString:encodeString];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mString]];
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
//    decisionHandler(actionPolicy);
    
}



-(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)unencodedString,
                                                              
                                                              NULL,
                                                              
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
    
}






//
//- (void)loadWithUrlStr:(NSString*)urlStr
//{
//    if (urlStr.length > 0) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
//                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                    timeoutInterval:30];
//            [self.myWebView loadRequest:webRequest];
//        });
//    }
//}
//










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
