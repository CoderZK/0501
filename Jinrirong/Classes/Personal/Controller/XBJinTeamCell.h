//
//  XBJinTeamCell.h
//  Jinrirong
//
//  Created by 少少 on 2019/1/22.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTeamModel.h"

@interface XBJinTeamCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *MobileLab;
@property (nonatomic, strong) UILabel *RegTimeLab;
@property (nonatomic, strong) UILabel *IDLab;
@property (nonatomic, strong) UILabel *MtypeLab;


@property (nonatomic, strong) XBTeamModel *teamModel;

@end
