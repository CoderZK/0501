//
//  XBJinRRProductCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBEDAILoanTopCell.h"

@interface XBEDAILoanTopCell()
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *edValueLabel;
@property (nonatomic,strong) UILabel *jkqxValueLabel;
@property (nonatomic,strong) UILabel *dayfeeRateValueLabel;
@end

@implementation XBEDAILoanTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *icon = [[UIImageView alloc] init];
        //        icon.contentMode = UIViewContentModeScaleAspectFit;
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 5.f;
        [self.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(10);
            make.width.height.offset(60);
        }];
        self.icon = icon;
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = [UIFont systemFontOfSize:13];
        descLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.centerY.equalTo(icon.mas_centerY).offset(0);
            make.right.offset(-10);
        }];
        self.descLabel = descLabel;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(descLabel.mas_top).offset(-5);
            make.left.equalTo(icon.mas_right).offset(10);
        }];
        self.nameLabel = nameLabel;
        
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.font = [UIFont systemFontOfSize:12];
        numLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:numLabel];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.top.equalTo(descLabel.mas_bottom).offset(5);
        }];
        self.numLabel = numLabel;
        
        UILabel *hotLabel = [[UILabel alloc] init];
        hotLabel.font = [UIFont systemFontOfSize:12];
        hotLabel.textColor = [UIColor whiteColor];
        hotLabel.backgroundColor = RGB(255, 190, 2);
        hotLabel.layer.cornerRadius = 2;
        hotLabel.layer.masksToBounds = YES;
        hotLabel.text = @"HOT";
        hotLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:hotLabel];
        [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(3);
            make.centerY.equalTo(nameLabel.mas_centerY).offset(0);
            make.width.offset(30);
            make.height.offset(15);
        }];
        
        CGFloat w = (SCREEN_WIDTH-30)/3;
        UILabel *edNameLabel = [[UILabel alloc] init];
        edNameLabel.font = [UIFont systemFontOfSize:11];
        edNameLabel.textColor = [UIColor grayColor];
        edNameLabel.textAlignment = NSTextAlignmentLeft;
        edNameLabel.text = @"额度(元)";
        [self.contentView addSubview:edNameLabel];
        [edNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_left).offset(0);
            make.top.equalTo(icon.mas_bottom).offset(20);
            make.width.offset(w+20);
        }];
        
        UILabel *edValueLabel = [[UILabel alloc] init];
        edValueLabel.font = [UIFont systemFontOfSize:15];
        edValueLabel.textColor = [UIColor blackColor];
        edValueLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:edValueLabel];
        [edValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_left).offset(0);
            make.top.equalTo(edNameLabel.mas_bottom).offset(10);
            make.width.offset(w+20);
        }];
        self.edValueLabel = edValueLabel;
        
        UILabel *jkqxLabel = [[UILabel alloc] init];
        jkqxLabel.font = [UIFont systemFontOfSize:11];
        jkqxLabel.textColor = [UIColor grayColor];
        jkqxLabel.text = @"借款期限";
        jkqxLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:jkqxLabel];
        [jkqxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(w+20);
            make.top.equalTo(icon.mas_bottom).offset(20);
            make.width.offset(w+10);
        }];
        
        UILabel *jkqxValueLabel = [[UILabel alloc] init];
        jkqxValueLabel.font = [UIFont systemFontOfSize:15];
        jkqxValueLabel.textColor = [UIColor blackColor];
        jkqxValueLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:jkqxValueLabel];
        [jkqxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(jkqxLabel.mas_left).offset(0);
            make.top.equalTo(jkqxLabel.mas_bottom).offset(10);
            make.width.offset(w+10);
        }];
        self.jkqxValueLabel = jkqxValueLabel;
        
        UILabel *dayfeeRateLabel = [[UILabel alloc] init];
        dayfeeRateLabel.font = [UIFont systemFontOfSize:11];
        dayfeeRateLabel.textColor = [UIColor grayColor];
        dayfeeRateLabel.text = @"日费率";
        dayfeeRateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:dayfeeRateLabel];
        [dayfeeRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(w+20+w+10);
            make.top.equalTo(icon.mas_bottom).offset(20);
            make.width.offset(w);
        }];
        
        UILabel *dayfeeRateValueLabel = [[UILabel alloc] init];
        dayfeeRateValueLabel.font = [UIFont systemFontOfSize:15];
        dayfeeRateValueLabel.textColor = RGB(251, 135, 56);
        dayfeeRateValueLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:dayfeeRateValueLabel];
        [dayfeeRateValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(dayfeeRateLabel.mas_left).offset(0);
            make.top.equalTo(dayfeeRateLabel.mas_bottom).offset(10);
            make.width.offset(w);
        }];
        self.dayfeeRateValueLabel = dayfeeRateValueLabel;
        
        self.applyBtn = [[UIButton alloc] init];
        [self.applyBtn setTitle:@"申请" forState:UIControlStateNormal];
        [self.applyBtn setTitleColor:MainColor forState:UIControlStateNormal];
        self.applyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.applyBtn.layer.borderColor = MainColor.CGColor;
        self.applyBtn.layer.borderWidth = 1.0;
        self.applyBtn.layer.cornerRadius = 10;
        self.applyBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:self.applyBtn];
        [self.applyBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameLabel.mas_centerY).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.width.offset(50);
            make.height.offset(20);
        }];
    };
    return self;
}

- (void )clickBtn{
    if (self.clickApplyBtnBlock) {
        self.clickApplyBtnBlock();
    }
}




- (void)setHotModel:(XBJinRRHomeHotModel *)hotModel
{
    _hotModel = hotModel;
    NSString *url = [hotModel.Logurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = hotModel.Name;
    self.descLabel.text = hotModel.Intro;
    
    
   
    self.edValueLabel.text = hotModel.TypeName;
    self.jkqxValueLabel.text = hotModel.Jkdays;
    self.dayfeeRateValueLabel.text = hotModel.DayfeeRate;
}

-(void)setPassRate:(NSString *)PassRate{
    _PassRate = PassRate;
    
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:@"通过率:" attributes:@{NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_PassRate] attributes:@{NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:RGB(251, 135, 56)}];
    
    [attri1 appendAttributedString:attri0];
    self.numLabel.attributedText = attri1;
}


@end
