//
//  XBJinRRNewsDetailViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRNewsDetailViewController.h"
#import <WebKit/WebKit.h>

@interface XBJinRRNewsDetailViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView      *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation XBJinRRNewsDetailViewController

#pragma mark - 加载一个有进度条的web
-(UIProgressView *)progressView {
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [_progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
        [_progressView setFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 1)];
        //设置进度条颜色
        [_progressView setTintColor:RGB(15, 89, 180)];
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:self.tModel.Title isShowBack:YES];
    self.view.backgroundColor = WhiteColor;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    //kvo 添加进度监控
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:NULL];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self getDetail];
}
- (void )getDetail{
    WS(bself);
    //NSLog(@"===%@",self.tModel.ID);
    [XBJinRRNetworkApiManager getnoticeWithID:self.tModel.ID isNews:self.isNews Block:^(id data) {
        if (rusultIsCorrect) {
            NSDictionary *dic = data[@"data"];
            NSString *contentStr = [NSString stringWithFormat:@"%@",dic[@"Contents"]];
            [self.webView loadHTMLString:[LLUtils reSizeImageWithHTML:contentStr] baseURL:nil];
        }else{
            [bself.view hide];
        }
    } fail:^(NSError *errorString) {
        [bself.view hide];
        [Dialog toastCenter:@"网络错误"];
    }];
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler {
    
    
    
    NSURL *strRequest = navigationAction.request.URL;
    NSLog(@"---%@",strRequest.absoluteString);
    NSString * hostname  =  strRequest.absoluteString;
    // sourceFrame和targetFrame，分别代表这个方法的出处和目标。
    
//    if(navigationAction.targetFrame == nil){
//        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转,
//        //NSLog(@"不跳转");
//        if ([strRequest.absoluteString containsString:@"http://"] || [strRequest.absoluteString containsString:@"https://"]) {
//            // 请求网页数据
//            NSURLRequest *req = [[NSURLRequest alloc] initWithURL:strRequest];
//            [self.webView loadRequest:req];
//        }
//    }else{
//        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
//        //NSLog(@"跳转");
//    }
    
    if (![hostname containsString:@"new.ganzheapp.com"] &&([strRequest.absoluteString containsString:@"http://"] || [strRequest.absoluteString containsString:@"https://"])) {
        
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
    
    NSLog(@"跳转到其他的服务器");
    
    
    
}


//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if(self.webView.estimatedProgress >=1.0f) {
            [self.progressView setProgress:1.0f animated:NO];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.progressView setProgress:0.0f animated:NO];
                self.progressView.hidden = YES;
            });
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
-(void)dealloc {
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}
   
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
