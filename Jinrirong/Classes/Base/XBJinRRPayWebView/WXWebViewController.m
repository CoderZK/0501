//
//  WXWebViewController.m
//  TestPayWeb
//
//  Created by MJL on 2018/3/21.
//  Copyright © 2018年 MJL. All rights reserved.
//

#import "WXWebViewController.h"
#import "WebChatPayH5VIew.h"
#import <AlipaySDK/AlipaySDK.h>

@interface WXWebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *myWebView;

@end

@implementation WXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"支付";
}


- (void)setPayUrlStr:(NSString *)payUrlStr{
    _payUrlStr = payUrlStr;
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:self.myWebView];
    self.myWebView.delegate = self;
    //加载h5链接
//    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_payUrlStr]]];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_payUrlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    //设置授权域名
    [request setValue:@"jrr.ahceshi.com://" forHTTPHeaderField:@"Referer"];
     [self.myWebView loadRequest:request];
}



#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    NSString *newUrl = url.absoluteString;
#warning 微信支付链接不要拼接redirect_url，如果拼接了还是会返回到浏览器的
    
    if ([newUrl rangeOfString:@"https://wx.tenpay.com"].location != NSNotFound) {
        //这里把webView设置成一个像素点，主要是不影响操作和界面，主要的作用是设置referer和调起微信
        WebChatPayH5VIew *h5View = [[WebChatPayH5VIew alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        //newUrl是没有拼接redirect_url微信h5支付链接
        [h5View loadingURL:newUrl withIsWebChatURL:NO];
        [self.view addSubview:h5View];
        return NO;
    }
    else
    {
        WS(wself);
        BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[request.URL absoluteString] fromScheme:@"com.yunyjia.app" callback:^(NSDictionary *result) {
            // isProcessUrlPay 代表 支付宝已经处理该URL
            if ([result[@"isProcessUrlPay"] boolValue]) {
                // returnUrl 代表 第三方App需要跳转的成功页URL
                NSString* urlStr = result[@"returnUrl"];
                [wself loadWithUrlStr:urlStr];
            }
            
            //2018-07-05增加支付反馈显示信息
            if ([[NSString stringWithFormat:@"%@",result[@"resultCode"]] isEqualToString:@"9000"]) {
                [Dialog toastCenter:@"支付成功!"];
            }else if ([[NSString stringWithFormat:@"%@",result[@"resultCode"]] isEqualToString:@"4000"]) {
                [Dialog toastCenter:@"支付失败!"];
            }else if ([[NSString stringWithFormat:@"%@",result[@"resultCode"]] isEqualToString:@"6001"]) {
                [Dialog toastCenter:@"支付取消!"];
            }
            
        }];
        
        if (isIntercepted) {
            return NO;
        }
        
    }

    return YES;
}



- (void)loadWithUrlStr:(NSString*)urlStr
{
    if (urlStr.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                    timeoutInterval:60];
            [self.myWebView loadRequest:webRequest];
        });
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
