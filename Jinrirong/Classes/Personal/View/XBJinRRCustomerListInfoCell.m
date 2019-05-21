//
//  XBJinRRCustomerListInfoCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCustomerListInfoCell.h"

@implementation XBJinRRCustomerListInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTModel:(XBJinRRCustomerListInfoModel *)tModel{
    _tModel = tModel;
    self.productNameLabel.text = _tModel.Name;
    self.applyCountLabel.text = _tModel.applycount;
    self.statusLabel.text = [NSString stringWithFormat:@"%@",_tModel.fksuccess];
    self.bounceLabel.text = [NSString stringWithFormat:@"¥%@",_tModel.BonusAll];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
