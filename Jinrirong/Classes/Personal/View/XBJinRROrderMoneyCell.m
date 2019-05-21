//
//  XBJinRROrderMoneyCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRROrderMoneyCell.h"

@implementation XBJinRROrderMoneyCell
{
    UILabel *moneyLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"订单金额";
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(15);
        }];
        
        moneyLabel = [[UILabel alloc] init];
        moneyLabel.font = [UIFont systemFontOfSize:22];
        moneyLabel.textColor = [UIColor orangeColor];
        moneyLabel.text = @"￥0.00";
        [self.contentView addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
        }];
    }
    return self;
}


- (void)setPayMoney:(NSString *)payMoney{
    _payMoney = payMoney;
    moneyLabel.text = _payMoney;
}


@end
