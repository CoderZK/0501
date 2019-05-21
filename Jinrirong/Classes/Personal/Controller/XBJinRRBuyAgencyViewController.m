//
//  XBJinRRBuyAgencyViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBuyAgencyViewController.h"
#import "XBJinRRAgencyCell.h"
#import "XBJinRRAgencyMoneyCell.h"
#import "XBJinRRPaymentStyleViewController.h"
#import "XBEDAIBuyAgencyHelpViewController.h"

@interface XBJinRRBuyAgencyViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIButton *productBtn;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) UIButton *toBeBtn;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIWebView *productDescWebView;
@property (nonatomic,strong) UIWebView *buyDescWebView;
@property (nonatomic,strong) UISwitch *switchBtn;
/**
 *  代理数据
 */
@property(nonatomic, copy)NSArray *agencyArray;
/**
 *  选择的代理下标
 */
@property(nonatomic, assign)NSInteger agencyIndex;

@property(nonatomic, strong)UITableView *tableView;
@end

@implementation XBJinRRBuyAgencyViewController

static NSString *XBJinRRAgencyCellID = @"XBJinRRAgencyCellID";
static NSString *XBJinRRAgencyMoneyCellID = @"XBJinRRAgencyMoneyCellID";

- (NSArray *)agencyArray{
    if (!_agencyArray) {
        _agencyArray = [NSArray new];
    }
    return _agencyArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavWithTitle:@"购买代理" isShowBack:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.agencyIndex = 0;
    
    
    UIImageView *rightIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 26, 26) image:@"help_request_icon"];
    rightIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightBtn:)];
    [rightIcon addGestureRecognizer:tap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightIcon];
    
    
    [self createUI];
    
    
    [self loadData];
}

- (void )clickRightBtn:(UITapGestureRecognizer *)tap{
    XBEDAIBuyAgencyHelpViewController *vc = [XBEDAIBuyAgencyHelpViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)loadData
{
//    [self.view showLoadMessageAtCenter:@"加载数据中..."];
//[bself.view hide];
//    
    
    WS(bself);
    [XBJinRRNetworkApiManager getPageWithID:@"2" block:^(id data) {
        [bself.productDescWebView loadHTMLString:data[@"data"][@"Contents"] baseURL:nil];
    } fail:^(NSError *errorString) {
        
    }];
    
    [XBJinRRNetworkApiManager getPageWithID:@"3" block:^(id data) {
        [bself.buyDescWebView loadHTMLString:[NSString stringWithFormat:@"<font size=\"6\">%@</font><br/>",data[@"data"][@"Contents"]] baseURL:nil];
    } fail:^(NSError *errorString) {
        
    }];
    
    
    [XBJinRRNetworkApiManager getnoticeBlock:^(id data) {
        if (rusultIsCorrect) {
            bself.agencyArray = data[@"data"];
            [bself.tableView reloadData];
        }
    } fail:^(NSError *errorString) {
        
    }];
}
- (void)createUI
{
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 40);
    [self.view addSubview:headerView];
    
    UIButton *productBtn = [[UIButton alloc] init];
    [productBtn addTarget:self action:@selector(clickProductBtn) forControlEvents:UIControlEventTouchUpInside];
    [productBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [productBtn setTitle:@"产品描述" forState:UIControlStateNormal];
    productBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    productBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 40);
    [headerView addSubview:productBtn];
    self.productBtn = productBtn;
    
    UIButton *buyBtn = [[UIButton alloc] init];
    [buyBtn addTarget:self action:@selector(clickBuyBtn) forControlEvents:UIControlEventTouchUpInside];
    [buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buyBtn setTitle:@"购买须知" forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    buyBtn.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 40);
    [headerView addSubview:buyBtn];
    self.buyBtn = buyBtn;
    
    UIButton *toBeBtn = [[UIButton alloc] init];
    [toBeBtn addTarget:self action:@selector(clickToBeBtn) forControlEvents:UIControlEventTouchUpInside];
    [toBeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [toBeBtn setTitle:@"成为代理" forState:UIControlStateNormal];
    toBeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    toBeBtn.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 40);
    [headerView addSubview:toBeBtn];
    self.toBeBtn = toBeBtn;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = MainColor;
    line.frame = CGRectMake(0, 39, SCREEN_WIDTH/3, 1);
    [headerView addSubview:line];
    self.line = line;
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)-40);
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
    mainScrollView.delegate = self;
    mainScrollView.pagingEnabled = YES;
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    
    UIWebView *productDescWebView = [[UIWebView alloc] init];
    productDescWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)-40);
    productDescWebView.scalesPageToFit = YES;
    [mainScrollView addSubview:productDescWebView];
    self.productDescWebView = productDescWebView;
    
    UIWebView *buyDescWebView = [[UIWebView alloc] init];
    buyDescWebView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)-40);
    buyDescWebView.scalesPageToFit = YES;
    [mainScrollView addSubview:buyDescWebView];
    self.buyDescWebView = buyDescWebView;
    
    UITableView *toBeTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)-40) style:UITableViewStylePlain];
    toBeTableView.dataSource = self;
    toBeTableView.delegate = self;
    [mainScrollView addSubview:toBeTableView];
    [toBeTableView registerClass:[XBJinRRAgencyCell class] forCellReuseIdentifier:XBJinRRAgencyCellID];
    [toBeTableView registerClass:[XBJinRRAgencyMoneyCell class] forCellReuseIdentifier:XBJinRRAgencyMoneyCellID];
    self.tableView = toBeTableView;
    
    if (![self.agencyType isEqualToString:@"4"]) {
        UIView *footView = [[UIView alloc] init];
        [footView setUserInteractionEnabled:YES];
        footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        
        UISwitch *switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(10, 0, 70, 20)];
        [switchBtn setOn: YES animated: YES];
        switchBtn.transform = CGAffineTransformMakeScale( 0.7, 0.7);//缩放
        switchBtn.onTintColor = MainColor;
        [footView addSubview:switchBtn];
        self.switchBtn = switchBtn;
        
        UILabel *agressLabel = [[UILabel alloc] init];
        agressLabel.font = [UIFont systemFontOfSize:15];
        NSString *agressStr = @"我已阅读并同意《购买协议》";
        NSMutableAttributedString *agressAttStr = [[NSMutableAttributedString alloc] initWithString:agressStr];
        NSRange range = [agressStr rangeOfString:@"《"];
        [agressAttStr addAttributes:@{NSForegroundColorAttributeName:MainColor} range:NSMakeRange(range.location,agressStr.length-7)];
        [agressAttStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 7)];
        agressLabel.attributedText = agressAttStr;
        [footView addSubview:agressLabel];
        [agressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(switchBtn.mas_centerY).offset(0);
            make.left.equalTo(switchBtn.mas_right).offset(5);
        }];
        agressLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userProtocol)];
        [agressLabel addGestureRecognizer:tap];
        
        UIButton *toBuyBtn = [[UIButton alloc] init];
        [toBuyBtn addTarget:self action:@selector(clickToBuyBtn) forControlEvents:UIControlEventTouchUpInside];
        toBuyBtn.layer.cornerRadius = 25;
        toBuyBtn.layer.masksToBounds = YES;
        if ([self.agencyType isEqualToString:@"1"]) {
            [toBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        }else{
            [toBuyBtn setTitle:@"立即升级" forState:UIControlStateNormal];
        }
        
        [toBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [toBuyBtn setBackgroundColor:MainColor];
        [footView addSubview:toBuyBtn];
        [toBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(agressLabel.mas_bottom).offset(15);
            make.left.equalTo(footView.mas_left).offset(15);
            make.right.equalTo(footView.mas_right).offset(-15);
            make.height.offset(50);
        }];
        
        toBeTableView.tableFooterView = footView;
        
    }else{
        toBeTableView.tableFooterView = [UIView new];
    }
}

