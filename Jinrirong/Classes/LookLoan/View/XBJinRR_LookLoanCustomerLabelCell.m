//
//  XBJinRR_LookLoanCustomerLabelCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/31.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_LookLoanCustomerLabelCell.h"

@implementation XBJinRR_LookLoanCustomerLabelCell
{
    UIView  *bottomView;
    UILabel *applyPeopleCountLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}


- (void )creatUI{
    bottomView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE(13));
        make.top.mas_equalTo(SIZE(10));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-SIZE(10));
        make.right.mas_equalTo(-SIZE(13));
    }];
    
    
    applyPeopleCountLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(120, 120, 120) textAlignment:Center font:FONT(15)];
    [bottomView addSubview:applyPeopleCountLabel];
    [applyPeopleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(SIZE(30));
    }];
    
    UIImageView *bgImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"loan_pho"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [bottomView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.mas_equalTo(self->applyPeopleCountLabel.mas_top).offset(-5);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(bgImageView.mas_height).multipliedBy(228/273.0);//273-228
    }];
}






-(void)setApplyPeopleCount:(NSString *)applyPeopleCount{
    _applyPeopleCount = applyPeopleCount;
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:@"申请人数" attributes:@{NSFontAttributeName:FONT(13),NSForegroundColorAttributeName:RGB(120, 120, 120)}];
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人",_applyPeopleCount] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:MainColor}];
    [attri0 appendAttributedString:attri1];
    applyPeopleCountLabel.attributedText = attri0;
}













    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
