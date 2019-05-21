//
//  XBJinTeamCell.m
//  Jinrirong
//
//  Created by 少少 on 2019/1/22.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBJinTeamCell.h"
#import "UIImageView+WebCache.h"
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define GrayTextColor        [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0]

@implementation XBJinTeamCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *ID = @"XBJinTeamCell";
    XBJinTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XBJinTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(10, 20, 40, 40);
//        _iconImageView.image = [UIImage imageNamed:@"teamicon"];
        [self.contentView addSubview:_iconImageView];
        
        _IDLab = [[UILabel alloc] init];
        _IDLab.font = [UIFont systemFontOfSize:16];
        CGFloat titleX = CGRectGetMaxX(_iconImageView.frame) + 10;
        _IDLab.frame = CGRectMake(titleX, 10, 200, 25);
        [self.contentView addSubview:_IDLab];
        
        CGFloat contentY = CGRectGetMaxY(_IDLab.frame) ;
        
        UIImageView *imageVnum = [[UIImageView alloc] init];
        imageVnum.frame = CGRectMake(titleX, contentY + 10 , 12, 12);
        imageVnum.image = [UIImage imageNamed:@"platimes"];
        [self.contentView addSubview:imageVnum];
        
        CGFloat numbelLabelX = CGRectGetMaxX(imageVnum.frame) + 5;
        
        _MtypeLab = [[UILabel alloc] init];
        _MtypeLab.font = [UIFont systemFontOfSize:15];
        _MtypeLab.textColor = GrayTextColor;
        _MtypeLab.frame = CGRectMake(numbelLabelX, contentY + 3, 100, 25);
        _MtypeLab.textAlignment = NSTextAlignmentLeft;
        _MtypeLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_MtypeLab];
       
        _MobileLab = [[UILabel alloc] init];
        _MobileLab.font = [UIFont systemFontOfSize:15];
        _MobileLab.frame = CGRectMake(ScreenWidth - 300 - 10, 15, 300, 25);
        _MobileLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_MobileLab];
        
        _RegTimeLab = [[UILabel alloc] init];
        _RegTimeLab.font = [UIFont systemFontOfSize:15];
//        _RegTimeLab.textColor = GrayTextColor;
        _RegTimeLab.frame = CGRectMake(ScreenWidth - 400 - 10, contentY + 5, 400, 25);
        _RegTimeLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_RegTimeLab];
        
    }
    return self;
}


- (void)setTeamModel:(XBTeamModel *)teamModel{
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:teamModel.HeadImg] placeholderImage:[UIImage imageNamed:@"teamicon"]];
    
    NSString *string=[NSString stringWithFormat:@"手机号:%@",teamModel.Mobile];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    
   
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(4, string.length - 4)];

    
    _MobileLab.attributedText = text;
    _RegTimeLab.text = [NSString stringWithFormat:@"注册时间:%@",teamModel.RegTime];
    _IDLab.text = [NSString stringWithFormat:@"工号:%@",teamModel.ID];
    _MtypeLab.text = [NSString stringWithFormat:@"%@",teamModel.Mtype];
}

@end
