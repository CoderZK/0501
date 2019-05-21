//
//  XBJinRR_NewsCell.m
//  Jinrirong
//
//  Created by 张艳江 on 2019/4/12.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBJinRR_NewsCell.h"

@implementation XBJinRR_NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.newsImage.contentMode = UIViewContentModeScaleAspectFill;
    self.newsImage.clipsToBounds = YES;
}
- (void)setModel:(XBJinRRNewsListModel *)model{
    _model = model;
    NSString *imageUrl = [NSString stringWithFormat:@"http://new.ganzheapp.com%@",model.CoverImage];
    [self.newsImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.newsTitleLab.text = model.Title;
    self.newsTimeLab.text = model.AddTime;
    if ([model.IsVip intValue] == 0) {
        self.newsTypeLab.text = @"全部会员可见";
    }else{
        self.newsTypeLab.text = @"仅VIP会员可见";
    }
    self.newsSeeLab.text = [NSString stringWithFormat:@"%@阅读量",model.YDL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
