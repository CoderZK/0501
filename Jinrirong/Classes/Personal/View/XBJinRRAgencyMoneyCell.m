//
//  XBJinRRAgencyMoneyCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRAgencyMoneyCell.h"

@implementation XBJinRRAgencyMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *agencyLabel = [[UILabel alloc] init];
        agencyLabel.font = [UIFont systemFontOfSize:14];
        agencyLabel.textColor = [UIColor blackColor];
        agencyLabel.text = @"价格";
        [self.contentView addSubview:agencyLabel];
        [agencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        self.agencyLabel = agencyLabel;
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.text = @"￥0.00";
        moneyLabel.font = [UIFont systemFontOfSize:16];
        moneyLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        self.moneyLabel = moneyLabel;
    }
    return self;
}

@end
