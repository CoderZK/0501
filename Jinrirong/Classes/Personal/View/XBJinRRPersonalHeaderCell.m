//
//  XBJinRRPersonalHeaderCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPersonalHeaderCell.h"

@interface XBJinRRPersonalHeaderCell()
{
    UIButton *msgBtn;
}
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *userAccountLabel;
@property (nonatomic,strong) UIImageView *personIcon;
@end

@implementation XBJinRRPersonalHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *headerBgImg = [[UIImageView alloc] init];
        [headerBgImg setUserInteractionEnabled:YES];
        headerBgImg.backgroundColor = MainColor;
        [self.contentView addSubview:headerBgImg];
        [headerBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.offset(0);
        }];
        
        msgBtn = [[UIButton alloc] init];

        [msgBtn setImage:[UIImage imageNamed:@"home-news"] forState:UIControlStateNormal];
        [msgBtn addTarget:self action:@selector(clickMsgBtn) forControlEvents:UIControlEventTouchUpInside];
        [headerBgImg addSubview:msgBtn];
        [msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerBgImg.mas_top).offset(40);
            make.right.equalTo(headerBgImg.mas_right).offset(-20);
        }];
        
        UIImageView *personIcon = [[UIImageView alloc] init];
        personIcon.layer.cornerRadius = 33;
        personIcon.layer.masksToBounds = YES;
        personIcon.layer.borderWidth = 4;
        personIcon.layer.borderColor = RGB(110, 128, 239).CGColor;
        personIcon.image = [UIImage imageNamed:@"login-pho"];
        [headerBgImg addSubview:personIcon];
        [personIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerBgImg.mas_left).offset(20);
            make.bottom.equalTo(headerBgImg.mas_bottom).offset(-25);
            make.width.height.offset(66);
        }];
        self.personIcon = personIcon;
        
        UILabel *userNameLabel = [[UILabel alloc] init];
        userNameLabel.font = [UIFont systemFontOfSize:16];
        userNameLabel.textColor = [UIColor whiteColor];
        userNameLabel.text = @"点击登录";
        [headerBgImg addSubview:userNameLabel];
        [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(personIcon.mas_right).offset(20);
            make.top.equalTo(personIcon.mas_top).offset(10);
        }];
        self.userNameLabel = userNameLabel;
        
        UILabel *userAccountLabel = [[UILabel alloc] init];
        userAccountLabel.font = [UIFont systemFontOfSize:16];
        userAccountLabel.textColor = [UIColor whiteColor];
        userAccountLabel.text = @"您好，欢迎使用";
        [headerBgImg addSubview:userAccountLabel];
        [userAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(personIcon.mas_right).offset(20);
            make.bottom.equalTo(personIcon.mas_bottom).offset(-10);
        }];
        self.userAccountLabel = userAccountLabel;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLogin)];
        [headerBgImg addGestureRecognizer:tap];
    }
    return self;
}
- (void)setPersonInfoModel:(XBJinRRPersonInfoModel *)personInfoModel
{
    _personInfoModel = personInfoModel;
    if (personInfoModel == nil) {
        self.userNameLabel.text = @"点击登录";
        self.userAccountLabel.text = @"您好，欢迎使用";
        self.personIcon.image = [UIImage imageNamed:@"login-pho"];
        return;
    }
    // * 会员代理级别  1普通会员  2渠道代理  3团队经理  4城市经理
//    NSString *Mtype = @"";
//    if ([_personInfoModel.Mtype isEqualToString:@"1"]) {
//        Mtype = @"普通会员";
//    }else if([_personInfoModel.Mtype isEqualToString:@"1"]){
//        Mtype = @"渠道代理";
//    }else if([_personInfoModel.Mtype isEqualToString:@"1"]){
//        Mtype = @"团队经理";
//    }else{
//        Mtype = @"城市经理";
//    }
    
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@(%@)",isEmptyStr(_personInfoModel.TrueName)?@"点击登录":personInfoModel.TrueName,_personInfoModel.Rule];
//    self.userNameLabel.text = isEmptyStr(personInfoModel.TrueName)?@"点击登录":personInfoModel.TrueName;
    self.userAccountLabel.text = isEmptyStr(personInfoModel.Mobile)?@"您好，欢迎使用":[NSString stringWithFormat:@"%@",personInfoModel.Mobile];//[NSString stringWithFormat:@"%@(工号:%@)",personInfoModel.Mobile,personInfoModel.ID];
    NSString *url = [personInfoModel.HeadImgVal stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.personIcon sd_setImageWithURL:[NSURL URLWithString:url]];
}
- (void)clickLogin
{
    if ([self.myDelegate respondsToSelector:@selector(XBJinRRPersonalHeaderCellClickLogin)]) {
        [self.myDelegate XBJinRRPersonalHeaderCellClickLogin];
    }
        
}
- (void)clickMsgBtn
{
    if ([self.myDelegate respondsToSelector:@selector(XBJinRRPersonalHeaderCellClickMsg)]) {
        [self.myDelegate XBJinRRPersonalHeaderCellClickMsg];
    }
}


-(void)setIsNoReadMsg:(NSString *)isNoReadMsg{
    _isNoReadMsg = isNoReadMsg;
    if([_isNoReadMsg isEqualToString:@"0"]){
        [msgBtn setImage:[UIImage imageNamed:@"personal_news"] forState:UIControlStateNormal];
        
    }else
    {
        [msgBtn setImage:[UIImage imageNamed:@"personal_newsclick"] forState:UIControlStateNormal];
    }
}

@end
