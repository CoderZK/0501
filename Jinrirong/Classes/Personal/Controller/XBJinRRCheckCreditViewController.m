//
//  XBJinRRCheckCreditViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCheckCreditViewController.h"
#import "XBJinRRCheckCreditCell.h"
#import "XBJinRRPaymentStyleViewController.h"
#import "XBJinRRCheckCreditDetailListViewController.h"

@interface XBJinRRCheckCreditViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation XBJinRRCheckCreditViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setNavTitleStr:@"查征信"];
    [self setNavWithTitle:@"查征信" isShowBack:YES];
    [self createUI];
}
- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[XBJinRRCheckCreditCell class] forCellReuseIdentifier:@"XBJinRRCheckCreditCell"];

    
    
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    
    UIButton *submitBtn = [[UIButton alloc] init];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn setTitle:@"立即提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:MainColor];
    submitBtn.frame = CGRectMake(20, 0, SCREEN_WIDTH-40, 50);
    submitBtn.layer.cornerRadius = 25;
    submitBtn.layer.masksToBounds = YES;
    [footer addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *checkStr = [[NSMutableAttributedString alloc] initWithString:@"查询历史"];
    [checkStr addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:MainColor} range:NSMakeRange(0, [checkStr length])];
    UIButton *checkHistoryBtn = [[UIButton alloc] init];
    checkHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [checkHistoryBtn setAttributedTitle:checkStr forState:UIControlStateNormal];
    [footer addSubview:checkHistoryBtn];
    [checkHistoryBtn addTarget:self action:@selector(checkHistoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [checkHistoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footer.mas_centerX).offset(0);
        make.top.equalTo(submitBtn.mas_bottom).offset(30);
    }];
    
    self.tableView.tableFooterView = footer;
}
#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        XBJinRRCheckCreditCell *trueCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCheckCreditCell"];
        trueCell.selectionStyle = UITableViewCellSelectionStyleNone;
        trueCell.nameLabel.text = @"真实姓名";
        trueCell.valueTF.placeholder = @"真实姓名";
        return trueCell;
    } else if (indexPath.row == 1) {
        XBJinRRCheckCreditCell *noCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCheckCreditCell"];
        noCell.selectionStyle = UITableViewCellSelectionStyleNone;
        noCell.nameLabel.text = @"身份证号";
        noCell.valueTF.placeholder = @"身份证号";
        noCell.valueTF.keyboardType = UIKeyboardTypeNumberPad;;
        return noCell;
    } else {
        XBJinRRCheckCreditCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCheckCreditCell"];
        phoneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        phoneCell.nameLabel.text = @"手机号";
        phoneCell.valueTF.placeholder = @"手机号";
        phoneCell.valueTF.keyboardType = UIKeyboardTypePhonePad;
        return phoneCell;
    }
    
}

//提交征信
- (void )submitBtnClick:(UIButton *)sender{
    XBJinRRCheckCreditCell *cell0 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
    XBJinRRCheckCreditCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0 ]];
    XBJinRRCheckCreditCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0 ]];
    
    if (isEmptyStr(cell0.valueTF.text)) {
        [Dialog toastCenter:@"姓名不能为空"];
        return;
    }
    if (isEmptyStr(cell1.valueTF.text)) {
        [Dialog toastCenter:@"身份证号不能为空"];
        return;
    }
    if (isEmptyStr(cell2.valueTF.text)) {
        [Dialog toastCenter:@"手机号不能为空"];
        return;
    }
    WS(bself);
    [self.view showLoadMessageAtCenter:@"加载中..."];
    
    NSDictionary *params = @{@"truename":cell0.valueTF.text,@"cardID":cell1.valueTF.text,@"mobile":cell2.valueTF.text};
    [XBJinRRNetworkApiManager submitinfoWithParams:params Block:^(id data) {
        [bself.view hide];
        if (rusultIsCorrect) {
            NSDictionary *dic = data[@"data"];
            //成功
            XBJinRRPaymentStyleViewController *vc = [XBJinRRPaymentStyleViewController new];
            vc.payMoney = [NSString stringWithFormat:@"%@",dic[@"ZxPay"]];
            vc.ID = [NSString stringWithFormat:@"%@",dic[@"ID"]];
            vc.isAgency = NO;
            [bself.navigationController pushViewController:vc animated:YES];
        }else{
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        }
        
    } fail:^(NSError *errorString) {
        [bself.view hide];
    }];
    
}

//查看查询历史
- (void )checkHistoryBtnClick{
    XBJinRRCheckCreditDetailListViewController *vc = [XBJinRRCheckCreditDetailListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
