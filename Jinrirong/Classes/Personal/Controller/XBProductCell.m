//
//  XBProductCell.m
//  Jinrirong
//
//  Created by 少少 on 2019/1/25.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBProductCell.h"
#import "UIImageView+WebCache.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@implementation XBProductCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *ID = @"XBProductCell";
    XBProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XBProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        
        _NameLab = [[UILabel alloc] init];
        _NameLab.font = [UIFont systemFontOfSize:15];
        //        _MobileLab.textColor = GrayTextColor;
        _NameLab.frame = CGRectMake(contentX, 0, 150, 44);
        _NameLab.textAlignment = NSTextAlignmentLeft;
        //        _MobileLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_NameLab];
        
        _totalLab = [[UILabel alloc] init];
        _totalLab.font = [UIFont systemFontOfSize:15];
        _totalLab.frame = CGRectMake(ScreenWidth - 100 - 10, 0, 100, 44);
        _totalLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_totalLab];
        
        
    }
    return self;
}

- (void)setProductModel:(XBProduceModel *)productModel{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:productModel.Logurl] placeholderImage:[UIImage imageNamed:@"commisicon"]];
    _NameLab.text = [NSString stringWithFormat:@"%@",productModel.Name];
    _totalLab.text = [NSString stringWithFormat:@"%@",productModel.total];

    
}

- (void)setCommisIndex:(NSInteger)commisIndex{
    
    _numLab.text = [NSString stringWithFormat:@"%ld",(long)commisIndex];
    
}

@end
