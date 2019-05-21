//
//  HMPopMenu.m
//  黑马微博
//
//  Created by apple on 14-7-4.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMPopMenu.h"

@interface HMPopMenu()
@property (nonatomic, strong) UIView *contentView;
/**
 *  最底部的遮盖 ：屏蔽除菜单以外控件的事件
 */
@property (nonatomic, weak) UIButton *cover;
/**
 *  容器 ：容纳具体要显示的内容contentView
 */
@property (nonatomic, weak) UIImageView *container;
@end

@implementation HMPopMenu

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 添加菜单内部的2个子控件 **/
        // 添加一个遮盖按钮
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow ;
        self.frame = window.bounds;
        [window addSubview:self];
        
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor blackColor];
        cover.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        cover.alpha = 0.5;
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        

        UIView *whiteView = [[UIView alloc] init];
        whiteView.layer.cornerRadius = 10;
        whiteView.clipsToBounds = YES;
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.frame = CGRectMake(80, (SCREEN_HEIGHT - 200) / 2, SCREEN_WIDTH - 160, 160);
        [self addSubview:whiteView];
        
        UILabel *moneyLab = [[UILabel alloc] init];
        moneyLab.text = @"75天后未匹配出达标数据订单自动作废";
        moneyLab.textAlignment = NSTextAlignmentCenter;
        moneyLab.textColor = [UIColor grayColor];
        moneyLab.numberOfLines = 0;
        moneyLab.frame = CGRectMake(20, 20, SCREEN_WIDTH - 160 - 40, 60);
        [whiteView addSubview:moneyLab];
//        91 80
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:@"nullimage"];
        imageV.frame = CGRectMake((SCREEN_WIDTH - 160 - 45) / 2, 100, 45, 40);
        [whiteView addSubview:imageV];
        
        UIButton *missBtn = [[UIButton alloc] init];
        missBtn.frame = CGRectMake(SCREEN_WIDTH - 90 , ((SCREEN_HEIGHT - 200) / 2) - 10, 20, 20);
        [missBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [missBtn setBackgroundImage:[UIImage imageNamed:@"missBtImage"] forState:UIControlStateNormal];
        [self addSubview:missBtn];
       
    }
    return self;
}


- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        self.contentView = contentView;
    }
    return self;
}

+ (instancetype)popMenuWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cover.frame = self.bounds;
}

#pragma mark - 内部方法
- (void)coverClick
{
    [self dismiss];
}

//#pragma mark - 公共方法
//- (void)setDimBackground:(BOOL)dimBackground
//{
//    _dimBackground = dimBackground;
//
//    if (dimBackground) {
//        self.cover.backgroundColor = [UIColor blackColor];
//        self.cover.alpha = 0.3;
//    } else {
//        self.cover.backgroundColor = [UIColor clearColor];
//        self.cover.alpha = 1.0;
//    }
//}

//- (void)setArrowPosition:(HMPopMenuArrowPosition)arrowPosition
//{
//    _arrowPosition = arrowPosition;
//
//    switch (arrowPosition) {
//        case HMPopMenuArrowPositionCenter:
//            self.container.image = [UIImage imageNamed:@"popover_background"];
//            break;
//
//        case HMPopMenuArrowPositionLeft:
//            self.container.image = [UIImage imageNamed:@"popover_background_left"];
//            break;
//
//        case HMPopMenuArrowPositionRight:
//            self.container.image = [UIImage imageNamed:@"popover_background_right"];
//            break;
//    }
//}

//- (void)setBackground:(UIImage *)background
//{ 
//    self.container.image = background;
//}

- (void)showInRect:(CGRect)rect
{
    // 添加菜单整体到窗口身上
   
 
 
}

- (void)dismiss{
    
//    if ([self.delegate respondsToSelector:@selector(popMenuDidDismissed:)]) {
//        [self.delegate popMenuDidDismissed:self];
//    }
    
    [self removeFromSuperview];
}
@end
