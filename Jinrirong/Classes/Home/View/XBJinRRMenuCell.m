//
//  XBJinRRMenuCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMenuCell.h"

@implementation XBJinRRMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = RGB(237, 236, 242);
        [self.contentView addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
        
        NSArray *dataArray = @[@{@"icon":@"home-loan",@"title":@"贷款大全",@"desc":@"最新最全口子"},@{@"icon":@"home-card1",@"title":@"办信用卡",@"desc":@"下卡快额度高"},@{@"icon":@"home-community",@"title":@"我要赚钱",@"desc":@"邀请朋友赚钱"},@{@"icon":@"home-credit",@"title":@"黑名单查询",@"desc":@"老被拒？看是否黑了"}];
        
        CGFloat w = (SCREEN_WIDTH-4)*0.5;
        CGFloat h = (140-2)*0.5;
        for (int i = 0; i < 4; i++) {
            UIView *itemBg = [[UIView alloc] init];
            itemBg.backgroundColor = [UIColor whiteColor];
            CGFloat x = (i % 2)*(w+4);
            CGFloat y = (i / 2)*(h+2);
            itemBg.frame = CGRectMake(x, y, w, h);
            [bg addSubview:itemBg];
            
            itemBg.tag = i;
            UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteedItem:)];
            [itemBg addGestureRecognizer:tap];
            
            NSDictionary *dict = dataArray[i];
            
            UIImageView *icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:dict[@"icon"]];
            [itemBg addSubview:icon];
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(itemBg.mas_left).offset(20);
                make.centerY.equalTo(itemBg.mas_centerY).offset(0);
            }];
            
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.font = [UIFont systemFontOfSize:15];
            nameLabel.text = dict[@"title"];
            [itemBg addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(icon.mas_right).offset(10);
                make.top.equalTo(itemBg.mas_top).offset(15);
            }];
            
            UILabel *descLabel = [[UILabel alloc] init];
            descLabel.textColor = [UIColor grayColor];
            descLabel.font = [UIFont systemFontOfSize:13];
            descLabel.text = dict[@"desc"];
            [itemBg addSubview:descLabel];
            [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(icon.mas_right).offset(10);
                make.bottom.equalTo(itemBg.mas_bottom).offset(-15);
            }];
        }
    }
    return self;
}

- (void )selecteedItem:(UITapGestureRecognizer *)tapper{
    if (self.selectedIndexBlock) {
        self.selectedIndexBlock(tapper.view.tag);
    }
}

@end
