//
//  XBJinRR_NormalHeaderView.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_NormalHeaderView.h"

@implementation XBJinRR_NormalHeaderView
{
    UILabel *titleLabel;
    UILabel *desLabel;
    UIView *lineView;
    //更多
    UIView *moreInfoView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        lineView = [[UIView alloc] initWithFrame:CGRectMake(SIZE(13), SIZE(13), SIZE(5), SIZE(24))];
        lineView.backgroundColor = MainColor;
        [self addSubview:lineView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE(28), SIZE(5), SIZE(150), SIZE(40))];
        titleLabel.font = FONT(17);
        titleLabel.textColor = RGB(66, 66, 66);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        
        desLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE(178), SIZE(5), SCREEN_WIDTH-SIZE(188), SIZE(40))];
        desLabel.font = FONT(15);
        desLabel.textColor = RGB(135, 135, 135);
        desLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:desLabel];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, SIZE(49.5), SCREEN_WIDTH, SIZE(0.5))];
        bottomLine.backgroundColor = RGB(241, 241, 241);
        [self addSubview:bottomLine];
        

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SIZE(5));
            make.left.mas_equalTo(self->lineView.mas_right).offset(SIZE(10));
            make.height.mas_equalTo(SIZE(40));
        }];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SIZE(5));
            make.height.mas_equalTo(SIZE(40));
            make.right.mas_equalTo(self.mas_right).offset(-SIZE(10));
            make.left.mas_equalTo(self->titleLabel.mas_right).offset(SIZE(5));
        }];
        
        
        
        moreInfoView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor];
        [self addSubview:moreInfoView];
        moreInfoView.hidden = YES;
        UILabel *moreInfoLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"更多" textColor:RGB(120, 120, 120) textAlignment:Right font:FONT(17)];
        [moreInfoView addSubview:moreInfoLabel];
        UIImageView *rightImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"moreInfo_icon"];
        [moreInfoView addSubview:rightImageView];
        
        
        [moreInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-SIZE(10));
            make.top.bottom.offset(0);
            make.width.mas_equalTo(SIZE(80));
        }];
        [moreInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.width.offset(SIZE(55));
        }];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.top.offset(10);
            make.bottom.offset(-10);
            make.left.mas_equalTo(moreInfoLabel.mas_right).offset(5);
        }];
    }
    return self;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    titleLabel.text = _titleStr;
}
-(void)setDesStr:(NSString *)desStr{
    _desStr = desStr;
    desLabel.text = _desStr;
}

-(void)setIsHiddenLine:(BOOL)isHiddenLine{
    _isHiddenLine = isHiddenLine;
    if (_isHiddenLine) {
        lineView.hidden = YES;
        [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SIZE(5));
            make.width.mas_equalTo(SIZE(100));
            make.left.mas_equalTo(SIZE(13));
            make.height.mas_equalTo(SIZE(40));
        }];
    }
}


-(void)setIsShowMoreBtn:(BOOL)isShowMoreBtn{
    _isShowMoreBtn = isShowMoreBtn;
    if (_isShowMoreBtn) {
        moreInfoView.hidden = NO;
        desLabel.hidden = YES;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreBtnClick)];
        [self addGestureRecognizer:tap];
    }
}
- (void )moreBtnClick{
    self.moreBtnClickBlock();
}

@end
