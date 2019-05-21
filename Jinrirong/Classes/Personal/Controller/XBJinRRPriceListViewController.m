//
//  XBJinRRPriceListViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPriceListViewController.h"
#import "UIImage+XBJinRRImgSize.h"
#import <WebKit/WebKit.h>

@interface XBJinRRPriceListViewController ()<WKNavigationDelegate>
@property(nonatomic, copy)NSArray *infoDicArray;
@property(nonatomic, strong)WKWebView * singWebView;
@end

@implementation XBJinRRPriceListViewController

-(NSArray *)infoDicArray{
    
    if (!_infoDicArray) {
        _infoDicArray = [NSArray new];
    }
    return _infoDicArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavWithTitle:@"价格表" isShowBack:YES];
    self.singWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT)];
    self.singWebView.navigationDelegate = self;
    [self.view addSubview:self.singWebView];
    [self.singWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(NAV_HEIGHT);
        make.left.right.bottom.mas_offset(0);
    }];
    
    [self requestData];
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


-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.view showLoadMessageAtCenter:@"努力加载中..."];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.view hide];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.view hide];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.view hide];
}


//刷新控件

- (void)requestData
{
    WS(bself);
    [self.view showLoadMessageAtCenter:@"努力加载中..."];
    [XBJinRRNetworkApiManager pricelistBlock:^(id data) {
        [bself.view hide];
        
        NSLog(@"data ==== %@",data);
        if (rusultIsCorrect) {
            bself.infoDicArray = data[@"data"];
            NSMutableString *mStr = [NSMutableString new];
            for (int i=0; i<self.infoDicArray.count; i++) {
                NSDictionary *infoDic = self.infoDicArray[i];
                NSString *url = infoDic[@"Pic"];
                NSString *htmlStr = [NSString stringWithFormat:@"<div><img style='padding:0 10px 0 10px;' src=\"%@\"></div>",url];
                [mStr appendString:htmlStr];
            }

            NSLog(@"mStr ==== %@",mStr);



            [self.singWebView loadHTMLString:mStr baseURL:nil];
        }
    } fail:^(NSError *errorString) {
        [bself.view hide];
    }];
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
