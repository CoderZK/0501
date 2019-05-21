//
//  XBJinRRPayzenxinViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/10/13.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPayzenxinViewController.h"
#import "XBJinRRChangJiePayTableViewCell.h"
#import "XBJinRRchangjiePayModel.h"
@interface XBJinRRPayzenxinViewController ()
<UITableViewDelegate,UITableViewDataSource>
{
    BOOL  isMessage;
}
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray,*phoneArray;
@property (nonatomic, strong) XBJinRRchangjiePayModel *cHXBankModel;
@property (nonatomic, strong) NSString *TrxId;
@end

@implementation XBJinRRPayzenxinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:@"短信验证" isShowBack:YES];
    
    [self createUI];
    _TrxId = @"";
    _cHXBankModel = [[XBJinRRchangjiePayModel alloc]init];
    isMessage = NO;
    _titleArray = @[@"订单金额",@"真实姓名",@"身份证号",@"银行卡号",@"银行预留手机号",@"短信验证码"];
    _phoneArray = @[@"",@"请填写真实姓名",@"请输入身份证号",@"请输入银行卡号",@"请填写银行预留手机号",@"请输入短信验证码"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangeValue:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)textFieldDidChangeValue:(NSNotification *)notification
{
    UITextField *sender = (UITextField *)[notification object];
    if (sender.tag==4001) {
        _cHXBankModel.CertName = sender.text;
    }else if (sender.tag==4002){
        _cHXBankModel.CertNo = sender.text;
    }else if (sender.tag==4003){
        _cHXBankModel.BankNo = sender.text;
    }else if (sender.tag==4004){
        _cHXBankModel.CertPhone = sender.text;
    }else if (sender.tag==4005){
        _cHXBankModel.Smscode = sender.text;
    }
}

- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    if (@available(ios 11.0,*)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.view addSubview:self.tableView];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIButton *payBtn = [[UIButton alloc] init];
    [payBtn setTitle:@"确认验证" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setBackgroundColor:MainColor];
    payBtn.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 50);
    payBtn.layer.cornerRadius = 25;
    payBtn.layer.masksToBounds = YES;
    [footerView addSubview:payBtn];
    [payBtn addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footerView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(NAV_HEIGHT);
        make.left.right.bottom.mas_offset(0);
    }];
    [self.tableView registerClass:[XBJinRRChangJiePayTableViewCell class] forCellReuseIdentifier:@"XBJinRRChangJiePayTableViewCell"];
}

#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isMessage) {
        return _titleArray.count;
    }
    return _titleArray.count-1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBJinRRChangJiePayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRChangJiePayTableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //  cell.contentLabel = _titleArray[indexPath.row];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.inputTF.tag = 4000+indexPath.row;
    if (indexPath.row==0){
        cell.inputTF.text = [NSString stringWithFormat:@"¥%@",self.payMoney];
    }else if (indexPath.row==1) {
        cell.inputTF.text = _cHXBankModel.CertName;
    }else if (indexPath.row==2){
        cell.inputTF.text = _cHXBankModel.CertNo;
    }else if (indexPath.row==3){
        cell.inputTF.text = _cHXBankModel.BankNo;
    }else if (indexPath.row==4){
        cell.inputTF.text = _cHXBankModel.CertPhone;
    }else if (indexPath.row==5){
        cell.inputTF.text = _cHXBankModel.Smscode;
    }
    cell.inputTF.placeholder = _phoneArray[indexPath.row];
    return cell;
}



