//
//  XBJinRRRegisterViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRRegisterViewController.h"
#import "XBJinRRCheckCodeModel.h"
#import "XBJinRRCheckCodeView.h"

@interface XBJinRRRegisterViewController ()
{
    UIButton *sendMsgCodeBtn;
}
@property (nonatomic,strong) XBJinRRCheckCodeModel *checkCodeModel;
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) XBJinRRCheckCodeView *checkCodeView;
@property (nonatomic,strong) UITextField *msgCodeTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UISwitch *switchBtn;
@property (strong,nonatomic) NSTimer *timer;//倒计时
@property (assign,nonatomic) int i;
@end

@implementation XBJinRRRegisterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.i = 60;
    [self createUI];
}

- (void)createUI
{
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.scrollEnabled = YES;
    [self.view addSubview:mainScrollView];
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.offset(-StatusBarHeight);
    }];
    
    
    UIImageView *headerImg = [[UIImageView alloc] init];
    [headerImg setUserInteractionEnabled:YES];
    headerImg.image = [UIImage imageNamed:@"login-img"];
    [mainScrollView addSubview:headerImg];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.left.equalTo(mainScrollView.mas_left).offset(0);
        make.right.equalTo(mainScrollView.mas_right).offset(0);
    }];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"loginClose"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [headerImg addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(40);
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"login-pho"];
    [headerImg addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImg.mas_centerX).offset(0);
        make.bottom.equalTo(headerImg.mas_bottom).offset(-20);
    }];
    
    UIImageView *phoneIcon = [[UIImageView alloc] init];
    phoneIcon.image = [UIImage imageNamed:@"registerPhone"];
    [mainScrollView addSubview:phoneIcon];
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollView.mas_left).offset(40);
        make.top.equalTo(headerImg.mas_bottom).offset(50);
    }];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"手机号";
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.font = [UIFont systemFontOfSize:15];
    [mainScrollView addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneIcon.mas_centerY).offset(0);
        make.left.equalTo(phoneIcon.mas_right).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH-140);
    }];
    self.phoneTextField = phoneTextField;
    
    UIView *phoneLine = [[UIView alloc] init];
    phoneLine.backgroundColor = RGB(238, 238, 238);
    [mainScrollView addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.mas_bottom).offset(10);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH-80);
        make.height.offset(1);
    }];
    
    UIImageView *msgCodeIcon = [[UIImageView alloc] init];
    msgCodeIcon.image = [UIImage imageNamed:@"msgCode"];
    [mainScrollView addSubview:msgCodeIcon];
    [msgCodeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(phoneIcon.mas_centerX).offset(0);
        make.top.equalTo(phoneLine.mas_bottom).offset(30);
    }];
    
    UITextField *msgCodeTextField = [[UITextField alloc] init];
    msgCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    msgCodeTextField.placeholder = @"短信验证码";
    msgCodeTextField.font = [UIFont systemFontOfSize:15];
    [mainScrollView addSubview:msgCodeTextField];
    [msgCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(msgCodeIcon.mas_centerY).offset(0);
        make.left.equalTo(phoneTextField.mas_left).offset(0);
        make.width.mas_equalTo(140);
    }];
    self.msgCodeTextField = msgCodeTextField;
    
    UIView *msgCodeLine = [[UIView alloc] init];
    msgCodeLine.backgroundColor = RGB(238, 238, 238);
    [mainScrollView addSubview:msgCodeLine];
    [msgCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(msgCodeTextField.mas_bottom).offset(10);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH-80);
        make.height.offset(1);
    }];
    
    UIImageView *pwdIcon = [[UIImageView alloc] init];
    pwdIcon.image = [UIImage imageNamed:@"forget-password"];
    [mainScrollView addSubview:pwdIcon];
    [pwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(phoneIcon.mas_centerX).offset(0);
        make.top.equalTo(msgCodeLine.mas_bottom).offset(30);
    }];
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.placeholder = @"密码";
    pwdTextField.font = [UIFont systemFontOfSize:15];
    pwdTextField.secureTextEntry = YES;
    [mainScrollView addSubview:pwdTextField];
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pwdIcon.mas_centerY).offset(0);
        make.left.equalTo(phoneTextField.mas_left).offset(0);
        make.width.mas_equalTo(phoneTextField.mas_width);
    }];
    self.pwdTextField = pwdTextField;
    
    UIView *pwdLine = [[UIView alloc] init];
    pwdLine.backgroundColor = RGB(238, 238, 238);
    [mainScrollView addSubview:pwdLine];
    [pwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdTextField.mas_bottom).offset(10);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH-80);
        make.height.offset(1);
    }];
    
