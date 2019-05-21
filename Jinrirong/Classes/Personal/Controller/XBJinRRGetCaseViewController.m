//
//  XBJinRRGetCaseViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRGetCaseViewController.h"
#import "XBJinRRChoosePaymodeCell.h"
#import "XBJinRRPersonalBaseInfoCell.h"
#import "XBJinRRDrawSuccessViewController.h"

@interface XBJinRRGetCaseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITextField *moneyTF;
    UILabel *needMoneyLabel;
}
@property(nonatomic, strong)UITableView *tableView;

/**
 *  是否选择的是银行卡
 */
@property(nonatomic, assign)BOOL isSelectedBank;
@end

@implementation XBJinRRGetCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self setNavTitleStr:@"提现"];
    [self setNavWithTitle:@"提现" isShowBack:YES];
    self.isSelectedBank = YES;
    [self initTableView];
}

- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:@"XBJinRRPersonalBaseInfoCell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRChoosePaymodeCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRChoosePaymodeCell"];
    
    
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    return self.isSelectedBank?3:1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        XBJinRRChoosePaymodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRChoosePaymodeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = indexPath.row==0?@"提现到银行卡":@"提现到支付宝";
        
        if (indexPath.row==0) {
            cell.selectedImageView.image = [UIImage imageNamed:self.isSelectedBank?@"per_agent_selected":@"per_agent_noselected"];
        }else{
            cell.selectedImageView.image = [UIImage imageNamed:self.isSelectedBank?@"per_agent_noselected":@"per_agent_selected"];
        }
        
        
        return cell;
    }
    
    XBJinRRPersonalBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRPersonalBaseInfoCell"];
    [cell.detailTF setHidden:NO];
    [cell.icon setHidden:YES];
    if (self.isSelectedBank) {
        if (indexPath.row==0) {
            cell.nameLabel.text = @"持卡人姓名";
            cell.detailTF.placeholder  = @"持卡人姓名";
        }else if (indexPath.row==1){
            cell.nameLabel.text = @"银行卡号";
            cell.detailTF.placeholder  = @"银行卡号";
        }else{
            cell.nameLabel.text = @"开户行名";
            cell.detailTF.placeholder  = @"开户行名";
        }
    }else{
        cell.nameLabel.text = @"提现账号";
        cell.detailTF.placeholder  = @"请填写账号";
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&indexPath.row==0) {
        self.isSelectedBank = YES;
        
    }
    if (indexPath.section==0&&indexPath.row==1) {
        self.isSelectedBank = NO;
        
    }
    [self.tableView  reloadData];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return SIZE(50);
    }
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return [UIView new];
    }
    
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50)) backgroundColor:ClearColor];
    UILabel *contentLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(10), SIZE(10), SCREEN_WIDTH-SIZE(20), SIZE(30)) backgroundColor:ClearColor text:@"" textColor:RGB(120, 120, 120) textAlignment:Left font:FONT(15)];
    
    
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:@"可提现金额" attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120)}];
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.balances] attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(255, 139, 72)}];
    [attri0 appendAttributedString:attri1];
    contentLabel.attributedText = attri0;
    [bgView addSubview:contentLabel];
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.001;
    }
    return SIZE(180);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        return [UIView new];
    }
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(150)) backgroundColor:WhiteColor];
    
    moneyTF = [ViewCreate createTextFieldFrame:CGRectMake(SIZE(10), SIZE(5), SCREEN_WIDTH-SIZE(20), SIZE(40)) font:FONT(16) textColor:BlackColor placeHolder:@"   请填写要体现的金额，最少20元" delegate:nil];
    moneyTF.layer.borderColor = RGB(231, 231, 231).CGColor;
    moneyTF.layer.borderWidth = 1.f;
    moneyTF.layer.masksToBounds = YES;
    moneyTF.layer.cornerRadius = 5;
    [moneyTF addTarget:self action:@selector(moneyChange:) forControlEvents:UIControlEventEditingChanged];
    moneyTF.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:moneyTF];
    
    
    needMoneyLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(10), SIZE(50), SCREEN_WIDTH-SIZE(20), SIZE(30)) backgroundColor:WhiteColor text:[NSString stringWithFormat:@"第三方手续费用：%@%%",self.cost] textColor:MainColor textAlignment:Left font:FONT(16)];
    [bgView addSubview:needMoneyLabel];
    
    UIButton *makesureBtn  = [ViewCreate createButtonFrame:CGRectMake(SIZE(10), SIZE(110), SCREEN_WIDTH-SIZE(20), SIZE(50)) title:@"确认申请" titleColor:WhiteColor font:FONT(16) backgroundColor:MainColor touchUpInsideEvent:nil];
    makesureBtn.layer.masksToBounds = YES;
    makesureBtn.layer.cornerRadius= SIZE(25);
    [makesureBtn addTarget:self action:@selector(makesureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:makesureBtn];
    return bgView;
}


