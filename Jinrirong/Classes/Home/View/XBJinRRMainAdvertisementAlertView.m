//
//  XBJinRRMainAdvertisementAlertView.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMainAdvertisementAlertView.h"


@interface XBJinRRMainAdvertisementAlertView()

@property(nonatomic,retain)UIView *alterView;
@property(nonatomic,retain)UIButton *cancelBtn;
//@property(nonatomic,retain)UIButton *checkAdvertiseBtn;
//弹出框内容背景view
@property(nonatomic, strong)UIView *baseView;
//图片
@property(nonatomic, strong)UIImageView *topImageView;
@property(nonatomic, strong)NSDictionary *advertiseDic;


@end



@implementation XBJinRRMainAdvertisementAlertView

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
        self.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.35];
        
        _baseView = [UIView new];
        [self addSubview:_baseView];
        _baseView.backgroundColor = ClearColor;
        
        
        _cancelBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) normalImage:@"per_contact_closure_icon" selectedImage:@"per_contact_closure" touchUpInsideEvent:nil];
        [self addSubview:_cancelBtn];
        [_cancelBtn addTarget:self action:@selector(cancelBtClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_baseView.mas_top).offset(0);
            make.width.height.offset(SIZE(40));
            make.right.equalTo(self->_baseView.mas_right).offset(SIZE(20));
        }];
        
//        _checkAdvertiseBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"点击查看" titleColor:WhiteColor font:FONT(16) backgroundColor:MainColor touchUpInsideEvent:nil];
//        [_baseView addSubview:_checkAdvertiseBtn];
//        [_checkAdvertiseBtn addTarget:self action:@selector(checkAdvertiseBtClick) forControlEvents:UIControlEventTouchUpInside];
//        [_checkAdvertiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.left.right.offset(0);
//            make.height.offset(SIZE(40));
//        }];
//        _checkAdvertiseBtn.layer.masksToBounds = YES;
//        _checkAdvertiseBtn.layer.cornerRadius = SIZE(20);
        
        
        
        _topImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
        [_baseView addSubview:_topImageView];
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
        _topImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkAdvertiseBtClick)];
        [_topImageView addGestureRecognizer:tap];
        
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.offset(0);
            make.top.offset(SIZE(40));
//            make.bottom.mas_equalTo(bself.checkAdvertiseBtn.mas_top).offset(SIZE(-5));
        }];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self->_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.offset(0);
                make.left.offset(SIZEFIT(50));
                make.right.offset(-SIZEFIT(50));
                make.height.mas_equalTo(self.baseView.mas_width).offset(0);
//                make.height.mas_equalTo(self.baseView.mas_width).multipliedBy(1.6);
            }];
            
        }];
        
        
    }
    return self;
}

+(instancetype)alterViewWithSourceInfoDic:(NSDictionary *)sourceInfoDic cancelBtClcik:(CancelBlock)cancelBlock
                      checkAdvertiseBlock:(CheckAdvertiseBlock )CheckAdvertiseBlock{
    XBJinRRMainAdvertisementAlertView *alterView=[[XBJinRRMainAdvertisementAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    alterView.advertiseDic   = sourceInfoDic;
    alterView.cancel_block   = cancelBlock;
    alterView.checkAdvertise_block  = CheckAdvertiseBlock;
    [alterView.topImageView sd_setImageWithURL:[NSURL URLWithString:sourceInfoDic[@"TanImg"]]];

    [[[UIApplication sharedApplication].delegate window] addSubview:alterView];
    return alterView;
}






#pragma mark----取消按钮点击事件
-(void)cancelBtClick
{
    self.cancel_block();
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    
}
#pragma mark----确定按钮点击事件
-(void)checkAdvertiseBtClick
{
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    self.checkAdvertise_block(self.advertiseDic);
}



@end