#pragma mark -- 查看协议
- (void )userProtocol{
    XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
    [vc setUrl:nil webType:WebTypePrivacyProtocol];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)clickToBuyBtn
{
    if (!self.switchBtn.on) {
        [Dialog toastCenter:@"请同意购买协议"];
        return;
    }
    
    
    
    //1普通会员  2渠道代理  3团队经理  4城市经理
    NSInteger discountMoney = 0;
    if ([self.agencyType isEqualToString:@"1"]) {
        discountMoney = 0;
    }else if ([self.agencyType isEqualToString:@"2"]){
        NSDictionary *dic = self.agencyArray[2];
        discountMoney = [dic[@"Price"] floatValue];
    }else if ([self.agencyType isEqualToString:@"3"]){
        NSDictionary *dic = self.agencyArray[1];
        discountMoney = [dic[@"Price"] floatValue];
    }else{
        NSDictionary *dic = self.agencyArray[0];
        discountMoney = [dic[@"Price"] floatValue];
    }
    NSDictionary *dic = self.agencyArray[self.agencyIndex];    
    XBJinRRPaymentStyleViewController *vc = [[XBJinRRPaymentStyleViewController alloc] init];
    vc.isAgency = YES;
    vc.payMoney = [NSString stringWithFormat:@"%.2f",[dic[@"Price"] floatValue] - discountMoney];
    vc.ID = dic[@"ID"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickProductBtn
{
    [self.productBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.toBeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.line.frame = CGRectMake(0, 39, SCREEN_WIDTH/3, 1);
    self.mainScrollView.contentOffset = CGPointMake(0, 0);
}
- (void)clickBuyBtn
{
    [self.productBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [self.toBeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.line.frame = CGRectMake(SCREEN_WIDTH/3, 39, SCREEN_WIDTH/3, 1);
    self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
}
- (void)clickToBeBtn
{
    [self.productBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.toBeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    self.line.frame = CGRectMake(SCREEN_WIDTH/3*2, 39, SCREEN_WIDTH/3, 1);
    self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.mainScrollView) {
        NSInteger page = scrollView.contentOffset.x;
        if (page == 0) {
            [self.productBtn setTitleColor:MainColor forState:UIControlStateNormal];
            [self.buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.toBeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.line.frame = CGRectMake(0, 39, SCREEN_WIDTH/3, 1);
        } else if (page == SCREEN_WIDTH) {
            [self.productBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.buyBtn setTitleColor:MainColor forState:UIControlStateNormal];
            [self.toBeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.line.frame = CGRectMake(SCREEN_WIDTH/3, 39, SCREEN_WIDTH/3, 1);
        } else if (page == (SCREEN_WIDTH)*2) {
            
            [self.productBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.toBeBtn setTitleColor:MainColor forState:UIControlStateNormal];
            self.line.frame = CGRectMake(SCREEN_WIDTH/3*2, 39, SCREEN_WIDTH/3, 1);
        }
    }
    
}

#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.agencyType isEqualToString:@"4"]?0:2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.agencyType isEqualToString:@"1"]?0.001:SIZE(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.agencyType isEqualToString:@"1"]) {
        return [UIView new];
    }else{
        //1普通会员  2渠道代理  3团队经理  4城市经理
        UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50)) backgroundColor:WhiteColor];
        NSString *titleStr = [NSString stringWithFormat:@"您好，%@",self.Rule];
//        if ([self.agencyType isEqualToString:@"1"]) {
//            
//        }else if ([self.agencyType isEqualToString:@"2"]){
//            titleStr = @"您好，渠道代理";
//        }else if ([self.agencyType isEqualToString:@"3"]){
//            titleStr = @"您好，团队经理";
//        }else{
//            titleStr = @"您好，城市经理";
//        }
        UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(10), 0, SCREEN_WIDTH-SIZE(20), SIZE(25)) backgroundColor:WhiteColor text:titleStr textColor:MainColor textAlignment:Center font:FONT(15)];
        [bgView addSubview:titleLabel];
        
        UILabel *desLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(10),SIZE(25), SCREEN_WIDTH-SIZE(20), SIZE(25)) backgroundColor:WhiteColor text:[self.agencyType isEqualToString:@"4"]?@"(您已经是最高级别会员了)":@"(补差钱可升级为高级会员)" textColor:RGB(166, 166, 166) textAlignment:Center font:FONT(14)];
        [bgView addSubview:desLabel];
        
        return bgView;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(bself);
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.row == 0) {
        XBJinRRAgencyCell *agencyCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRAgencyCellID];
        if (self.agencyArray.count>0) {
            //1普通会员  2渠道代理  3团队经理  4城市经理
            NSMutableArray *mArr = [NSMutableArray new];
            NSInteger count = 0;
            if ([self.agencyType isEqualToString:@"1"]) {
                count = 3;
            }else if ([self.agencyType isEqualToString:@"2"]){
                count = 2;
            }else if ([self.agencyType isEqualToString:@"3"]){
                count = 1;
            }else{
                count = 0;
            }
            
            NSLog(@"agencyArray == %@",self.agencyArray);
            for (int i=0; i<self.agencyArray.count; i++) {
                [mArr addObject:self.agencyArray[i]];
            }
            agencyCell.agencysArray = mArr.copy;
        }
        
        agencyCell.clickItemBlock = ^(NSInteger index) {
            bself.agencyIndex = index;

            [bself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        cell = agencyCell;
    } else if (indexPath.row == 1) {
        XBJinRRAgencyMoneyCell *moneyCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRAgencyMoneyCellID];
        moneyCell.agencyLabel.text = [self.agencyType isEqualToString:@"1"]?@"价格":@"差价";
        if (self.agencyArray.count>0) {
            
             //1普通会员  2渠道代理  3团队经理  4城市经理
            NSInteger discountMoney = 0;
            if ([self.agencyType isEqualToString:@"1"]) {
                discountMoney = 0;
            }else if ([self.agencyType isEqualToString:@"2"]){
                NSDictionary *dic = self.agencyArray[2];
                discountMoney = [dic[@"Price"] floatValue];
            }else if ([self.agencyType isEqualToString:@"3"]){
                NSDictionary *dic = self.agencyArray[1];
                discountMoney = [dic[@"Price"] floatValue];
            }else{
                NSDictionary *dic = self.agencyArray[0];
                discountMoney = [dic[@"Price"] floatValue];
            }
            NSDictionary *dic = self.agencyArray[self.agencyIndex];
            moneyCell.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"Price"] floatValue] - discountMoney];
        }
        
        cell = moneyCell;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
@end
