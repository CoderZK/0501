//
//  XBJinRR_ForgetPwdViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/24.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_ForgetPwdViewController.h"
#import "XBJinRR_InputTFCell.h"

@interface XBJinRR_ForgetPwdViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation XBJinRR_ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"忘记密码"];
    [self setNavWithTitle:@"忘记密码" isShowBack:YES];
    [self initTableView];
}

#pragma mark -- 创建表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
     [_tableView registerNib:[UINib nibWithNibName:@"XBJinRR_InputTFCell" bundle:nil] forCellReuseIdentifier:@"XBJinRR_InputTFCell"];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBJinRR_InputTFCell *phoneTFCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_InputTFCell"];
    phoneTFCell.codeInputTF.keyboardType =  UIKeyboardTypeASCIICapable;
    phoneTFCell.codeInputTF.secureTextEntry = YES;
    phoneTFCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        phoneTFCell.codeInputTF.placeholder = @"重置您的密码";
    }else{
        phoneTFCell.codeInputTF.placeholder = @"再次重置您的密码";
    }
    return phoneTFCell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE(55);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SIZE(80);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(80))];
    bgView.backgroundColor = [UIColor clearColor];
    UIButton *nextStepBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(30), SIZE(30), SCREEN_WIDTH-SIZE(60), SIZE(50)) title:@"完成" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
    [nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:nextStepBtn];
    nextStepBtn.layer.masksToBounds = YES;
    nextStepBtn.layer.cornerRadius = SIZE(25);
    return bgView;
}
//完成修改密码
- (void )nextStepBtnClick{
    XBJinRR_InputTFCell *pwdCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    XBJinRR_InputTFCell *repwdCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (isEmptyStr(pwdCell.codeInputTF.text)||isEmptyStr(repwdCell.codeInputTF.text)) {
        [Dialog toastCenter:@"密码不能为空"];
        return;
    }
    if (![pwdCell.codeInputTF.text isEqualToString:repwdCell.codeInputTF.text]) {
        [Dialog toastCenter:@"两次密码输入不一致"];
        return;
    }
    if (pwdCell.codeInputTF.text.length<6) {
        [Dialog toastCenter:@"密码长度不足6位"];
        return;
    }
    NSDictionary *parms = @{@"Mobile":self.phoneNum,@"pwd":pwdCell.codeInputTF.text};
    WS(bself);
    [XBJinRRNetworkApiManager resetPwdWithParams:parms Block:^(id data) {
        if (rusultIsCorrect) {
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LLUtils showAlterView:self title:@"重置密码成功，请重新登录" message:@"" yesBtnTitle:@"返回登录" noBtnTitle:@"" yesBlock:^{
                    [bself.navigationController popToRootViewControllerAnimated:YES];
                } noBlock:nil];
            });
        }else{
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        }
    } fail:^(NSError *errorString) {
//        [Dialog toastCenter:@"网络错误"];
    }];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
