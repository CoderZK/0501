//
//  XBJinRRCreatSmallPicTableViewCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/1.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCreatSmallPicTableViewCell.h"

@interface XBJinRRCreatSmallPicTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingLeftMarginConstrain;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;//银行卡图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//银行名字标签
@property (weak, nonatomic) IBOutlet UILabel *applyCountsLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;//描述信息
@property (weak, nonatomic) IBOutlet UILabel *desLabel;//专享标签
@property (weak, nonatomic) IBOutlet UILabel *applyNumbersLabel;

@end



@implementation XBJinRRCreatSmallPicTableViewCell

//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self creatUI];
//    }
//    return self;
//}
//- (void )creatUI{
//    self.desLabel.layer.borderColor = MainColor.CGColor;
//    self.desLabel.layer.borderWidth = 1.f;
//}
-(void)setCreditCardModel:(XBJinRRCreditCardModel *)creditCardModel{
    _creditCardModel = creditCardModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_creditCardModel.Logurl]];
    self.nameLabel.text = _creditCardModel.BankName;
    self.contentLabel.text = _creditCardModel.Name;
    self.desLabel.text = @"专享";
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:_creditCardModel.AppNumbs attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:MainColor}];
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:@"人申请" attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120)}];
    [attri0 appendAttributedString:attri1];
    self.applyNumbersLabel.attributedText = attri0;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.desLabel.layer.borderColor = MainColor.CGColor;
    self.desLabel.layer.borderWidth = 1.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
