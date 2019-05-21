//
//  XBJinRR_CustomerView.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/21.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_CustomerView.h"


@interface XBJinRR_CustomerView()

@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UIView *alterView;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *sureBtn;

//弹出框内容背景view
@property(nonatomic, strong)UIView *baseView;
//titleLabel
@property(nonatomic, strong)UILabel *titleLabel;
//contentlabel
@property(nonatomic, strong)UILabel *contentlabel;


@end


@implementation XBJinRR_CustomerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        self.baseView = [UIView new];
        self.baseView.backgroundColor = [UIColor whiteColor];
        self.baseView.layer.masksToBounds = YES;
        self.baseView.layer.cornerRadius = 10;
        [self addSubview:self.baseView];
        
        self.leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"per-contact-promptimg"]];
        [self addSubview:self.leftImageView];
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.baseView.mas_top).offset(SIZE(10));
            make.height.mas_equalTo(SIZE(35));
            make.left.mas_equalTo(self.baseView.mas_left).offset(-SIZE(5));
            make.width.mas_equalTo(SIZE(35/69.0*173));
        }];
        
        UILabel *adviseLabel = [[UILabel alloc] init];
        adviseLabel.text = @"提示";
        adviseLabel.textAlignment = NSTextAlignmentCenter;
        adviseLabel.backgroundColor = [UIColor clearColor];
        adviseLabel.textColor = [UIColor whiteColor];
        adviseLabel.font = [UIFont systemFontOfSize:17];
        [self.leftImageView addSubview:adviseLabel];
        [adviseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
        
        
        
        UIButton *rightImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightImageView addTarget:self action:@selector(removeBtClick) forControlEvents:UIControlEventTouchUpInside];
        [rightImageView setBackgroundImage:[UIImage imageNamed:@"per-contact-closure"] forState:UIControlStateNormal];
        [self.baseView addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.baseView.mas_top).offset(SIZE(10));
            make.width.height.mas_equalTo(SIZE(35));
            make.right.mas_equalTo(self.baseView.mas_right).offset(-SIZE(15));
        }];
        
        
        UIView *topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
        [self.baseView addSubview:topLineView];
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftImageView.mas_right).offset(0);
            make.centerY.mas_equalTo(self.leftImageView.mas_centerY).offset(0);
            make.height.mas_equalTo(SIZE(1));
            make.right.mas_equalTo(rightImageView.mas_left).offset(-SIZE(5));
        }];
        
        
//        CGFloat width = (SCREEN_WIDTH-SIZE(81))/2.0;
        
        
        UIView *CenterLineView = [[UIView alloc] init];
        CenterLineView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
        [self.baseView addSubview:CenterLineView];
        [CenterLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.baseView.mas_centerX).offset(0);
            make.height.mas_equalTo(SIZE(44));
           make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(0);
            make.width.mas_equalTo(SIZE(1));
        }];
        
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn addTarget:self action:@selector(cancelBtClick) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn.backgroundColor = [UIColor clearColor];
        [self.cancelBtn setTitleColor:[UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1] forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.baseView addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.baseView.mas_left).offset(0);
            make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(0);
            make.right.mas_equalTo(CenterLineView.mas_left).offset(0);
            make.height.mas_equalTo(SIZE(44));
        }];
        
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
        [self.baseView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.baseView).offset(0);
            make.bottom.mas_equalTo(self.cancelBtn.mas_top).offset(0);
            make.height.mas_equalTo(SIZE(1));
        }];
        
       
        
        
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.backgroundColor = [UIColor clearColor];
        [self.sureBtn setTitleColor:[UIColor colorWithRed:74/255.0 green:87/255.0 blue:232/255.0 alpha:1] forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.sureBtn addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
        [self.baseView addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.baseView.mas_right).offset(0);
            make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(0);
//            make.width.mas_equalTo(width);
            make.left.mas_equalTo(CenterLineView.mas_right).offset(0);
            make.height.mas_equalTo(SIZE(44));
        }];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self.baseView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.leftImageView.mas_bottom).offset(0);
            make.height.mas_equalTo(SIZE(25));
            make.left.right.offset(0);
        }];
        
        
        
        self.contentlabel = [[UILabel alloc] init];
        self.contentlabel.textAlignment = NSTextAlignmentCenter;
        self.contentlabel.numberOfLines = 0;
        self.contentlabel.backgroundColor = [UIColor clearColor];
        self.contentlabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        self.contentlabel.font = [UIFont systemFontOfSize:17];
        [self.baseView addSubview:self.contentlabel];
        [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
            make.bottom.mas_equalTo(bottomLineView.mas_top).offset(0);
            make.left.right.offset(0);
        }];
        

        WS(bself);
        [UIView animateWithDuration:0.5 animations:^{
            [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.offset(0);
                make.left.offset(SIZEFIT(50));
                make.right.offset(-SIZEFIT(50));
//                make.height.offset(SIZEFIT(180));
                make.height.mas_equalTo(bself.baseView.mas_width).multipliedBy(0.6);
            }];
            
        }];
        
    }
    return self;
}

/**
 *  @param title  标题
 *  @param content  提示内容
 *  @param yesBtnTitle  右边按钮标题
 *  @param cancelBtnTitle  左边按钮标题
 *  @param cancelBlock 取消按钮点击事件
 *  @param sureBlock   确定按钮点击事件
 *
 *  @return XBJinRR_CustomerView
 */
+(instancetype)alertViewWithTitle:(NSString *)title Content:(NSString *)content yesBtnTitle:(NSString *)yesBtnTitle cancelBtnTitle:(NSString *)cancelBtnTitle  CancelBtClcik:(CancelBlock)cancelBlock
                      sureBtClcik:(SureBlock)sureBlock{
    XBJinRR_CustomerView *alterView=[[XBJinRR_CustomerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    alterView.cancel_block = cancelBlock;
    alterView.sure_block   = sureBlock;
    
    alterView.titleLabel.text = title;
    alterView.contentlabel.text = content;
    [alterView.sureBtn setTitle:yesBtnTitle forState:UIControlStateNormal];
    [alterView.cancelBtn setTitle:cancelBtnTitle forState:UIControlStateNormal];
    
    
    if ([title isEqualToString:@""]) {
        [alterView.contentlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.mas_equalTo(alterView.leftImageView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(alterView.cancelBtn.mas_top).offset(-SIZE(1));
        }];
    }
    
    if ([content isEqualToString:@""]) {
        [alterView.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.mas_equalTo(alterView.leftImageView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(alterView.cancelBtn.mas_top).offset(-SIZE(1));
        }];
    }

    
    [[[UIApplication sharedApplication].delegate window] addSubview:alterView];
    return alterView;
}

#pragma mark----取消按钮点击事件
-(void)cancelBtClick
{
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    self.cancel_block();
}
#pragma mark----确定按钮点击事件
-(void)sureBtClick
{
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    self.sure_block();
}

#pragma mark -- 移除视图
-(void)removeBtClick
{
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
}



@end
