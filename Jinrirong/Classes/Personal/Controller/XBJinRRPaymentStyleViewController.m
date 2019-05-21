//
//  XBJinRRPaymentStyleViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPaymentStyleViewController.h"
#import "XBJinRROrderMoneyCell.h"
#import "XBJinRRPaymentCell.h"
#import "WXWebViewController.h"
#import "XBJinRRCheckCreditDetailListViewController.h"
#import "XBJinRRChangJiePayViewController.h"
#import "XBJinRRPayzenxinViewController.h"
@interface XBJinRRPaymentStyleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
/**
 *  哪一种支付方式
 */
@property(nonatomic, assign)NSInteger index;
@end

@implementation XBJinRRPaymentStyleViewController

static NSString *XBJinRROrderMoneyCellID = @"XBJinRROrderMoneyCellID";
static NSString *XBJinRRPaymentAliPayCellID = @"XBJinRRPaymentAliPayCellID";
static NSString *XBJinRRPaymentWeixinPayCellID = @"XBJinRRPaymentWeixinPayCellID";
static NSString *XBJinRRPaymentBalanceCellID = @"XBJinRRPaymentBalanceCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 1;
//    [self setNavTitleStr:@"支付方式"];
    [self setNavWithTitle:@"支付方式" isShowBack:YES];
    [self createUI];
}
- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[XBJinRROrderMoneyCell class] forCellReuseIdentifier:XBJinRROrderMoneyCellID];
    [self.tableView registerClass:[XBJinRRPaymentCell class] forCellReuseIdentifier:@"XBJinRRPaymentCell"];
//    [tableView registerClass:[XBJinRRPaymentCell class] forCellReuseIdentifier:XBJinRRPaymentWeixinPayCellID];
//    [tableView registerClass:[XBJinRRPaymentCell class] forCellReuseIdentifier:XBJinRRPaymentBalanceCellID];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    UIButton *payBtn = [[UIButton alloc] init];
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setBackgroundColor:MainColor];
    payBtn.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 50);
    payBtn.layer.cornerRadius = 25;
    payBtn.layer.masksToBounds = YES;
    [footerView addSubview:payBtn];
    [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = footerView;
}

