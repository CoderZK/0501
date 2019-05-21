//
//  XBJinRRNewUserHelpSectionHeaderView.m
//  Jinrirong
//
//  Created by 刘布斯 on 2018/6/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//  新手帮助头部视图

#import "XBJinRRNewUserHelpSectionHeaderView.h"

@implementation XBJinRRNewUserHelpSectionHeaderView
{
    UIImageView *leftIconImageView;
    UILabel *titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}


- (void )creatUI{
    leftIconImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    [self addSubview:leftIconImageView];
    
    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"tap_down_icon" textColor:RGB(66, 66, 66) textAlignment:Left font:FONT(15)];
    [self addSubview:titleLabel];
    
    
    [leftIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(10));
        make.top.offset(SIZE(10));
        make.width.height.mas_equalTo(SIZE(20));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->leftIconImageView.mas_right).offset(5);
        make.top.mas_equalTo(SIZE(10));
        make.bottom.mas_equalTo(SIZE(-10));
        make.right.mas_equalTo(-SIZE(10));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
}


- (void)setTempModel:(XBJinRRNewUserHelpModel *)tempModel{
    _tempModel = tempModel;
    leftIconImageView.image = [UIImage imageNamed:_tempModel.isSelected?@"tap_down_icon":@"tap_right_icon"];
    titleLabel.text = _tempModel.Title;
}


- (void) tapClick{
    self.tempModel.isSelected = !self.tempModel.isSelected;
    if (self.clickTapBlock) {
        self.clickTapBlock(self.tempModel);
    }
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