-(void)payBtnClick{
    
    if (isMessage) {
        if([self isBlankString:_cHXBankModel.Smscode]){
            [Dialog toastCenter:@"请输入短信验证码"];
            return;
        }
        
        WS(weakSelf);
        [self.view showLoadMessageAtCenter:@"加载中..."];
        
        [XBJinRRNetworkApiManager Center_Payzenxin_NowPayConfirmWithOrderNo:self.OrderNo Smscode:_cHXBankModel.Smscode Block:^(id data) {
            [weakSelf.view hide];
            if ([data[@"result"]intValue]==1) {
                [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
                
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            }
            
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            
            
        } fail:^(NSError *errorString) {
            [weakSelf.view hide];
        }];
        
        
        
        //        [[APIManager sharedManager]Center_Chanpay_AuthBindSmsComfirmTrxId:_TrxId SmsCode:_cHXBankModel.msgcode AddBlock:^(id data, NSError *error) {
        //            [self.view hide];
        //            if (!error) {
        //                if ([data[@"result"]intValue]==1) {
        //                    self->isMessage = YES;
        //                    [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        //                    NSUserDefaults *dingId = [NSUserDefaults standardUserDefaults];
        //
        //                    [[APIManager sharedManager]Center_Chanpay_AuthedBankListorder_id:[dingId objectForKey:@"dingId"] stype:weakSelf.stype AddBlock:^(id data, NSError *error) {
        //                        if (!error) {
        //                            if ([data[@"result"]intValue]==1){
        //                                NSArray *agreeList = data[@"data"][@"agreeList"];
        //                                if (agreeList.count>0) {
        //                                    XBCertenlyPayReimbursementViewController *vc = [[XBCertenlyPayReimbursementViewController alloc]init];
        //                                    vc.agreeListArray = [AgreeListModel mj_objectArrayWithKeyValuesArray:agreeList];
        //                                    vc.AgreeNo = data[@"data"][@"AgreeNo"];
        //                                    vc.card = weakSelf.cHXBankModel.card;
        //                                    // vc.mobile = weakSelf.cHXBankModel.mobile;
        //                                    vc.RealName = weakSelf.cHXBankModel.RealName;
        //                                    vc.BankCode = weakSelf.cHXBankModel.BankCode;
        //                                    //                                    vc.aid = self->_TrxId;
        //                                    vc.stype = weakSelf.stype;
        //                                    [self.navigationController pushViewController:vc animated:YES];
        //
        //                                }else{
        //                                    [weakSelf.navigationController popViewControllerAnimated:YES];
        //                                }
        //                            }
        //                            else{
        //                                [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        //                            }
        //                        }
        //                    }];
        //                }else{
        //                    [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        //                }
        //            }
        //        }];
        
        
        
    }else{
        
        if ([self isBlankString:_cHXBankModel.BankNo]) {
            [Dialog toastCenter:@"请输入银行卡号"];
            return;
        }else if([self isBlankString:_cHXBankModel.CertName]){
            [Dialog toastCenter:@"请输入真实姓名"];
            return;
        }else if([self isBlankString:_cHXBankModel.CertNo]){
            [Dialog toastCenter:@"请输入身份证号"];
            return;
        }else if([self isBlankString:_cHXBankModel.CertPhone]){
            [Dialog toastCenter:@"请输入银行预留手机"];
            return;
        }
        [self.view showLoadMessageAtCenter:@"加载中..."];
        
        
        WS(weakSelf);
        
        [XBJinRRNetworkApiManager Center_Payzenxin_NowPayWithOrderNo:self.OrderNo BankNo:_cHXBankModel.BankNo CertNo:_cHXBankModel.CertNo CertName:_cHXBankModel.CertName CertPhone:_cHXBankModel.CertPhone Block:^(id data) {
            [weakSelf.view hide];
            if ([data[@"result"]intValue]==1) {
                self->isMessage = YES;
                [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
                [weakSelf.tableView reloadData];
            }else{
                [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            }
            
            
            
        } fail:^(NSError *errorString) {
            [weakSelf.view hide];
        }];
        
        
        
        
        
        
        
        //        [[APIManager sharedManager]Center_Chanpay_AuthBindSmsbank_no:_cHXBankModel.BankCode phone:_cHXBankModel.mobile AddBlock:^(id data, NSError *error) {
        //            [self.view hide];
        //            if (!error) {
        //                if ([data[@"result"]intValue]==1) {
        //                    self->isMessage = YES;
        //                    self->_TrxId = data[@"data"][@"TrxId"];
        //                    [weakSelf.tableView reloadData];
        //                    [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        //                }else if ([data[@"result"]intValue]==2){
        //
        //                    NSUserDefaults *dingId = [NSUserDefaults standardUserDefaults];
        //
        //                    [[APIManager sharedManager]Center_Chanpay_AuthedBankListorder_id:[dingId objectForKey:@"dingId"] stype:weakSelf.stype AddBlock:^(id data, NSError *error) {
        //                        if (!error) {
        //                            if ([data[@"result"]intValue]==1){
        //                                NSArray *agreeList = data[@"data"][@"agreeList"];
        //                                if (agreeList.count>0) {
        //                                    XBCertenlyPayReimbursementViewController *vc = [[XBCertenlyPayReimbursementViewController alloc]init];
        //                                    vc.agreeListArray = [AgreeListModel mj_objectArrayWithKeyValuesArray:agreeList];
        //                                    vc.AgreeNo = data[@"data"][@"AgreeNo"];
        //                                    vc.card = weakSelf.cHXBankModel.card;
        //                                    // vc.mobile = weakSelf.cHXBankModel.mobile;
        //                                    vc.RealName = weakSelf.cHXBankModel.RealName;
        //                                    vc.BankCode = weakSelf.cHXBankModel.BankCode;
        //                                    //                                    vc.aid = self->_TrxId;
        //                                    vc.stype = weakSelf.stype;
        //                                    [self.navigationController pushViewController:vc animated:YES];
        //                                }
        //                            }
        //                            else{
        //                                [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        //                            }
        //                        }
        //                    }];
        //                }else{
        //                    [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        //                }
        //            }
        //        }];
        
    }
    
    
}
- (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

















@end
