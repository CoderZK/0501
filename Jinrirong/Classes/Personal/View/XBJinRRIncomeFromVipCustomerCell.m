//
//  XBJinRRIncomeFromVipCustomerCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRIncomeFromVipCustomerCell.h"
@interface XBJinRRIncomeFromVipCustomerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *getMoneyLabel;
@end

@implementation XBJinRRIncomeFromVipCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius  = 25.f;
    self.nameLabel.font = FONT(16);
    self.nameLabel.textColor = RGB(66, 66, 66);

    self.timeLabel.font = FONT(12);
    self.timeLabel.textColor = RGB(166, 166, 166);
    self.getMoneyLabel.font = FONT(15);
    self.getMoneyLabel.textColor = RGB(166, 166, 166);
}



-(void)setModel:(XBJinRRReferincomeModel *)model{
    _model = model;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_model.HeadImg]];
    
    self.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",_model.Mobile];
//    self.isOpenLabel.text = [NSString stringWithFormat:@"%@",_model.Mobile];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.UpdateTime];
    
    
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:@"佣金：" attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(166, 166, 166)}];
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_model.Amount] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(255, 147, 38)}];
    [attri0 appendAttributedString:attri1];
    self.getMoneyLabel.attributedText = attri0;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
