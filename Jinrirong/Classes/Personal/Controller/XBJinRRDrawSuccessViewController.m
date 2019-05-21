//
//  XBJinRRDrawSuccessViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//  提现申请已提交

#import "XBJinRRDrawSuccessViewController.h"

@interface XBJinRRDrawSuccessViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@end

@implementation XBJinRRDrawSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"提现"];
    
    [self setNavWithTitle:@"提现" isShowBack:YES];
    [self initTableView];
    [Dialog toastCenter:@"融e贷：提现申请已提交，我们将在24小时内核实结算。"];
}

#pragma mark -- 表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE(50);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = FONT(17);
    cell.detailTextLabel.font = FONT(17);
    cell.textLabel.textColor = RGB(66, 66, 66);
    cell.detailTextLabel.textColor = RGB(66, 66, 66);
    if (indexPath.row==0) {
        cell.textLabel.text = self.isBankCard?@"银行卡":@"支付宝账号";
        cell.detailTextLabel.text = self.account;
    }else{
        cell.textLabel.text = @"金额";
        cell.detailTextLabel.text = self.money;
    }
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(210);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{//distribution_wallet_complete
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(210)) backgroundColor:WhiteColor];
    UIView *line0 = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10) backgroundColor:NORMAL_BGCOLOR];
    [bgView addSubview:line0];
    
    UIImageView *myImageView = [ViewCreate createImageViewFrame:CGRectMake((SCREEN_WIDTH-SIZE(120))*0.5, SIZE(30), SIZE(100), SIZE(100)) image:@"distribution_wallet_complete"];
    [bgView addSubview:myImageView];
    
    UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(10), SIZE(150), SCREEN_WIDTH-SIZE(20), SIZE(30)) backgroundColor:WhiteColor text:@"提现申请已提交" textColor:BlackColor textAlignment:Center font:FONT(17)];
    [bgView addSubview:titleLabel];
    
    UIView *line1 = [ViewCreate createLineFrame:CGRectMake(0,SIZE(210)-10, SCREEN_WIDTH, 10) backgroundColor:NORMAL_BGCOLOR];
    [bgView addSubview:line1];
    
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SIZE(90);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(90)) backgroundColor:ClearColor];
    
    UIButton *okBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(10), SIZE(20), SCREEN_WIDTH-SIZE(20), SIZE(50)) title:@"完成" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    okBtn.layer.masksToBounds = YES;
    okBtn.layer.cornerRadius= SIZE(25);
    [bgView addSubview:okBtn];
    return bgView;
}

- (void )okBtnClick{
    self.refreshBlock();
    [self.navigationController popViewControllerAnimated:YES];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
