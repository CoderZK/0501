//
//  XBJinRR_LoadShareChartsCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//  排行榜表格

#import "XBJinRR_LoadShareChartsCell.h"

@implementation XBJinRR_LoadShareChartsCell
{
    UILabel *chartslabel;//排名
    UILabel *phoneNumberLabel;//手机号
    UILabel *totalMoney;//放款金额
    UIView *line0;
    UIView *line1;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    //高度SIZE（50）
    
    chartslabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(135, 135, 135) textAlignment:Center font:FONT(15)];
    [self.contentView addSubview:chartslabel];
    phoneNumberLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(135, 135, 135) textAlignment:Center font:FONT(15)];
    [self.contentView addSubview:phoneNumberLabel];
    totalMoney = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(135, 135, 135) textAlignment:Center font:FONT(15)];
    [self.contentView addSubview:totalMoney];
    
    
    line0 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(241, 241, 241)];
    [self.contentView addSubview:line0];
    line1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(241, 241, 241)];
    [self.contentView addSubview:line1];
    
    CGFloat width = (SCREEN_WIDTH-SIZE(1))/3.f;
    [totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
       make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.bottom.offset(-5);
        make.width.mas_equalTo(SIZE(0.5));
        make.right.mas_equalTo(self->totalMoney.mas_left).offset(0);
    }];
    [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.top.bottom.offset(0);
        make.right.mas_equalTo(self->line1.mas_left).offset(0);
    }];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SIZE(0.5));
        make.top.offset(5);
        make.bottom.offset(-5);
        make.right.mas_equalTo(self->phoneNumberLabel.mas_left).offset(0);
    }];
    
    [chartslabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.height.mas_equalTo(SIZE(36));
        make.left.mas_equalTo((width-SIZE(36))*0.5);
        make.top.mas_equalTo(SIZE(7));
        
//        make.top.bottom.offset(0);
        make.width.mas_equalTo(SIZE(36));
    }];
    
    
    UIView*bottomLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(241, 241, 241)];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(SIZE(0.5));
    }];
    
}





/**
 * @params chart       - 名次
 * @params phoneNumber - 手机号
 * @params loadMoney   - 放款金额（万元）
 * @params isHiddenLineAndShowLayer - 是否隐藏间隔线和切名次圆弧
 * @params chartLabelColor - 名次背景色
 */
- (void )setChart:(NSString *)chart phoneNumber:(NSString *)phoneNumber loadMoney:(NSString *)loadMoney isHiddenLineAndShowLayer:(BOOL )isHiddenLineAndShowLayer chartLabelColor:(UIColor *)chartLabelColor{
    chartslabel.text = chart;
    phoneNumberLabel.text = phoneNumber;
    totalMoney.text = loadMoney;
    if (isHiddenLineAndShowLayer) {
        line0.hidden = YES;
        line1.hidden = YES;
        chartslabel.layer.masksToBounds = YES;
        chartslabel.layer.cornerRadius = SIZE(18);
    }else{
        line0.hidden = NO;
        line1.hidden = NO;
        chartslabel.layer.masksToBounds = NO;
    }
    
    if (!chartLabelColor) {
        //名次lable没有背景颜色
        chartslabel.textColor = RGB(66, 66, 66);
        chartslabel.backgroundColor = [UIColor clearColor];
    }else{
        chartslabel.textColor = [UIColor whiteColor];
        chartslabel.backgroundColor = chartLabelColor;
    }
    
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
