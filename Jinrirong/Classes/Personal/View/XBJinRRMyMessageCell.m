//
//  XBJinRRMyMessageCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/16.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMyMessageCell.h"

@interface XBJinRRMyMessageCell()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *descLabel;
@end

@implementation XBJinRRMyMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = [UIColor whiteColor];
        bg.layer.cornerRadius = 6;
        bg.layer.masksToBounds = YES;
        bg.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bg.layer.borderWidth = 0.5;
        [self.contentView addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textColor = [UIColor blackColor];
        [bg addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bg.mas_left).offset(10);
            make.top.equalTo(bg.mas_top).offset(10);
        }];
        self.nameLabel = nameLabel;
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = [UIFont systemFontOfSize:13];
        descLabel.textColor = [UIColor grayColor];
        descLabel.numberOfLines = 0;
        [bg addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bg.mas_left).offset(10);
            make.top.equalTo(nameLabel.mas_bottom).offset(5);
            make.right.equalTo(bg.mas_right).offset(-10);
        }];
        self.descLabel = descLabel;
    }
    return self;
}
- (void)setMsgItemModel:(XBJinRRMyMsgItemModel *)msgItemModel
{
    _msgItemModel = msgItemModel;
    self.nameLabel.text = msgItemModel.Title;
    self.descLabel.text = msgItemModel.Contents;
}
@end
