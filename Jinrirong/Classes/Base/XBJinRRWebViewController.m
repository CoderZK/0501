//
//  XBJinRRWebViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/19.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRWebViewController.h"
#import <WebKit/WebKit.h>

@interface XBJinRRWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong)WKWebView * singWebView;
@property(nonatomic,strong)CALayer * progresslayer;

@end

@implementation XBJinRRWebViewController

- (CALayer *)progresslayer
{
    if (!_progresslayer) {
        UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 3)];
        progress.backgroundColor = [UIColor clearColor];
        [self.view addSubview:progress];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 3);
        layer.backgroundColor = RGB(74, 87, 232).CGColor;
        [progress.layer addSublayer:layer];
        self.progresslayer = layer;
    }
    return _progresslayer;
}

- (WKWebView *)singWebView
{
    if (!_singWebView) {
        //初始化一个WKWebViewConfiguration对象
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width,inital-scale=1.0,maximum-scale=1.0,user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        config.userContentController = wkUController;
        _singWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) configuration:config];
        _singWebView.UIDelegate = self;
        _singWebView.navigationDelegate = self;
        //WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以首先监听这个属性
        [_singWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _singWebView;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转    decisionHandler(WKNavigationActionPolicyCancel);
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    NSLog(@"是否跨平台%@",hostname);
    
    if (![hostname containsString:@"new.ganzheapp.com"] && ([navigationAction.request.URL.absoluteString containsString:@"http://"] || [navigationAction.request.URL.absoluteString containsString:@"https://"])) {
      
        // 对于跨域，需要手动跳转//
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
          // 不允许web内跳转//
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController popViewControllerAnimated:NO];
        
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    }
}
    




- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"\n7777");
    
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
        NSLog(@"\n6666");
    [self.view showLoadMessageAtCenter:@"努力加载中..."];
}
//-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//    [self.view showLoadMessageAtCenter:@"努力加载中..."];
//}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.view hide];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.view hide];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.view hide];
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.singWebView];
    [self.singWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.mas_equalTo(NAV_HEIGHT);
    }];
//    if (self.webType==WebTypeNewerHelp) {
//        [self setNavTitleStr:self.titleString];
//        [self.singWebView loadHTMLString:[NSString stringWithFormat:@"<html><head><meta name='viewport' content='width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no'> <meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><style>img{width:100%%;}a{word-wrap: break-word;}</style></head><body>%@</body></html>",self.htmlString] baseURL:nil];
//        return;
//    }
    
//    if (self.webType!=11) {
//        [self setUrl:nil webType:self.webType];
//    }else{
//        [self setNavTitleStr:self.titleString];
//        [self.singWebView loadHTMLString:[NSString stringWithFormat:@"<html><head><meta name='viewport' content='width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no'> <meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><style>img{width:100%%;}a{word-wrap: break-word;}</style></head><body>%@</body></html>",self.htmlString] baseURL:nil];
//    }
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    [self setNavWithTitle:_titleString isShowBack:YES];
}

//- (void)setPageTitleWithWebType:(WebType)webType{
//
//    switch (webType) {
//
//        case WebTypeAboutUs:
//            [self setNavTitleStr:@"关于我们"];
//            break;
//        case WebTypeAppDesc:
//            [self setNavTitleStr:@"产品介绍"];
//            break;
//        case WebTypeBuyPatient:
//            [self setNavTitleStr:@"购买需知"];
//            break;
//        case WebTypeVersionDes:
//            [self setNavTitleStr:@"版本介绍"];
//            break;
//        case WebTypePrivacyProtocol:
//            [self setNavTitleStr:@"使用条款隐私协议"];
//            break;
//
//        case WebTypeRegistProtocol:
//            [self setNavTitleStr:@"用户协议"];
//            break;
//        default:
//            break;
//    }
//    [self requestPageDataWithID:webType];
//}

