//
//  XBJinRR_LoadShareProductCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_LoadShareProductCell.h"

@implementation XBJinRR_LoadShareProductCell
{
    UILabel *titleLabel;
    UIImageView *myImageView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}


- (void )creatUI{
    CGFloat width  = SCREEN_WIDTH/3.f;
    CGFloat height = SIZE(130);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    bgView.backgroundColor = [UIColor whiteColor];
    myImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectMake(width, 0, width, height).size.width-SIZE(50))*0.5, CGRectMake(width, 0, width, height).size.height*0.6-SIZE(50), SIZE(50), SIZE(50))];
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:myImageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE(10), CGRectMake(width, 0, width, height).size.height*0.6, CGRectMake(width, 0, width, height).size.width-SIZE(20),CGRectMake(width, 0, width, height).size.height*0.3)];
    titleLabel.font = FONT(14);
    titleLabel.textColor = RGB(120, 120, 120);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    [self.contentView addSubview:bgView];
}


- (void )setImageWithImageUrl:(NSString *)imageUrl title:(NSString *)title{
    [myImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    titleLabel.text = title;
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
