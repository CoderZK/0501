//
//  LDImageAndTitleView.m
//  BaseFrame
//
//  Created by Miles on 2017/9/20.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDImageAndTitleView.h"

@implementation LDImageAndTitleView

-(instancetype)init
{
    
    if (self = [super init]) {
        
        [self initUI];
    }
    
    return  self;
}

-(void)initUI{
    WS(bself);
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset([MyAdapter laDapter:8]);
//        make.centerX.offset(0);
//        make.left.offset(0);
//        make.right.offset(0);
//        make.width.offset(_imageView.frame.size.width);
//        make.height.offset(_imageView.frame.size.width);
//    }];
    
    _titleLB = [UILabel new];
    _titleLB.font = [UIFont systemFontOfSize:13];
    _titleLB.textColor = [UIColor whiteColor];
    [self addSubview:_titleLB];
//    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.offset(0);
//        make.bottom.equalTo(bself.mas_bottom);
//    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappp)];
    [self addGestureRecognizer:tap];
}
- (void)layoutSubviews
{
    WS(bself);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.centerX.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(-20);
//        make.width.offset(_imageView.frame.size.width);
//        make.height.offset(_imageView.frame.size.width);
    }];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(bself.mas_bottom);
    }];
}
-(void)tappp
{
    if (_viewClickCallBack) {
        _viewClickCallBack(_imageView,_titleLB,self);
    }
}

@end
