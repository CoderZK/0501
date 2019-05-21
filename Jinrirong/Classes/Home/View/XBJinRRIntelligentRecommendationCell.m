//
//  XBJinRRIntelligentRecommendationCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRIntelligentRecommendationCell.h"
#import "XBJinRRRecommendItemView.h"

@interface XBJinRRIntelligentRecommendationCell()
@property (nonatomic,strong) UIView *bg;
@end

@implementation XBJinRRIntelligentRecommendationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        UIImageView * hotImg = [UIImageView new];
//        hotImg.image = [UIImage imageNamed:@"home_hot"];
//        [self.contentView addSubview:hotImg];
//        [hotImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(SIZE(20/1.44));
//            make.left.offset(SIZE(20/1.44));
//            make.height.width.offset(SIZE(22/1.44));
//        }];
//
//        UILabel *nameLabel = [[UILabel alloc] init];
//        nameLabel.font = [UIFont systemFontOfSize:22/1.44];
//        nameLabel.textColor = [UIColor blackColor];
//        nameLabel.text = @"借贷精选";
//        [self.contentView addSubview:nameLabel];
//        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(hotImg.mas_centerY).offset(0);
//            make.left.equalTo(hotImg.mas_right).offset(0);
//
//        }];
//
//        UILabel *descLabel = [[UILabel alloc] init];
//        descLabel.font = [UIFont systemFontOfSize:15/1.44];
//        descLabel.textColor = [UIColor grayColor];
//        descLabel.text = @"在这里每天都有新平台";
//        [self.contentView addSubview:descLabel];
//        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(nameLabel.mas_bottom).offset(0);
//            make.left.equalTo(nameLabel.mas_right).offset(5);
//        }];
//
//        UIView *bg = [[UIView alloc] init];
//        [self.contentView addSubview:bg];
//        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(descLabel.mas_bottom).offset(10);
//            make.left.equalTo(self.mas_left).offset(0);
//            make.right.equalTo(self.mas_right).offset(0);
//            make.bottom.equalTo(self.mas_bottom).offset(0);
//
//        }];
//        self.bg = bg;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"智能推荐";
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = [UIFont systemFontOfSize:13];
        descLabel.textColor = [UIColor grayColor];
        descLabel.text = @"-----在这里每天都有新平台-----";
        [self.contentView addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(6);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
        
        UIView *bg = [[UIView alloc] init];
        [self.contentView addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(descLabel.mas_bottom).offset(6);
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            
        }];
        self.bg = bg;
        
    }
    return self;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *v in self.bg.subviews) {
        [v removeFromSuperview];
    }
}
- (void)setRecommendArray:(NSArray *)recommendArray
{
    _recommendArray = recommendArray;
    CGFloat w = SCREEN_WIDTH/4;
    for (int i = 0; i < recommendArray.count; i++) {
        XBJinRRHomeRecommandModel *model = recommendArray[i];
        XBJinRRRecommendItemView *itemView = [[XBJinRRRecommendItemView alloc] init];
        itemView.frame = CGRectMake((i%4)*w, 0, w, 90);
        itemView.recommandModel = model;
        itemView.tag = i;
        [self.bg addSubview:itemView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedModelTap:)];
        [itemView addGestureRecognizer:tap];
    }
}


- (void )selectedModelTap:(UITapGestureRecognizer *)tapper{
    if (self.selectedModelBlock) {
        self.selectedModelBlock(self.recommendArray[tapper.view.tag]);
    }
}

@end
