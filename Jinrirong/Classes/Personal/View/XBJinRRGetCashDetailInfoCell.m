//
//  XBJinRRGetCashDetailInfoCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRGetCashDetailInfoCell.h"

@implementation XBJinRRGetCashDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setTModel:(XBJinRRWalletInfoModel *)tModel{
    _tModel = tModel;
    self.nameLabel.textColor = RGB(66, 66, 66);
    self.nameLabel.font = FONT(17);
    self.nameLabel.text = @"提现";
    self.yuELabel.textColor = RGB(180, 180, 180);
    self.yuELabel.font = FONT(15);
    self.yuELabel.text = [NSString stringWithFormat:@"余额：¥%@",_tModel.CurlMoney];
    self.countLabel.textColor = MainColor;
    self.countLabel.font = FONT(15);
    self.countLabel.text = [NSString stringWithFormat:@"-%@",_tModel.Money];
    self.dateLabel.textColor = RGB(180, 180, 180);
    self.dateLabel.font = FONT(15);
    self.dateLabel.text = [NSString stringWithFormat:@"%@",_tModel.AddTime];
    

}


@end
