//
//  XBJinRRCheckCreditCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCheckCreditCell.h"

@implementation XBJinRRCheckCreditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        
        self.valueTF = [[UITextField alloc] init];
        self.valueTF.textAlignment = NSTextAlignmentRight;
        self.valueTF.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.valueTF];
        [self.valueTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
    }
    return self;
}

@end