//    UIImageView *codeIcon = [[UIImageView alloc] init];
//    codeIcon.image = [UIImage imageNamed:@"msgCode"];
//    [mainScrollView addSubview:codeIcon];
//    [codeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(phoneIcon.mas_centerX).offset(0);
//        make.top.equalTo(pwdLine.mas_bottom).offset(30);
//    }];
//
//    UITextField *codeTextField = [[UITextField alloc] init];
//    codeTextField.placeholder = @"邀请码";
//    codeTextField.font = [UIFont systemFontOfSize:15];
//    [mainScrollView addSubview:codeTextField];
//    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(codeIcon.mas_centerY).offset(0);
//        make.left.equalTo(phoneTextField.mas_left).offset(0);
//        make.width.mas_equalTo(phoneTextField.mas_width);
//    }];
//    self.codeTextField = codeTextField;
    
//    UIView *codeLine = [[UIView alloc] init];
//    codeLine.backgroundColor = [UIColor lightGrayColor];
//    [mainScrollView addSubview:codeLine];
//    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(codeTextField.mas_bottom).offset(10);
//        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
//        make.width.offset(SCREEN_WIDTH-80);
//        make.height.offset(1);
//    }];
    
    
    UISwitch *switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
    [switchBtn setOn: YES animated: YES];
    switchBtn.transform = CGAffineTransformMakeScale( 0.7, 0.7);//缩放
    switchBtn.onTintColor = MainColor;
    [mainScrollView addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollView.mas_left).offset(40*0.7+3);
        make.top.equalTo(pwdLine.mas_bottom).offset(10);
    }];
    self.switchBtn = switchBtn;
    
    UILabel *agressLabel = [[UILabel alloc] init];
    agressLabel.font = [UIFont systemFontOfSize:15];
    NSString *agressStr = @"我已阅读并同意《用户注册协议》";
    NSMutableAttributedString *agressAttStr = [[NSMutableAttributedString alloc] initWithString:agressStr];
    NSRange range = [agressStr rangeOfString:@"《"];
    [agressAttStr addAttributes:@{NSForegroundColorAttributeName:MainColor} range:NSMakeRange(range.location,agressStr.length-7)];
    [agressAttStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 7)];
    agressLabel.attributedText = agressAttStr;
    
    agressLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(readProtocol)];
    [agressLabel addGestureRecognizer:tapper];
    
    [mainScrollView addSubview:agressLabel];
    [agressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(switchBtn.mas_centerY).offset(0);
        make.left.equalTo(switchBtn.mas_right).offset(5);
    }];
    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn addTarget:self action:@selector(registerPhone) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.backgroundColor = MainColor;
    [submitBtn setTitle:@"注册" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 20;
    submitBtn.layer.masksToBounds = YES;
    [mainScrollView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(agressLabel.mas_bottom).offset(40);
        make.left.equalTo(mainScrollView.mas_left).offset(40);
        make.right.equalTo(mainScrollView.mas_right).offset(-40);
        make.height.offset(40);
    }];
    
    UIButton *toLoginBtn = [[UIButton alloc] init];
    [toLoginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [toLoginBtn addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    toLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [toLoginBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [mainScrollView addSubview:toLoginBtn];
    [toLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(submitBtn.mas_bottom).offset(20);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
    }];
    
    sendMsgCodeBtn = [[UIButton alloc] init];
    [sendMsgCodeBtn addTarget:self action:@selector(sendMsgCode) forControlEvents:UIControlEventTouchUpInside];
    [sendMsgCodeBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [sendMsgCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendMsgCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [mainScrollView addSubview:sendMsgCodeBtn];
    [sendMsgCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(msgCodeLine.mas_right).offset(0);
        make.centerY.equalTo(msgCodeTextField.mas_centerY).offset(0);
    }];
    
    [mainScrollView layoutIfNeeded];
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 667);
    
    WS(bself);
    XBJinRRCheckCodeView *checkCodeView = [[XBJinRRCheckCodeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
     checkCodeView.messageType = @"2";
    checkCodeView.picCodeSuccessBlock = ^{
      //这里写倒计时逻辑
        bself.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
    };
    self.checkCodeView = checkCodeView;

}
#pragma mark -- 用户注册协议
- (void )readProtocol{
    XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
    [vc setUrl:nil webType:WebTypeRegistProtocol];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)sendMsgCode
{
    if ([self.phoneTextField.text isEqualToString:@""]) {
//        [SVProgressHUD showInfoWithStatus:@"请输入手机号"];
        [Dialog toastCenter:@"请输入手机号"];
        return;
    }
    WS(wSelf);
    [XBJinRRNetworkApiManager getCheckImgCodeWithBlock:^(id data) {
        XBJinRRCheckCodeModel *checkCodeModel = [XBJinRRCheckCodeModel mj_objectWithKeyValues:data[@"data"]];
        [wSelf.checkCodeView setPhone:wSelf.phoneTextField.text codePic:checkCodeModel.imgPath];
        [wSelf.checkCodeView show];
    } fail:^(NSError *errorString) {
        
    }];
    
}
- (void)registerPhone
{
    if ([self.phoneTextField.text isEqualToString:@""]) {
        //        [SVProgressHUD showInfoWithStatus:@"请输入手机号"];
        [Dialog toastCenter:@"请输入手机号"];
        return;
    }
    if ([self.msgCodeTextField.text isEqualToString:@""]) {
        //        [SVProgressHUD showInfoWithStatus:@"请输入短信验证码"];
        [Dialog toastCenter:@"请输入短信验证码"];
        return;
    }
    if ([self.pwdTextField.text isEqualToString:@""]) {
        //        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        [Dialog toastCenter:@"请输入密码"];
        return;
    }
    if (!self.switchBtn.isOn) {
        //        [SVProgressHUD showInfoWithStatus:@"请阅读并同意《用户注册协议》"];
        [Dialog toastCenter:@"请阅读并同意《用户注册协议》"];
        return;
    }
    WS(bself);
    [self.view showLoadMessageAtCenter:@"注册中..."];
    [XBJinRRNetworkApiManager registerWithMobile:self.phoneTextField.text code:self.msgCodeTextField.text password:self.pwdTextField.text rid:@"" block:^(id data) {
        [bself.view hide];
        if ([data[@"result"] integerValue] == 1) {
            [Dialog toastCenter:data[@"message"]];
            [bself.navigationController popViewControllerAnimated:YES];
        }else{
            [Dialog toastCenter:data[@"message"]];
        }
    } fail:^(NSError *errorString) {
        [bself.view hide];
    }];
    
}
- (void)closeVC
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset=scrollView.contentOffset.y;
    if (offset<=0) {
        self.navigationController.navigationBar.hidden = YES;
    }
    else {
        self.navigationController.navigationBar.hidden = NO;
    }
}

- (void) daojishi {
    self.i --;
    sendMsgCodeBtn.userInteractionEnabled = NO;
    [sendMsgCodeBtn setTitle:[NSString stringWithFormat:@"%ds后重试",self.i] forState:UIControlStateNormal];
    
    if (self.i == -1) {
        [self.timer invalidate];
        self.timer = nil;
        self.i= 60;
        [sendMsgCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        sendMsgCodeBtn.userInteractionEnabled = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.timer setFireDate:[NSDate distantPast]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //    [self.timer invalidate];
    [self.timer setFireDate:[NSDate distantFuture]];
    //    self.timer = nil;
}


@end
