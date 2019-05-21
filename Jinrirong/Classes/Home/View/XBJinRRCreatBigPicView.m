//
//  XBJinRRCreatBigPicView.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/1.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCreatBigPicView.h"

@implementation XBJinRRCreatBigPicView
{
    UIImageView *myImageView;
    UILabel *badgelabel;
    UILabel *nameLabel;
    UILabel *desLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    CGFloat width = SCREEN_WIDTH/3.f;
    
    myImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"downFaile_icon"];
    myImageView.layer.masksToBounds = YES;
    myImageView.layer.cornerRadius = SIZE(30);
//    myImageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:myImageView];
    badgelabel = [ViewCreate createLabelFrame:CGRectMake((width-SIZE(60))/2.0+SIZE(60)-SIZE(25),SIZE(15), width-((width-SIZE(60))/2.0+SIZE(60))+SIZE(20), SIZE(15)) backgroundColor:RGB(246, 69, 63) text:@"" textColor:WhiteColor textAlignment:Center font:FONT(12)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:badgelabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(SIZE(7.5), SIZE(7.5))];;
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = badgelabel.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    badgelabel.layer.mask = maskLayer;
    [self addSubview:badgelabel];
    nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(66, 66, 66) textAlignment:Center font:FONT(16)];
    [self addSubview:nameLabel];
    desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(170, 170, 170) textAlignment:Center font:FONT(14)];
    [self addSubview:desLabel];
    
    
    [myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.offset(SIZE(10));
//        make.right.offset(SIZE(-10));
        make.centerX.offset(0);
        make.top.offset(SIZE(20));
        make.height.width.mas_equalTo(SIZE(60));
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(10));
        make.right.offset(SIZE(-10));
        make.top.mas_equalTo(self->myImageView.mas_bottom).offset(SIZE(5));
        make.height.mas_equalTo(SIZE(30));
    }];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->nameLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(SIZE(10));
        make.right.mas_equalTo(SIZE(-10));
        make.bottom.offset(SIZE(-10));
    }];
    
//    [badgelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->myImageView.mas_right).offset(SIZE(-5));
//        make.top.mas_equalTo(self->myImageView.mas_top).offset(SIZE(-5));
//        make.height.mas_equalTo(SIZE(10));
//    }];
    
    
    
    
}
-(void)setBankModel:(XBJinRRBankCardModel *)bankModel{
    _bankModel = bankModel;
    nameLabel.text = _bankModel.BankName;
    [myImageView sd_setImageWithURL:[NSURL URLWithString:_bankModel.Logurl]];
    desLabel.text = _bankModel.Intro;
    badgelabel.text = _bankModel.Desc;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
