//
//  XBJinRRLoginViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRLoginViewController.h"
#import "XBJinRRFindPwdViewController.h"
#import "XBJinRRRegisterViewController.h"
#import "SVProgressHUD.h"
#import "Security.h"
#import "NSString+MD5Extension.h"

@interface XBJinRRLoginViewController ()
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@end

@implementation XBJinRRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createUI];
}
- (void)createUI
{
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
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
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"请输入手机号";
    
    
    phoneTextField.text = isEmptyStr([UDefault getObject:USERNUMBER])?@"":[UDefault getObject:USERNUMBER];
    
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [mainScrollView addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImg.mas_bottom).offset(80);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH-120);
    }];
    self.phoneTextField = phoneTextField;
    
    UIView *phoneLine = [[UIView alloc] init];
    phoneLine.backgroundColor = [UIColor lightGrayColor];
    [mainScrollView addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.mas_bottom).offset(10);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH-120);
        make.height.offset(1);
    }];
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.placeholder = @"请输入密码";
    pwdTextField.secureTextEntry = YES;
    [mainScrollView addSubview:pwdTextField];
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLine.mas_bottom).offset(40);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH-120);
    }];
    self.pwdTextField = pwdTextField;
    
    UIView *pwdLine = [[UIView alloc] init];
    pwdLine.backgroundColor = [UIColor lightGrayColor];
    [mainScrollView addSubview:pwdLine];
    [pwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdTextField.mas_bottom).offset(10);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH-120);
        make.height.offset(1);
    }];
    
    UIButton *findPwdBtn = [[UIButton alloc] init];
    [findPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [findPwdBtn setTitleColor:MainColor forState:UIControlStateNormal];
    findPwdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [findPwdBtn addTarget:self action:@selector(toFindPwd) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:findPwdBtn];
    [findPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdLine.mas_bottom).offset(15);
        make.left.equalTo(pwdLine.mas_left).offset(0);
    }];
    
    UIButton *toRegisterBtn = [[UIButton alloc] init];
    [toRegisterBtn setTitle:@"注册登录" forState:UIControlStateNormal];
    [toRegisterBtn setTitleColor:RGB(255, 151, 0) forState:UIControlStateNormal];
    toRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [toRegisterBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:toRegisterBtn];
    [toRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdLine.mas_bottom).offset(15);
        make.right.equalTo(pwdLine.mas_right).offset(0);
    }];
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginBtn setBackgroundColor:MainColor];
    loginBtn.layer.cornerRadius = 25;
    loginBtn.layer.masksToBounds = YES;
    [mainScrollView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(findPwdBtn.mas_bottom).offset(30);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH-120);
        make.height.offset(50);
    }];
}
- (void)clickLogin
{
    NSString *phone = self.phoneTextField.text;
    NSString *psw = self.pwdTextField.text;
    
    if ([phone isEqualToString:@""]) {
        [Dialog toastCenter:@"请输入手机号"];
        return ;
    }
    
    if ([psw isEqualToString:@""]) {
        [Dialog toastCenter:@"请输入密码"];
        return ;
    }
    [XBJinRRNetworkApiManager requestTimestampWithPhone:phone Psw:psw block:^(id data) {
        if ([data[@"result"] integerValue] == 1) {

            [UDefault setObject:data[@"data"][@"ID"] keys:TICKSID];
            [UDefault setObject:data[@"data"][@"Val"] keys:TICKSVAL];
            
            
            NSString *firstTokenpartString= [[Security shareSecurity] getMD5StringWithphoneStr:phone timeVal:[UDefault getObject:TICKSVAL]];
            NSString *secondTokenpartString = [[Security shareSecurity] getMD5StringWithClientStr:@"ios" timeID:[UDefault getObject:TICKSID] pwdStr:psw];
            NSString *token =[NSString stringWithFormat:@"%@%@",firstTokenpartString,secondTokenpartString];
            NSString *key =[[[NSString stringWithFormat:@"%@%@",[[Security shareSecurity] getTwoResultsForMD5:phone],[UDefault getObject:TICKSVAL]] md5] substringWithRange:NSMakeRange(2 , 30)];
            NSString *keyString =[NSString stringWithFormat:@"XB%@",key];
            
            NSString *iv = [[[NSString stringWithFormat:@"%@%@",[psw md5],[UDefault getObject:TICKSID]] md5] substringWithRange:NSMakeRange(2 , 14)];
            NSString *ivString =[NSString stringWithFormat:@"XB%@",iv];
            [UDefault setObject:token keys:TOKEN];
            [UDefault setObject:keyString keys:MD5KEY];
            [UDefault setObject:ivString keys:MD5IV];

            [XBJinRRNetworkApiManager loginWithMobile:phone token:token block:^(id data) {
                MyLog(@"%@",data);
                
                if ([data[@"result"] integerValue] == 1) {
//                    [UDefault setObject:[NSString stringWithFormat:@"%@",data[@"Token"]] keys:TOKEN];
                    [UDefault setObject:phone keys:USERNUMBER];
                    [Dialog toastCenter:@"登录成功"];
//                    [SVProgressHUD showInfoWithStatus:@"登录成功"];
                    [NSNotic_Center postNotificationName:SIGNINSUCCESS object:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            } fail:^(NSError *errorString) {
                
            }];
            
        }
    } fail:^(NSError *errorString) {
        
    }];
}
- (void)toRegister
{
    XBJinRRRegisterViewController *vc = [[XBJinRRRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)toFindPwd
{
    XBJinRRFindPwdViewController *vc = [[XBJinRRFindPwdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)closeVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
@end
