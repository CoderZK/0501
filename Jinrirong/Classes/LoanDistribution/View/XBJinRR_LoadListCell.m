//
//  XBJinRR_LoadListCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/28.
//  Copyright © 2018年 ahxb. All rights reserved.
// 产品列表

#import "XBJinRR_LoadListCell.h"

@interface XBJinRR_LoadListCell()
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
/**
 *  多少人已申请
 */
@property(nonatomic, strong)UILabel *advisePeopleLabel;

@end

@implementation XBJinRR_LoadListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}


- (void )creatUI{
    self.iconImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"logo_icon"];
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5.f;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"人人贷" textColor:BlackColor textAlignment:Left font:FONT(15)];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.advisePeopleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"253人已申请" textColor:BlackColor textAlignment:Right font:FONT(13)];
    [self.contentView addSubview:self.advisePeopleLabel];
    
    
    self.bonusLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"奖金100元" textColor:RGB(80, 80, 80) textAlignment:Left font:FONT(15)];
    [self.contentView addSubview:self.bonusLabel];
    self.desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"现金在线，2分钟下款" textColor:RGB(130, 130, 130) textAlignment:Left font:FONT(13)];
    [self.contentView addSubview:self.desLabel];
    
    //UIImageView *bonusImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"distribution-coin"];
    //[self addSubview:bonusImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE(5));
        make.top.mas_equalTo(SIZE(15));
        make.bottom.mas_equalTo(SIZE(-15));
        make.width.height.mas_equalTo(SIZE(70));
    }];
    
    [self.advisePeopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(SIZE(-5));
        make.top.mas_equalTo(SIZE(10));
        make.width.mas_equalTo(SIZE(120));
        make.height.mas_equalTo(SIZE(30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.top.mas_equalTo(SIZE(10));
        make.height.mas_equalTo(SIZE(30));
        make.right.mas_equalTo(self.advisePeopleLabel.mas_left).offset(0);
    }];

    /*[bonusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SIZE(20));
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        
    }];*/
    
    [self.bonusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(SIZE(25));
        make.right.mas_equalTo(self.mas_right).offset(SIZE(-5));
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(SIZE(-10));
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(SIZE(-5));
    }];
}

-(void)setRecommendModel:(XBJinRR_RecommendsLoadModel *)recommendModel{
    _recommendModel = recommendModel;
    
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_recommendModel.Logurl]];
    self.titleLabel.text = _recommendModel.Name;
    
    
    //NSMutableAttributedString *mAttri0 = [[NSMutableAttributedString alloc] initWithString:@"奖金" attributes:@{NSForegroundColorAttributeName:RGB(80, 80, 80)}];
    
    if(_recommendModel.Smoney==nil){
        NSMutableAttributedString *mAttri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"放款%@%@",[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?_recommendModel.BonusRate:_recommendModel.Ymoney,[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?@"%":@"元"] attributes:@{NSForegroundColorAttributeName:RGB(255, 132, 132)}];
        self.bonusLabel.attributedText = mAttri1;
    }else{
        NSMutableAttributedString *mAttri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"申请%@元+放款%@%@",[NSString stringWithFormat:@"%@",_recommendModel.Smoney],[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?_recommendModel.BonusRate:_recommendModel.Ymoney,[[NSString stringWithFormat:@"%@",_recommendModel.Yjtype] isEqualToString:@"1"]?@"%":@"元"] attributes:@{NSForegroundColorAttributeName:RGB(255, 132, 132)}];
        self.bonusLabel.attributedText = mAttri1;
    }
    //[mAttri0 appendAttributedString:mAttri1];
    
    self.desLabel.text = [NSString stringWithFormat:@"%@",_recommendModel.Intro];
    
    
    
    NSMutableAttributedString *mAttri2 = [[NSMutableAttributedString alloc] initWithString:@"已申请" attributes:@{NSForegroundColorAttributeName:RGB(80, 80, 80)}];
    NSMutableAttributedString *mAttri3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人",_recommendModel.AppNumbs] attributes:@{NSForegroundColorAttributeName:MainColor}];
    [mAttri3 appendAttributedString:mAttri2];
    self.advisePeopleLabel.attributedText = mAttri3;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
