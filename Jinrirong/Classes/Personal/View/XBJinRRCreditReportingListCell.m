//
//  XBJinRRCreditReportingListCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//  征信列表页

#import "XBJinRRCreditReportingListCell.h"

@implementation XBJinRRCreditReportingListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.font = FONT(15);
    self.nameLabel.textColor = BlackColor;
    self.phoneNumLabel.font = FONT(15);
    self.phoneNumLabel.textColor = RGB(166, 166, 166);
    self.moneyLabel.font = FONT(15);
    self.moneyLabel.textColor = RGB(243, 181, 38);
    self.timeLabel.font = FONT(15);
    self.timeLabel.textColor = RGB(166, 166, 166);
}

-(void)setTModel:(XBJinRRMakeincomeModel *)tModel{
    _tModel = tModel;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",_tModel.Name];
    self.phoneNumLabel.text = [NSString stringWithFormat:@"借贷手机：%@",_tModel.Mobile];
    self.moneyLabel.text = [NSString stringWithFormat:@"+%@",_tModel.Amount];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_tModel.UpdateTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
