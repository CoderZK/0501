//
//  XBJinRRRecommendItemView.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRRecommendItemView.h"

@interface XBJinRRRecommendItemView()
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *descLabel;
@end

@implementation XBJinRRRecommendItemView

- (instancetype)init
{
    if (self = [super init]) {
        UIImageView *icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.width.height.offset(40);
        }];
        self.icon = icon;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
        self.nameLabel = nameLabel;
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.textColor = [UIColor grayColor];
        descLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
        self.descLabel = descLabel;
    }
    return self;
}
- (void)setRecommandModel:(XBJinRRHomeRecommandModel *)recommandModel
{
    _recommandModel = recommandModel;
    NSString *url = [recommandModel.Logurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = recommandModel.Name;
//    NSLog(@"%.4f",[recommandModel.AppNumbs floatValue]/10000.0);
    
    if (recommandModel.AppNumbs.length > 4) {
        self.descLabel.text = [NSString stringWithFormat:@"%.1f万人申请", [recommandModel.AppNumbs floatValue]/10000.0];
    }else{
        self.descLabel.text = [NSString stringWithFormat:@"%@人申请", recommandModel.AppNumbs];
    }
    
    
}
@end