-(void )payBtnClick:(UIButton *)sender{
    WS(bself);
    [self.view showLoadMessageAtCenter:@"订单生成中..."];
    if (self.isAgency) {
        NSDictionary *params = @{@"paytype":@(self.index),@"id":self.ID};
        [XBJinRRNetworkApiManager payagentWithParams:params Block:^(id data) {
            [self.view hide];
            if (rusultIsCorrect) {
                NSDictionary *dic = data[@"data"];
                if (self.index==1) {
                    WXWebViewController *vc = [WXWebViewController new];
                    NSString *urlStr = [NSString stringWithFormat:@"%@/index.php/Wachet/index2?id=%@&oid=%@&client=ios",SERVICEURL,dic[@"id"],dic[@"oid"]];
                    vc.payUrlStr = urlStr;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (self.index==2){
                    WXWebViewController *vc = [WXWebViewController new];
                    NSString *urlStr = [NSString stringWithFormat:@"%@/index.php/Alipay/index?id=%@&oid=%@",SERVICEURL,dic[@"id"],dic[@"oid"]];
                    vc.payUrlStr = urlStr;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (self.index==5){//畅捷支付
                    
//                    XBJinRRChangJiePayViewController * vc = [XBJinRRChangJiePayViewController new];
//                    vc.payMoney =  bself.payMoney;
//                    vc.OrderNo = dic[@"oid"];
//
//                    [bself.navigationController pushViewController:vc  animated:YES];
                    
                    
                                        WXWebViewController *vc = [WXWebViewController new];
                                        if ([dic allValues].count>0) {
                                            NSString *urlStr = [NSString stringWithFormat:@"%@/index.php/Alipay/payzenxin?id=%@&oid=%@",SERVICEURL,dic[@"id"],dic[@"oid"]];
                                            vc.payUrlStr = urlStr;
                                            [self.navigationController pushViewController:vc animated:YES];
                                        }else{
                                            [Dialog toastCenter:@"支付订单异常，请联系管理员"];
                                        }
                }else{
                    //购买代理成功后 刷新个人页面，更新代理身份
                    [NSNotic_Center postNotificationName:BUYAGENCYSUCCESS object:nil];
                    
                    [bself.navigationController popToRootViewControllerAnimated:YES];
                    [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
                }
            }else{
                [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            }
        } fail:^(NSError *errorString) {
            [self.view hide];
        }];
    }else{
        NSDictionary *params = @{@"paytype":@(self.index),@"id":self.ID};
        [XBJinRRNetworkApiManager orderpayWithParams:params Block:^(id data) {
            [self.view hide];
            if (rusultIsCorrect) {
                NSDictionary *dic = data[@"data"];
                if (self.index==1) {
                    WXWebViewController *vc = [WXWebViewController new];
                    if ([dic allValues].count>0) {
                        NSString *urlStr = [NSString stringWithFormat:@"%@/index.php/Wachet/payzenxin2?id=%@&oid=%@&client=ios",SERVICEURL,dic[@"id"],dic[@"oid"]];
                        vc.payUrlStr = urlStr;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [Dialog toastCenter:@"支付订单异常，请联系管理员"];
                    }
                    
                    
                }else if (self.index==2){
                    WXWebViewController *vc = [WXWebViewController new];
                    if ([dic allValues].count>0) {
                        NSString *urlStr = [NSString stringWithFormat:@"%@/index.php/Alipay/payzenxin?id=%@&oid=%@",SERVICEURL,dic[@"id"],dic[@"oid"]];
                        vc.payUrlStr = urlStr;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [Dialog toastCenter:@"支付订单异常，请联系管理员"];
                    }
                }
                else if (self.index==5){//畅捷支付
//                    XBJinRRPayzenxinViewController * vc = [XBJinRRPayzenxinViewController new];
//                    vc.payMoney =  bself.payMoney;
//                    vc.OrderNo = dic[@"oid"];
//
//                    [bself.navigationController pushViewController:vc  animated:YES];
                    WXWebViewController *vc = [WXWebViewController new];
                    if ([dic allValues].count>0) {
                        NSString *urlStr = [NSString stringWithFormat:@"%@/index.php/Alipay/payzenxin?id=%@&oid=%@",SERVICEURL,dic[@"id"],dic[@"oid"]];
                        vc.payUrlStr = urlStr;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [Dialog toastCenter:@"支付订单异常，请联系管理员"];
                    }
                }else{
                    [NSNotic_Center postNotificationName:BUYAGENCYSUCCESS object:nil];
                    [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
                    //                    [bself.navigationController popToRootViewControllerAnimated:YES];
                    XBJinRRCheckCreditDetailListViewController *vc = [XBJinRRCheckCreditDetailListViewController new];
                    vc.fromWay = @"payment";
                    [bself.navigationController pushViewController:vc animated:YES];
                }
            }else{
                [NSNotic_Center postNotificationName:BUYAGENCYSUCCESS object:nil];
                [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
                XBJinRRCheckCreditDetailListViewController *vc = [XBJinRRCheckCreditDetailListViewController new];
                vc.fromWay = @"payment";
                [bself.navigationController pushViewController:vc animated:YES];
            }
        } fail:^(NSError *errorString) {
            [self.view hide];
        }];
    }
}



#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        XBJinRROrderMoneyCell *moneyCell = [tableView dequeueReusableCellWithIdentifier:XBJinRROrderMoneyCellID];
        [moneyCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        moneyCell.payMoney = self.payMoney;
        
        return moneyCell;
        
    }
    else if (indexPath.row == 1) {

        XBJinRRPaymentCell *alipayCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRPaymentCell"];
        [alipayCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        alipayCell.icon.image = [UIImage imageNamed:@"per-purchase-alipayicon"];
        alipayCell.nameLabel.text = @"支付宝支付";
        alipayCell.descLabel.text = @"支付宝快速购买";
        alipayCell.imageName = self.index == 2?@"per_agent_selected":@"per_agent_noselected";
        return alipayCell;
    }
//    else if (indexPath.row == 1) {
//        XBJinRRPaymentCell *weixinpayCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRPaymentCell"];
//        weixinpayCell.icon.image = [UIImage imageNamed:@"per-purchase-weixin"];
//        [weixinpayCell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        weixinpayCell.nameLabel.text = @"微信支付";
//        weixinpayCell.descLabel.text = @"微信第三方快速支付";
//        weixinpayCell.imageName = self.index == 1?@"per_agent_selected":@"per_agent_noselected";
//        return weixinpayCell;
//    }
//    else if (indexPath.row == 1) {
//        XBJinRRPaymentCell *weixinpayCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRPaymentCell"];
//        weixinpayCell.icon.image = [UIImage imageNamed:@"changjiepay"];
//        [weixinpayCell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        weixinpayCell.nameLabel.text = @"支付包支付";
//        weixinpayCell.descLabel.text = @"支付包支付快速支付";
//        weixinpayCell.imageName = self.index == 5?@"per_agent_selected":@"per_agent_noselected";
//        return weixinpayCell;
//    }
    else {
        XBJinRRPaymentCell *balanceCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRPaymentCell"];
        [balanceCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        balanceCell.icon.image = [UIImage imageNamed:@"balance"];
        balanceCell.nameLabel.text = @"余额支付";
        balanceCell.descLabel.text = @"账户余额支付";
        balanceCell.imageName = self.index == 3?@"per_agent_selected":@"per_agent_noselected";
        return balanceCell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        return;
    }
    
//    if (indexPath.row == 1) {
//        self.index = 1;
//    }
//    else if (indexPath.row == 1){
//        self.index = 2;
//    }
    else if (indexPath.row == 1){
        self.index = 2;
    }
        else if (indexPath.row == 2){
        self.index = 3;
    }
    
    
    
    
    [self.tableView reloadData];
}


@end
