//
//  XBJinRRCredibilityCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/6.
//  Copyright © 2018年 ahxb. All rights reserved.
//  征信列表cell

#import "XBJinRRCredibilityCell.h"

@implementation XBJinRRCredibilityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.font = FONT(16);
    self.nameLabel.textColor = BlackColor;
    
    self.detailLabel.font = FONT(12);
    self.detailLabel.textColor = MainColor;
    self.detailLabel.text = @"详情";
    self.detailLabel.layer.masksToBounds = YES;
    self.detailLabel.layer.cornerRadius = 13;
    self.detailLabel.layer.borderColor = MainColor.CGColor;
    self.detailLabel.layer.borderWidth = 1.f;
    
    self.statusLabel.font = FONT(16);
    self.statusLabel.textColor = MainColor;
    
    
}



- (void)setTModel:(XBJinRRCredibilityModel *)tModel{
    _tModel = tModel;
    
    self.nameLabel.text = _tModel.TrueName;
//    NSString *statusStr = nil;
//    if ([[NSString stringWithFormat:@"%@",_tModel.Status] isEqualToString:@"1"]) {
//        statusStr = @"待付款";
//    }
//    if ([[NSString stringWithFormat:@"%@",_tModel.Status] isEqualToString:@"2"]) {
//        statusStr = @"已付款";
//    }
//    if ([[NSString stringWithFormat:@"%@",_tModel.Status] isEqualToString:@"3"]) {
//        statusStr = @"查询失败";
//    }
//    if ([[NSString stringWithFormat:@"%@",_tModel.Status] isEqualToString:@"4"]) {
//        statusStr = @"已查询";
//    }
//    if ([[NSString stringWithFormat:@"%@",_tModel.Status] isEqualToString:@"5"]) {
//        statusStr = @"已取消";
//    }
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:@"状态：" attributes:@{NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:RGB(122, 122, 122)}];
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:_tModel.Status attributes:@{NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:RGB(255, 30, 0)}];
    [attri0 appendAttributedString:attri1];
    self.statusLabel.attributedText = attri0;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
