//
//  XBCommisCell.m
//  Jinrirong
//
//  Created by 少少 on 2019/1/25.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBCommisCell.h"
#import "UIImageView+WebCache.h"
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@implementation XBCommisCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *ID = @"XBCommisCell";
    XBCommisCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XBCommisCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _numLab = [[UILabel alloc] init];
        _numLab.font = [UIFont systemFontOfSize:16];
        _numLab.frame = CGRectMake(0, 0, 30, 44);
        _numLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_numLab];
        
    
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(30, 12, 20, 20);
//        _iconImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_iconImageView];
        
        CGFloat contentX = CGRectGetMaxX(_iconImageView.frame)+ 10;
        
        _MobileLab = [[UILabel alloc] init];
        _MobileLab.font = [UIFont systemFontOfSize:15];
//        _MobileLab.textColor = GrayTextColor;
        _MobileLab.frame = CGRectMake(contentX, 0, 150, 44);
        _MobileLab.textAlignment = NSTextAlignmentLeft;
//        _MobileLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_MobileLab];
        
        _totalAmountLab = [[UILabel alloc] init];
        _totalAmountLab.font = [UIFont systemFontOfSize:15];
        _totalAmountLab.frame = CGRectMake(ScreenWidth - 100 - 10, 0, 100, 44);
        _totalAmountLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_totalAmountLab];

        
    }
    return self;
}

- (void)setCommisModel:(XBCommModel *)commisModel{
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:commisModel.HeadImg] placeholderImage:[UIImage imageNamed:@"commisicon"]];
    _MobileLab.text = [NSString stringWithFormat:@"%@",commisModel.Mobile];
    _totalAmountLab.text = [NSString stringWithFormat:@"¥%@",commisModel.totalAmount];
//    _numLab.text = [NSString stringWithFormat:@"%@",]

}

- (void)setCommisIndex:(NSInteger)commisIndex{
    
    _numLab.text = [NSString stringWithFormat:@"%ld",(long)commisIndex];

}

@end
