//
//  XBJinRR_SalaryDescriptionCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_LoadShareSalaryDescriptionCell.h"

@interface XBJinRR_LoadShareSalaryDescriptionCell()

@property(nonatomic, copy)NSArray *infoArray;
@end

@implementation XBJinRR_LoadShareSalaryDescriptionCell

-(NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray = @[@{@"imageName":@"distribution-img1",@"titleStr":@"放款10万元",@"count":@"1500"},@{@"imageName":@"distribution-img2",@"titleStr":@"放款20万元",@"count":@"2000"},@{@"imageName":@"distribution-img3",@"titleStr":@"放款30万元",@"count":@"3000"}];
    }
    return _infoArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}


- (void )creatUI{
    CGFloat width  = SCREEN_WIDTH/3.f;
    CGFloat height = SIZE(150);
    for (int i=0; i<self.infoArray.count; i++) {
        NSDictionary *infoDic = self.infoArray[i];
        UIView *vi = [self creatUIWithFrame:CGRectMake(width*i, 0, width, height) title:infoDic[@"titleStr"] imageName:infoDic[@"imageName"] count:infoDic[@"count"]];
        [self.contentView addSubview:vi];
    }
    
    UILabel *deslabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE(13), SIZE(160), SCREEN_WIDTH-SIZE(26), SIZE(120))];
    deslabel.numberOfLines = 4 ;
    deslabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:deslabel];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:@"结算方式\n" attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(66, 66, 66),NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 10;
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:@"· [结算]，每月初的前五个工作日开始结算。\n· 首次注册申请借贷符合结算标准。\n· 备注：非新用户申请不计入结算标准，请知晓。" attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
    [attri0 appendAttributedString:attri1];
    
    
    deslabel.attributedText = attri0;
}

- (UIView *)creatUIWithFrame:(CGRect )frame title:(NSString *)title imageName:(NSString *)imageName count:(NSString *)count{
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor whiteColor];
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    myImageView.frame = CGRectMake((frame.size.width-SIZE(70)*1.2)*0.5, frame.size.height*0.6-SIZE(70), SIZE(70)*1.2, SIZE(70));
    [bgView addSubview:myImageView];
    
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-SIZE(70)*1.2)*0.5, frame.size.height*0.6-SIZE(70), SIZE(70)*1.2, SIZE(70))];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 2;
    [bgView addSubview:contentLabel];
    
    NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:@"奖励\n¥" attributes:@{NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:count attributes:@{NSFontAttributeName:FONT(14),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [attri0 appendAttributedString:attri1];
    contentLabel.attributedText = attri0;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE(10), frame.size.height*0.6, frame.size.width-SIZE(20),frame.size.height*0.3)];
    titleLabel.text = title;
    titleLabel.font = FONT(14);
    titleLabel.textColor = RGB(120, 120, 120);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    return bgView;
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
