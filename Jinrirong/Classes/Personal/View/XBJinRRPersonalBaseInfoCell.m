//
//  XBJinRRPersonalBaseInfoCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPersonalBaseInfoCell.h"

@interface XBJinRRPersonalBaseInfoCell()

@end

@implementation XBJinRRPersonalBaseInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = FONT(15);
        nameLabel.textColor = RGB(66, 66, 66);
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(SIZE(15));
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.width.mas_equalTo(SIZE(120));
        }];
        self.nameLabel = nameLabel;
        
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SIZE(50)-SIZE(15), SIZE(2.5), SIZE(50), SIZE(50))];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = SIZE(25);
        
        icon.layer.borderColor = [UIColor lightGrayColor].CGColor;
        icon.layer.borderWidth = 1.f;
        
        [self.contentView addSubview:icon];
//        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-SIZE(15));
//            make.centerY.equalTo(self.mas_centerY).offset(0);
//            make.width.height.offset(40);
//        }];
        self.icon = icon;
        
        
        UITextField *detailTf = [ViewCreate createTextFieldFrame:CGRectMake(0, 0, 0, 0) font:FONT(15) textColor:RGB(194, 194, 194) placeHolder:@"" delegate:nil];
        detailTf.textAlignment = Right;
        [self.contentView addSubview:detailTf];
        [detailTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-SIZE(15));
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.mas_equalTo(nameLabel.mas_right).offset(10);
        }];
        self.detailTF = detailTf;
    }
    return self;
}

@end
