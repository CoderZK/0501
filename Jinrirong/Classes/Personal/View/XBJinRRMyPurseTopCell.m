//
//  XBJinRRMyPurseTopCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMyPurseTopCell.h"

@implementation XBJinRRMyPurseTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipsLabel.layer.masksToBounds = YES;
    self.tipsLabel.layer.cornerRadius  = 10;
    self.tipsLabel.backgroundColor = MainColor;
    self.checkLabel.backgroundColor = MainColor;
    self.checkLabel.layer.masksToBounds = YES;
    self.checkLabel.layer.cornerRadius  = 10;
    
    self.getcashLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapper:)];
    [self.getcashLabel addGestureRecognizer:tap];
    
    self.allMoneyLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkMoreDetail:)];
    [self.allMoneyLabel addGestureRecognizer:tap1];
}


- (void )tapper:(UITapGestureRecognizer *)tapper{
    if (self.getWalletClickBlock) {
        self.getWalletClickBlock();
    }
}
- (void )checkMoreDetail:(UITapGestureRecognizer *)tapper{
    if (self.chechMoreDetailClickBlock) {
        self.chechMoreDetailClickBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
