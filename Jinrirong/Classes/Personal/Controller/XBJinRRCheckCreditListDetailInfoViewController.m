//
//  XBJinRRCheckCreditListDetailInfoViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/6.
//  Copyright © 2018年 ahxb. All rights reserved.
//  单条征信详情

#import "XBJinRRCheckCreditListDetailInfoViewController.h"
#import "XBJinRRPaymentStyleViewController.h"
#import <WebKit/WebKit.h>


@interface XBJinRRCheckCreditListDetailInfoViewController ()<UITableViewDataSource,UITableViewDelegate,WKNavigationDelegate>
@property(nonatomic, strong)WKWebView *myWebView;
@property(nonatomic, strong)UITableView *tableView;
/**
 *  详情信息
 */
@property(nonatomic, copy)NSDictionary *infoDic;
@end

@implementation XBJinRRCheckCreditListDetailInfoViewController

-(WKWebView *)myWebView{
    if (!_myWebView) {
        _myWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT)];
        _myWebView.navigationDelegate = self;
        _myWebView.scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_myWebView];
        [_myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(0);
            make.left.right.bottom.mas_offset(0);
        }];
    }
    return _myWebView;
}

-(NSDictionary *)infoDic{
    if (!_infoDic) {
        _infoDic = [NSDictionary new];
    }
    return _infoDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:@"征信详情" isShowBack:YES];
    [self initTableView];
    [self requestData];
}

- (void ) requestData{
    WS(bself);
    NSDictionary *params = @{@"id":self.tModel.ID};
    
    [XBJinRRNetworkApiManager getcredibilityDetailWithParams:params Block:^(id data) {
        
        if (rusultIsCorrect) {
            bself.infoDic = data[@"data"];
            
            if ([bself.infoDic[@"Status"] isEqualToString:@"4"]) {
                [bself.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:bself.infoDic[@"detailurl"]]]];
            }else{
                bself.tableView.hidden = NO;
                [bself.tableView reloadData];
            }
        }
    } fail:^(NSError *errorString) {
         
    }];
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



- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.hidden = NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.infoDic.allValues.count>0) {
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableParagraphStyle *paragraphStyle0 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle0.lineSpacing = 10;
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:@"查询信息\n" attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:MainColor,NSParagraphStyleAttributeName:paragraphStyle0}];
    
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 10;
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"姓名：%@\n身份证号：%@\n手机号码：%@",self.infoDic[@"TrueName"],self.infoDic[@"IDCard"],self.infoDic[@"Mobile"]] attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
    
    [attri0 appendAttributedString:attri1];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.attributedText = attri0;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SIZE(100);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(100)) backgroundColor:ClearColor];
    UIButton *makeSureBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(30),SIZE(30), SCREEN_WIDTH-SIZE(60),SIZE(50)) title:[self.infoDic[@"Status"] isEqualToString:@"1"]?@"立即支付":@"查询征信" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
    [makeSureBtn addTarget:self action:@selector(makeSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:makeSureBtn];
    makeSureBtn.layer.masksToBounds = YES;
    makeSureBtn.layer.cornerRadius = SIZE(25);
    return bgView;
    
}

//立即支付钮被点击
- (void )makeSureBtnClick:(UIButton *)sender{
    WS(bself);
    if ([self.infoDic[@"Status"] isEqualToString:@"1"]) {
        //代付款状态
        XBJinRRPaymentStyleViewController *vc = [XBJinRRPaymentStyleViewController new];
        vc.ID = [NSString stringWithFormat:@"%@",self.infoDic[@"ID"]];
        vc.isAgency = NO;
        vc.payMoney = self.tModel.OrderAmount;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.infoDic[@"Status"] isEqualToString:@"3"]) {
        //查询失败
         [self.view showLoadMessageAtCenter:@"加载数据中..."];
        [XBJinRRNetworkApiManager regetCredibilityWithParams:@{@"id":[NSString stringWithFormat:@"%@",self.infoDic[@"ID"]]} Block:^(id data) {
            [bself.view hide];
            if (rusultIsCorrect) {
                bself.recheckCreditInfoBlock();
                [bself.navigationController popViewControllerAnimated:YES];
            }else{
                [Dialog toastCenter:data[@"message"]];
            }
        } fail:^(NSError *errorString) {
            [bself.view hide];
        }];
    }else{
        
    }
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
