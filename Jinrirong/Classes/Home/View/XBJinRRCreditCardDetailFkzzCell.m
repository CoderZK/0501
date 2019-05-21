//
//  XBJinRRCreditCardDetailFkzzCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCreditCardDetailFkzzCell.h"
@interface XBJinRRCreditCardDetailFkzzCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation XBJinRRCreditCardDetailFkzzCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.nameLabel.font = FONT(17);
    self.nameLabel.textColor = RGB(66, 66, 66);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
