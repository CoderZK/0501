//
//  XBJinRRBigBankCardCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBigBankCardCell.h"

@implementation XBJinRRBigBankCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bankCardImageView.layer.masksToBounds = YES;
    self.bankCardImageView.layer.cornerRadius = 5.f;
    self.bankCardImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
