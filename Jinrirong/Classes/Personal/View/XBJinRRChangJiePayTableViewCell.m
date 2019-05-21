//
//  XBJinRRChangJiePayTableViewCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/9/22.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRChangJiePayTableViewCell.h"

@implementation XBJinRRChangJiePayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = MainColor;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [MyAdapter lfontADapter:15];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset([MyAdapter laDapter:10]);
            //  make.centerY.offset(0);
            make.height.offset([MyAdapter laDapter:30]);
            make.top.offset(0);
            make.width.offset(150);
        }];
    }
    if (!_inputTF) {
        _inputTF = [[UITextField alloc]init];
        _inputTF.textColor = MainColor;
        _inputTF.font = [MyAdapter lfontADapter:15];
        [self.contentView addSubview:_inputTF];
        [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-[MyAdapter laDapter:10]);
            make.centerY.offset(0);
            make.height.offset([MyAdapter laDapter:60]);
            // make.right.offset([MyAdapter laDapter:-10]);
        }];
    }
    
    
}

@end
