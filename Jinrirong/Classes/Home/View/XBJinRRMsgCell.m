//
//  XBJinRRMsgCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMsgCell.h"
//#import "GYChangeTextView.h"
#import "XBJinRRHomeNoticeModel.h"
#import <JhtMarquee/JhtVerticalMarquee.h>

@interface XBJinRRMsgCell()
{
    JhtVerticalMarquee *verticalMarquee;
    __block NSInteger nowIndex;
}

@end

@implementation XBJinRRMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"home-news2"];
        [self.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        
        verticalMarquee = [[JhtVerticalMarquee alloc] initWithFrame:CGRectMake(15+15+10, 0, SCREEN_WIDTH-15-15-10-15-8, 44)];
        [verticalMarquee scrollWithCallbackBlock:^(JhtVerticalMarquee *view, NSInteger currentIndex) {
            self->nowIndex = currentIndex;
        }];
        [self.contentView addSubview:verticalMarquee];
        // 添加点击手势
        UITapGestureRecognizer *vtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marqueeTapGes:)];
        [verticalMarquee addGestureRecognizer:vtap];
        
        
        UIImageView *rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home-right"]];
        rightIcon.userInteractionEnabled = YES;
        [self.contentView addSubview:rightIcon];
        [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        
//        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
//        [rightIcon addGestureRecognizer:tap0];
        
    }
    return self;
}

- (void)marqueeTapGes:(UITapGestureRecognizer *)ges {
//    if (self.clickNewsIndexBlock) {
//        self.clickNewsIndexBlock(nowIndex);
//    }
    if (self.clickMoreNewsBlock) {
        self.clickMoreNewsBlock();
    }
}
//- (void)tapGes:(UITapGestureRecognizer *)ges {
//    if (self.clickMoreNewsBlock) {
//        self.clickMoreNewsBlock();
//    }
//}

- (void)setNoticeArray:(NSArray *)noticeArray
{
    _noticeArray = noticeArray;
    NSMutableArray *textArray = [NSMutableArray array];
    for (XBJinRRHomeNoticeModel *model in noticeArray) {
        [textArray addObject:model.Title];
    }
    
    
    if (textArray.count > 0) {
        
        verticalMarquee.sourceArray = textArray;
        [verticalMarquee marqueeOfSettingWithState:MarqueeStart_V];

    }
    
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    [verticalMarquee marqueeOfSettingWithState:MarqueeStart_V];
}
@end
