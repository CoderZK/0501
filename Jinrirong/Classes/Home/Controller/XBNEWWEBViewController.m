//
//  XBNEWWEBViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/6/28.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBNEWWEBViewController.h"

@interface XBNEWWEBViewController ()<UIWebViewDelegate>
{
    double webViewHeight;
}
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation XBNEWWEBViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
    [self getfindDetail];
}

-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    [self setNavWithTitle:_titleName isShowBack:YES];
}


- (UIWebView *)webView
{
    if (!_webView) {
        _webView =[[UIWebView alloc] initWithFrame:CGRectMake(0,NAV_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT)];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(0);
            make.left.right.bottom.mas_offset(0);
        }];

        
    }
    
    return _webView;
}

- (void)getfindDetail{
    WS(bself);
    
    [bself.webView loadHTMLString:_Controlents baseURL:nil];

    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 1、只对本地html资源的图片有效果
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}


@end
