//
//  XBJinRRPersonalNormalCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPersonalNormalCell.h"

@implementation XBJinRRPersonalNormalCell

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
            make.left.equalTo(icon.mas_right).offset(15);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        self.nameLabel = nameLabel;
    }
    return self;
}

@end
