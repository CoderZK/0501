//
//  XBJinRRCheckCodeView.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/11.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCheckCodeView.h"
#import "XBJinRRCheckCodeModel.h"
#import "SDImageCache.h"

@interface XBJinRRCheckCodeView()
@property (nonatomic,strong) UIImageView *codePic;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextField *codeTextfield;
@end

@implementation XBJinRRCheckCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUserInteractionEnabled:YES];
        UIView *bg = [[UIView alloc] init];
        [bg setUserInteractionEnabled:YES];
        bg.backgroundColor = RGBA(96, 96, 96, 0.6);
        bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:bg];
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        //        [bg addGestureRecognizer:tap];
        
        UIView *checkCodeView = [[UIView alloc] init];
        checkCodeView.backgroundColor = [UIColor whiteColor];
        checkCodeView.layer.cornerRadius = 6;
        checkCodeView.layer.masksToBounds = YES;
        [bg addSubview:checkCodeView];
        [checkCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bg);
            make.centerY.equalTo(bg).offset(-30);
            make.width.offset(300);
            make.height.offset(280);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:17];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"短信验证";
        [checkCodeView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(checkCodeView.mas_top).offset(20);
            make.centerX.equalTo(checkCodeView.mas_centerX).offset(0);
        }];
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = [UIFont systemFontOfSize:14];
        descLabel.textColor = [UIColor grayColor];
        descLabel.text = @"本次操作需要手机短信确认，验证码短信将发送至您的手机上，请注意查收！";
        descLabel.numberOfLines = 0;
        [checkCodeView addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(20);
            make.centerX.equalTo(checkCodeView.mas_centerX).offset(0);
            make.width.offset(250-40);
            make.left.equalTo(checkCodeView.mas_left).offset(20);
        }];
        
        UIView *phoneView = [[UIView alloc] init];
        phoneView.backgroundColor = RGB(249, 249, 249);
        phoneView.layer.cornerRadius = 2;
        phoneView.layer.masksToBounds = YES;
        phoneView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        phoneView.layer.borderWidth = 0.5;
        [checkCodeView addSubview:phoneView];
        [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(descLabel.mas_bottom).offset(10);
            make.left.equalTo(checkCodeView.mas_left).offset(20);
            make.centerX.equalTo(checkCodeView.mas_centerX).offset(0);
            make.width.offset(250-40);
            make.height.offset(40);
        }];
        
        UIImageView *phoneIcon = [[UIImageView alloc] init];
        phoneIcon.image = [UIImage imageNamed:@"icon_tel"];
        [phoneView addSubview:phoneIcon];
        [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneView.mas_left).offset(10);
            make.centerY.equalTo(phoneView.mas_centerY).offset(0);
            make.width.offset(14);
            make.height.offset(21);
        }];
        
        UILabel *phoneLabel = [[UILabel alloc] init];
        phoneLabel.font = [UIFont systemFontOfSize:14];
        phoneLabel.textColor = [UIColor lightGrayColor];
        phoneLabel.text = @"手机号";
        [phoneView addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneIcon.mas_right).offset(8);
            make.centerY.equalTo(phoneView.mas_centerY).offset(0);
        }];
        self.phoneLabel = phoneLabel;
        
        UIView *codeView = [[UIView alloc] init];
        codeView.backgroundColor = RGB(249, 249, 249);
        codeView.layer.cornerRadius = 2;
        codeView.layer.masksToBounds = YES;
        codeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        codeView.layer.borderWidth = 0.5;
        [checkCodeView addSubview:codeView];
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phoneView.mas_bottom).offset(10);
            make.left.equalTo(checkCodeView.mas_left).offset(20);
            make.centerX.equalTo(checkCodeView.mas_centerX).offset(0);
            make.width.offset(250-40);
            make.height.offset(40);
        }];
        
        UIImageView *codeIcon = [[UIImageView alloc] init];
        codeIcon.image = [UIImage imageNamed:@"icon_code"];
        [codeView addSubview:codeIcon];
        [codeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(codeView.mas_left).offset(10);
            make.centerY.equalTo(codeView.mas_centerY).offset(0);
            make.width.offset(19.5);
            make.height.offset(15);
        }];
        
        UITextField *codeTextfield = [[UITextField alloc] init];
        codeTextfield.font = [UIFont systemFontOfSize:14];
        codeTextfield.textColor = [UIColor grayColor];
        codeTextfield.placeholder = @"图形验证码";
        codeTextfield.keyboardType = UIKeyboardTypeNumberPad;
        [codeView addSubview:codeTextfield];
        [codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneLabel.mas_left).offset(0);
            make.centerY.equalTo(codeView.mas_centerY).offset(0);
        }];
        self.codeTextfield = codeTextfield;
        
        UIImageView *codePic = [[UIImageView alloc] init];
        [codePic setUserInteractionEnabled:YES];
        [codeView addSubview:codePic];
        [codePic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(codeView.mas_right).offset(-5);
            make.centerY.equalTo(codeView.mas_centerY).offset(0);
            make.width.offset(70);
            make.height.offset(35);
        }];
        self.codePic = codePic;
        UITapGestureRecognizer *tapCodePic = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCodePic)];
        [codePic addGestureRecognizer:tapCodePic];
        
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [checkCodeView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(checkCodeView.mas_bottom).offset(0);
            make.width.offset(250*0.5);
            make.height.offset(50);
            make.left.equalTo(checkCodeView.mas_left).offset(0);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [checkCodeView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0.5);
            make.height.offset(30);
            make.centerX.equalTo(checkCodeView.mas_centerX).offset(0);
            make.bottom.equalTo(checkCodeView.mas_bottom).offset(-10);
        }];
        
        UIButton *okBtn = [[UIButton alloc] init];
        [okBtn addTarget:self action:@selector(clickOkBtn) forControlEvents:UIControlEventTouchUpInside];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [okBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [checkCodeView addSubview:okBtn];
        [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(checkCodeView.mas_bottom).offset(0);
            make.width.offset(250*0.5);
            make.height.offset(50);
            make.right.equalTo(checkCodeView.mas_right).offset(0);
        }];
    }
    return self;
}
- (void)setPhone:(NSString *)phone codePic:(NSString *)codePic
{
    self.phoneLabel.text = phone;
    NSString *url = [codePic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    [self.codePic sd_setImageWithURL:[NSURL URLWithString:url]];
    self.codePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
}
- (void)clickCodePic
{
    WS(wSelf);
    [XBJinRRNetworkApiManager getCheckImgCodeWithBlock:^(id data) {
        XBJinRRCheckCodeModel *checkCodeModel = [XBJinRRCheckCodeModel mj_objectWithKeyValues:data[@"data"]];
        
        //        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        //        [[SDImageCache sharedImageCache] clearMemory];
        
        NSString *url = [checkCodeModel.imgPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        [wSelf.codePic sd_setImageWithURL:[NSURL URLWithString:url]];
        
        wSelf.codePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    } fail:^(NSError *errorString) {
        
    }];
}
- (void)clickOkBtn
{
    WS(wSelf);
    [XBJinRRNetworkApiManager getPhoneCodeWithMobile:self.phoneLabel.text type:self.messageType code:self.codeTextfield.text block:^(id data) {
        if ([data[@"result"] integerValue] == 1) {
            [Dialog toastCenter:@"恭喜您，获取验证码成功"];
            //            [SVProgressHUD showInfoWithStatus:@"恭喜您，获取验证码成功"];
            [wSelf hide];
            
            if (wSelf.picCodeSuccessBlock) {
                wSelf.picCodeSuccessBlock();
            }
        }
        
    } fail:^(NSError *errorString) {
        
    }];
}
- (void)show
{
    self.codeTextfield.text = @"";
    self.codeTextfield.placeholder = @"图形验证码";
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)hide
{
    self.codeTextfield.text = @"";
    self.codeTextfield.placeholder = @"图形验证码";
    [self removeFromSuperview];
}
@end
