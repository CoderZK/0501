//
//  XBJinRR_LookLoanLabelCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/31.
//  Copyright © 2018年 ahxb. All rights reserved.
//  标签🏷️

#import "XBJinRR_LookLoanLabelCell.h"

@implementation XBJinRR_LookLoanLabelCell

{
    UILabel *firstLabel;
    UILabel *secondLabel;
    UILabel *thirdLabel;
    UILabel *fouthLabel;
    NSArray *labelsArray;
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
    firstLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"略略略略" textColor:RGB(120, 120, 120) textAlignment:Center font:FONT(14)];
    firstLabel.layer.borderColor = RGB(120, 120, 120).CGColor;
    firstLabel.layer.borderWidth = 0.5;
    [self.contentView addSubview:firstLabel];
    secondLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(120, 120, 120) textAlignment:Center font:FONT(14)];
    secondLabel.layer.borderColor = RGB(120, 120, 120).CGColor;
    secondLabel.layer.borderWidth = 0.5;
    [self.contentView addSubview:secondLabel];
    thirdLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(120, 120, 120) textAlignment:Center font:FONT(14)];
    thirdLabel.layer.borderColor = RGB(120, 120, 120).CGColor;
    thirdLabel.layer.borderWidth = 0.5;
    [self.contentView addSubview:thirdLabel];
    fouthLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(120, 120, 120) textAlignment:Center font:FONT(14)];
    fouthLabel.layer.borderColor = RGB(120, 120, 120).CGColor;
    fouthLabel.layer.borderWidth = 0.5;
    [self.contentView addSubview:fouthLabel];
    labelsArray = @[firstLabel,secondLabel,thirdLabel,fouthLabel];
    CGFloat width = (SCREEN_WIDTH-SIZE(26)-30)/4.f;
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(SIZE(13));
        make.top.mas_equalTo(SIZE(10));
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(SIZE(30));
    }];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->firstLabel.mas_right).offset(10);
        make.top.mas_equalTo(SIZE(10));
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(SIZE(30));
    }];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->secondLabel.mas_right).offset(10);
        make.top.mas_equalTo(SIZE(10));
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(SIZE(30));
    }];
    [fouthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->thirdLabel.mas_right).offset(10);
        make.top.mas_equalTo(SIZE(10));
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(SIZE(30));
    }];
    firstLabel.hidden = YES;
    secondLabel.hidden = YES;
    thirdLabel.hidden = YES;
    fouthLabel.hidden = YES;
    
    
    bottomView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE(13));
        make.top.mas_equalTo(self->firstLabel.mas_bottom).offset(SIZE(10));
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




/**
 *  @params titles 标签名称的数组
 *  @params applyPeopleCount 申请人数多少人
 *  @params isShowBottomView 是否展示底部图片和申请人数
 */
- (void )setlabelTitles:(NSArray *)titles applyPeopleCount:(NSString *)applyPeopleCount isShowBottomView:(BOOL )isShowBottomView{
    for (int i=0; i<titles.count; i++) {
        UILabel *label = labelsArray[i];
        label.hidden = NO;
        label.text = titles[i];
    }
    if (isShowBottomView) {
        bottomView.hidden = NO;
        NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:@"申请人数" attributes:@{NSFontAttributeName:FONT(13),NSForegroundColorAttributeName:RGB(120, 120, 120)}];
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",applyPeopleCount] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:MainColor}];
        [attri0 appendAttributedString:attri1];
        applyPeopleCountLabel.attributedText = attri0;
        applyPeopleCountLabel.hidden = NO;
    }else{
        bottomView.hidden = YES;
        [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SIZE(13));
            make.top.mas_equalTo(self->firstLabel.mas_bottom).offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
            make.right.mas_equalTo(-SIZE(13));
        }];
    }
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
