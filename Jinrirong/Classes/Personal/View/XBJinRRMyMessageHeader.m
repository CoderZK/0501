//
//  XBJinRRMyMessageHeader.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/16.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMyMessageHeader.h"

@implementation XBJinRRMyMessageHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.backgroundColor = RGB(224, 224, 224);
        [self addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.top.equalTo(self.mas_top).offset(20);
        }];
        self.dateLabel = dateLabel;
    }
    return self;
}

@end
