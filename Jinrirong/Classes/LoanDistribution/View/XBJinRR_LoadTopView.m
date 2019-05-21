
//
//  XBJinRR_LoadTopView.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/28.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_LoadTopView.h"

@interface XBJinRR_LoadTopView()
/**
 *  icon
 */
@property(nonatomic, strong)UIImageView *iconImageView;
/**
 *  title
 */
@property(nonatomic, strong)UILabel *titleLabel;
/**
 *  奖金
 */
@property(nonatomic, strong)UILabel *bonusLabel;
/**
 *  描述
 */
@property(nonatomic, strong)UILabel *desLabel;


@end

@implementation XBJinRR_LoadTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor  = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    self.iconImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"logo_icon"];
    [self addSubview:self.iconImageView];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5.f;
    
    self.titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:BlackColor textAlignment:Left font:FONT(15)];
    [self addSubview:self.titleLabel];
    self.bonusLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(80, 80, 80) textAlignment:Left font:FONT(13)];
    [self addSubview:self.bonusLabel];
    self.desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(130, 130, 130) textAlignment:Left font:FONT(11)];
    self.desLabel.numberOfLines = 0;
    [self addSubview:self.desLabel];
    
    //UIImageView *bonusImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"distribution-coin"];
    //[self addSubview:bonusImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE(5));
        make.top.mas_equalTo(SIZE(10));
        make.bottom.mas_equalTo(SIZE(-10));
        make.width.height.mas_equalTo(SIZE(60));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.top.mas_equalTo(SIZE(10));
        make.height.mas_equalTo(SIZE(20));
        make.right.mas_equalTo(self.mas_right).offset(SIZE(-5));
    }];
    
    /*[bonusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SIZE(18));
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(SIZE(2));
        
    }];*/
    
    [self.bonusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(SIZE(2));
        make.height.mas_equalTo(SIZE(18));
        make.right.mas_equalTo(self.mas_right).offset(SIZE(-5));
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bonusLabel.mas_bottom).offset(SIZE(2));
        make.bottom.mas_equalTo(SIZE(-10));
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(SIZE(-5));
    }];
}


-(void)setRecommendModel:(XBJinRR_RecommendsLoadModel *)recommendModel{
    _recommendModel = recommendModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_recommendModel.Logurl]];
    self.titleLabel.text = _recommendModel.Name;
    
    
    /*NSMutableAttributedString *mAttri0 = [[NSMutableAttributedString alloc] initWithString:@"奖金" attributes:@{NSForegroundColorAttributeName:RGB(80, 80, 80)}];
    NSMutableAttributedString *mAttri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?_recommendModel.BonusRate:_recommendModel.Ymoney,[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?@"%":@"元"] attributes:@{NSForegroundColorAttributeName:RGB(255, 132, 132)}];
    [mAttri0 appendAttributedString:mAttri1];
    self.bonusLabel.attributedText = mAttri0;*/
    if(_recommendModel.Smoney==nil){
        NSMutableAttributedString *mAttri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"放款%@%@",[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?_recommendModel.BonusRate:_recommendModel.Ymoney,[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?@"%":@"元"] attributes:@{NSForegroundColorAttributeName:RGB(255, 132, 132)}];
        self.bonusLabel.attributedText = mAttri1;
    }else{
        NSMutableAttributedString *mAttri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"申请%@元+放款%@%@",[NSString stringWithFormat:@"%@",_recommendModel.Smoney],[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?_recommendModel.BonusRate:_recommendModel.Ymoney,[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?@"%":@"元"] attributes:@{NSForegroundColorAttributeName:RGB(255, 132, 132)}];
        self.bonusLabel.attributedText = mAttri1;
    }
    
    self.desLabel.text = [NSString stringWithFormat:@"%@",_recommendModel.Intro];
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
