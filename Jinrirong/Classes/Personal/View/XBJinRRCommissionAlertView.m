//
//  XBJinRRCommissionAlertView.m
//  Jinrirong
//
//  Created by ahxb on 2018/10/10.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCommissionAlertView.h"
@interface XBJinRRCommissionAlertView()

@property(nonatomic,retain)UIView *alterView;
@property(nonatomic,retain)UIButton *cancelBtn;
@property(nonatomic,retain)UIButton *checkAdvertiseBtn;
//弹出框内容背景view
@property(nonatomic, strong)UIView *baseView;
//图片
@property(nonatomic, strong)UIImageView *topImageView;
@property(nonatomic, strong)NSDictionary *advertiseDic;


@property(nonatomic,retain)UILabel * MaxCommission,*Commission1,*Commission2,*Commission3,*Commission4;


@end


@implementation XBJinRRCommissionAlertView
- (NSDictionary *)advertiseDic{
    if (!_advertiseDic) {
        _advertiseDic = [NSDictionary new];
    }
    return _advertiseDic;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        WS(bself);
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _baseView = [UIView new];
        [self addSubview:_baseView];
        [_baseView doBorderCornerRadius:NewSIZE(12)];
        _baseView.backgroundColor = ClearColor;
        [self->_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.centerX.offset(0);
            make.width.offset(SCREEN_WIDTH-NEWSIZE(80));
            make.height.offset((SCREEN_WIDTH-NewSIZE(80))*538/415);
        }];
        _cancelBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) normalImage:@"per_contact_closure_icon" selectedImage:@"per_contact_closure_icon" touchUpInsideEvent:nil];
        [self addSubview:_cancelBtn];
        [_cancelBtn addTarget:self action:@selector(cancelBtClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_baseView.mas_top).offset(-SIZE(45));
            make.right.equalTo(self->_baseView.mas_right).offset(0);
            make.width.height.offset(SIZE(40));
        }];
        
        _topImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
        [_topImageView doBorderCornerRadius:NewSIZE(12)];
        _topImageView.backgroundColor = ClearColor;
        [_baseView addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.centerX.offset(0);
            make.width.offset(SCREEN_WIDTH-NEWSIZE(80));
            
            make.height.offset((SCREEN_WIDTH-NewSIZE(80))*538/415);
        }];
        
        _MaxCommission = [UILabel new];
        _MaxCommission.text = @"关注融e代微信公众号";
        _MaxCommission.textAlignment = Center;
        _MaxCommission.textColor = RGB(217,28,41);
        _MaxCommission.font = NewFONT(24);
        [_baseView addSubview:_MaxCommission];
        [_MaxCommission mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_topImageView.mas_top).offset(((SCREEN_WIDTH-NewSIZE(80))*538/415)*273/538);
            make.centerX.equalTo(self->_topImageView.mas_centerX).offset(0);
            make.height.offset(NewSIZE(24));
            
        }];
        
        _Commission1 = [UILabel new];
        _Commission1.text = @"第一时间解锁新口子";
        _Commission1.textAlignment = Center;
        _Commission1.textColor = RGB(51,51,51);
        _Commission1.font = NewFONT(24);
        [_baseView addSubview:_Commission1];
        [_Commission1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_MaxCommission.mas_bottom).offset(NEWSIZE(14));
            make.centerX.equalTo(self->_topImageView.mas_centerX).offset(0);
            make.height.offset(NewSIZE(24));
            
        }];
        
        UIButton * upGraded = [UIButton new];
        [upGraded setTitle:@"复制公众号并关注" forState:UIControlStateNormal];
        [upGraded setTitleColor:MainColor forState:UIControlStateNormal];
        upGraded.backgroundColor = RGB(255, 202, 2);
        [upGraded doBorderCornerRadius:NewSIZE(65/2)];
        upGraded.titleLabel.font = NewFONT(28);
        [upGraded addTarget:self action:@selector(upGradedClick) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:upGraded];
        [upGraded mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_baseView.mas_centerX).offset(0);
            make.bottom.offset(-NewSIZE(22));
            make.width.offset(SCREEN_WIDTH-NewSIZE(144));
            make.height.offset(NewSIZE(65));
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self->_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.offset(0);
                make.centerX.offset(0);
                make.width.offset(SCREEN_WIDTH-NEWSIZE(80));
                make.height.offset((SCREEN_WIDTH-NewSIZE(80))*538/415);
            }];
            
        }];
        
    }
    return self;
}





+(instancetype)CommissionAlterViewWithSourceInfoDic:(NSDictionary *)sourceInfoDic cancelBtClcik:(CancelBlock)cancelBlock
                                checkAdvertiseBlock:(CheckAdvertiseBlock )CheckAdvertiseBlock{
    
    
    XBJinRRCommissionAlertView *alterView=[[XBJinRRCommissionAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    alterView.advertiseDic   = sourceInfoDic;
    alterView.cancel_block   = cancelBlock;
    alterView.checkAdvertise_block  = CheckAdvertiseBlock;
//    NSDictionary * dic = sourceInfoDic[@"Brokerage"];
//    alterView.MaxCommission.text = [NSString stringWithFormat:@"最高首借返佣%@",dic[@"Broker4"]];
//    alterView.Commission1.text = [NSString stringWithFormat:@"%@",dic[@"Broker1"]];
//    alterView.Commission2.text = [NSString stringWithFormat:@"%@",dic[@"Broker2"]];
//    alterView.Commission3.text = [NSString stringWithFormat:@"%@",dic[@"Broker3"]];
//    alterView.Commission4.text = [NSString stringWithFormat:@"%@",dic[@"Broker4"]];
    
    
    [alterView.topImageView sd_setImageWithURL:[NSURL URLWithString:sourceInfoDic[@"OfficialQR"]]];
    
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
-(void)upGradedClick
{
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    self.checkAdvertise_block(self.advertiseDic);
}
@end
