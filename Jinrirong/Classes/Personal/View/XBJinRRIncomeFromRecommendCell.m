//
//  XBJinRRIncomeFromRecommendCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRIncomeFromRecommendCell.h"

@implementation XBJinRRIncomeFromRecommendCell

//131高度

- (void)awakeFromNib {
    [super awakeFromNib];
    self.orderNumLabel.font = FONT(15);
    self.orderNumLabel.textColor = RGB(120, 120, 120);
    self.dateLabel.font = FONT(15);
    self.dateLabel.textColor = MainColor;
    
//    self.iconImageView
    self.phoneNumLabel.font = FONT(12);
    self.phoneNumLabel.textColor = BlackColor;
    self.bonusLabel.font = FONT(12);
    self.bonusLabel.textColor = WhiteColor;
    self.bonusLabel.backgroundColor = MainColor;
    self.bonusLabel.layer.masksToBounds = YES;
    self.bonusLabel.layer.cornerRadius = 12.5;
    
    
    self.submitTimeLabel.font = FONT(12);
    self.submitTimeLabel.textColor = RGB(166, 166, 166);
}


- (void)setTModel:(XBJinRRPromotdataModel *)tModel{
    _tModel = tModel;
    
    if ([_tModel.Status isEqualToString:@"1"]) {
        self.bonusLabel.textColor = WhiteColor;
        self.bonusLabel.backgroundColor = MainColor;
    }else{
        self.bonusLabel.textColor = RGB(176, 176, 176);
        self.bonusLabel.backgroundColor = RGB(239, 239, 239);
    }
    
    
    
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单编号：%@",_tModel.OrderSn];
    self.dateLabel.text = [NSString stringWithFormat:@"%@",_tModel.Settletime];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_tModel.Logurl]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",_tModel.goodname];
    self.phoneNumLabel.text = [NSString stringWithFormat:@"手机号码：%@",_tModel.Mobile];
    if (_tModel.applyBonus) {
        if(self.bonusLabel.frame.size.width!=110){
            self.widthcn.constant += 30;
            self.leftCn.constant -= 30;
        }
    }
    
    if ([_tModel.Status isEqualToString:@"0"]) {
        if(_tModel.applyBonus){
            self.bonusLabel.text = [NSString stringWithFormat:@"申请%@元+放款%@%@",_tModel.applyBonus,[_tModel.Yjtype isEqualToString:@"1"]?_tModel.BonusRate:_tModel.Ymoney,[_tModel.Yjtype isEqualToString:@"1"]?@"%":@"元"];
        }
        else{
            self.bonusLabel.text = [NSString stringWithFormat:@"放款%@%@",[_tModel.Yjtype isEqualToString:@"1"]?_tModel.BonusRate:_tModel.Ymoney,[_tModel.Yjtype isEqualToString:@"1"]?@"%":@"元"];
        }
    }else{
        if(_tModel.applyBonus){
            self.bonusLabel.text = [NSString stringWithFormat:@"申请%@元+放款%@%@",_tModel.applyBonus,_tModel.Bonus,@"元"];
        }else{
            self.bonusLabel.text = [NSString stringWithFormat:@"放款%@%@",_tModel.Bonus,@"元"];
        }
    }
    
    self.submitTimeLabel.text = [NSString stringWithFormat:@"提交时间：%@",_tModel.Addtime];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
