//
//  XBJinRRPaymentCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPaymentCell.h"

@implementation XBJinRRPaymentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        self.icon = icon;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon.mas_top).offset(0);
            make.left.equalTo(icon.mas_right).offset(10);
        }];
        self.nameLabel = nameLabel;
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = [UIFont systemFontOfSize:14];
        descLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(10);
            make.bottom.equalTo(icon.mas_bottom).offset(0);
        }];
        self.descLabel = descLabel;
        
        self.selectedIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.selectedIcon];
        [self.selectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.width.height.mas_equalTo(20);
        }];
        
        
    }
    return self;
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.selectedIcon.image = [UIImage imageNamed:imageName];
}

@end