- (void)setUrl:(NSString *)url webType:(WebType)webType{
//    [self setPageTitleWithWebType:webType];
    
    if (url!= nil) {
        
        if ([url containsString:@"payzenxin"]&&[url containsString:@"Wachet"]) {
            NSURL *payurl = [NSURL URLWithString:url];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:payurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            [request setHTTPMethod:@"GET"];
            [request setValue:@"http://jrr.ahceshi.com://" forHTTPHeaderField: @"Referer"];
            [self.singWebView loadRequest:request];
        }else{
            [self.singWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        }
        
    }
    else{
        switch (webType) {
                
            case WebTypeAboutUs:
//                [self setNavTitleStr:@"关于我们"];
                [self setNavWithTitle:@"关于我们" isShowBack:YES];
                break;
            case WebTypeAppDesc:
//                [self setNavTitleStr:@"产品介绍"];
                 [self setNavWithTitle:@"产品介绍" isShowBack:YES];
                break;
            case WebTypeBuyPatient:
//                [self setNavTitleStr:@"购买需知"];
                [self setNavWithTitle:@"购买需知" isShowBack:YES];
                break;
            case WebTypeVersionDes:
//                [self setNavTitleStr:@"版本介绍"];
                [self setNavWithTitle:@"版本介绍" isShowBack:YES];
                break;
            case WebTypePrivacyProtocol:
//                [self setNavTitleStr:@"使用条款隐私协议"];
                [self setNavWithTitle:@"购买协议" isShowBack:YES];
                break;
                
            case WebTypeRegistProtocol:
//                [self setNavTitleStr:@"用户协议"];
                [self setNavWithTitle:@"用户协议" isShowBack:YES];
                break;
            default:
                break;
        }
        [self requestPageDataWithID:webType];
    }
}

#pragma mark -- 下载数据
- (void)requestPageDataWithID:(NSInteger)pageID{
    WS(bself);
    [XBJinRRNetworkApiManager getTitleContentWithID:pageID Block:^(id data) {
        
        if (rusultIsCorrect) {
            NSDictionary *dataDic = [data[@"data"] mj_JSONObject];
            NSString *Contents = [NSString stringWithFormat:@"%@",dataDic[@"Contents"]];
            [bself.singWebView loadHTMLString:Contents baseURL:nil];
        }
    } fail:^(NSError *errorString) {
        
    }];
}

/**
 清理网页缓存
 */
- (void)deleteWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                                                        //WKWebsiteDataTypeOfflineWebApplicationCache,
                                                        WKWebsiteDataTypeMemoryCache,
                                                        //WKWebsiteDataTypeLocalStorage,
                                                        //WKWebsiteDataTypeCookies,
                                                        //WKWebsiteDataTypeSessionStorage,
                                                        //WKWebsiteDataTypeIndexedDBDatabases,
                                                        //WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

- (void)dealloc{
    [self deleteWebCache];
    [(WKWebView *)self.singWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}





//
//
//// 在收到响应开始加载后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
//{
//    //返回支付宝的信息字符串，alipays:// 以后的为支付信息，这个信息后台是经过 URLEncode 后的，前端需要进行解码后才能跳转支付宝支付（坑点）
//    NSString *urlStr = [navigationResponse.response.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    if ([urlStr containsString:@"alipays://"]) {
//
//        NSRange range = [urlStr rangeOfString:@"alipays://"]; //截取的字符串起始位置
//        NSString * resultStr = [urlStr substringFromIndex:range.location]; //截取字符串
//
//        NSURL *alipayURL = [NSURL URLWithString:resultStr];
//
//        if (@available(iOS 10.0, *)) {
//            [[UIApplication sharedApplication] openURL:alipayURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
//
//            }];
//        } else {
//            // Fallback on earlier versions
//            [[UIApplication sharedApplication]openURL:webView.URL];
//        }
//    }
//
//
//    if ([urlStr containsString:@"weixin://wap/pay?"]) {
//        //解决wkwebview weixin://无法打开微信客户端的处理
//        NSURL*url = [NSURL URLWithString:urlStr];
//
//        if ([[UIApplication sharedApplication]respondsToSelector:@selector(openURL:options:completionHandler:)]) {
//
//            if (@available(iOS 10.0, *)) {
//                [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {}];
//            } else {
//                // Fallback on earlier versions
//            }
//        } else {
//            [[UIApplication sharedApplication]openURL:webView.URL];
//        }
//
//    }
//
//
//
//    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
//    //这句是必须加上的，不然会异常
//    decisionHandler(actionPolicy);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