-(void)moneyChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    double money = [target.text floatValue]*[self.cost floatValue]/100;
    if (money>10000000000) {
        [Dialog toastCenter:@"请输入正确的金额"];
        target.text = [target.text substringToIndex:12];
        return;
    }
    if (!isEmptyStr(target.text)||money>0) {
        needMoneyLabel.text = [NSString stringWithFormat:@"第三方手续费用：¥%.2lf",money];
    }else{
        needMoneyLabel.text = [NSString stringWithFormat:@"第三方手续费用：%@%%",self.cost];
    }
    
}
//点击了申请提现按钮
- (void )makesureBtnClick{
    
    if ([moneyTF.text floatValue]<20) {
        [Dialog toastCenter:@"提现金额最少20元"];
        return;
    }
    
    if (self.isSelectedBank) {
        //选择了银行卡
        XBJinRRPersonalBaseInfoCell *cell0 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        XBJinRRPersonalBaseInfoCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        XBJinRRPersonalBaseInfoCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        if (isEmptyStr(cell0.detailTF.text)) {
            [Dialog toastCenter:@"请输入持卡人姓名"];
            return;
        }
        if (isEmptyStr(cell1.detailTF.text)) {
            [Dialog toastCenter:@"请输入银行卡号"];
            return;
        }
        if (isEmptyStr(cell2.detailTF.text)) {
            [Dialog toastCenter:@"请输入开户行名"];
            return;
        }
        [self submitWithMoney:moneyTF.text card:@"" HolderName:cell0.detailTF.text CardNo2:cell1.detailTF.text BankName:cell2.detailTF.text];
    }else{
        //选择了支付宝
        XBJinRRPersonalBaseInfoCell *cell0 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        if (isEmptyStr(cell0.detailTF.text)) {
            [Dialog toastCenter:@"请输入提现账号"];
            return;
        }
        [self submitWithMoney:moneyTF.text card:cell0.detailTF.text HolderName:@"" CardNo2:@"" BankName:@""];
    }
    
}

- (void )submitWithMoney:(NSString *)money card:(NSString *)card HolderName:(NSString *)HolderName CardNo2:(NSString *)CardNo2 BankName:(NSString *)BankName{
    WS(bself);
    NSDictionary *params = @{@"type":self.isSelectedBank?@"1": @"2",@"money":money,@"card":card,@"HolderName":HolderName,@"CardNo2":CardNo2,@"BankName":BankName};
    [XBJinRRNetworkApiManager drawWithParams:params Block:^(id data) {
        if (rusultIsCorrect) {
            //            [Dialog toastCenter:data[@"message"]];
            
            XBJinRRDrawSuccessViewController *vc = [XBJinRRDrawSuccessViewController new];
            vc.isBankCard = bself.isSelectedBank;
            vc.account = bself.isSelectedBank?CardNo2:card;
            vc.money = money;
            vc.refreshBlock = ^{
                bself.refreshBlock();
                [bself.navigationController popViewControllerAnimated:YES];
            };
            [bself.navigationController pushViewController:vc animated:YES];
        }else{
            
        }
    } fail:^(NSError *errorString) {
        
    }];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
