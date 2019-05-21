//
//  XBJinRRMyMessageMainCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMyMessageMainCell.h"

@interface XBJinRRMyMessageMainCell()
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@end

@implementation XBJinRRMyMessageMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.width.offset(48);
            make.height.offset(47.5);
        }];
        self.icon = icon;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(15);
            make.top.equalTo(icon.mas_top).offset(2);
        }];
        self.nameLabel = nameLabel;
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = [UIFont systemFontOfSize:13];
        descLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(15);
            make.bottom.equalTo(icon.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(-30);
        }];
        self.descLabel = descLabel;
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon.mas_top).offset(0);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        self.dateLabel = dateLabel;
    }
    return self;
}
- (void)setMyMsgItemModel:(XBJinRRMyMsgItemModel *)myMsgItemModel
{
    _myMsgItemModel = myMsgItemModel;
    if ([myMsgItemModel.Type integerValue] == 0) {
        self.icon.image = [UIImage imageNamed:@"per-news-fit"];
        self.nameLabel.text = @"系统消息";
    } else if ([myMsgItemModel.Type integerValue] == 1) {
        self.icon.image = [UIImage imageNamed:@"per-news-notice"];
        self.nameLabel.text = @"通知消息";
    }
    
    self.descLabel.text = myMsgItemModel.Contents;
    self.dateLabel.text = myMsgItemModel.SendTime;
}
@end
