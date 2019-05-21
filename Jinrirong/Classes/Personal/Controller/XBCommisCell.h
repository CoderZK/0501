//
//  XBCommisCell.h
//  Jinrirong
//
//  Created by 少少 on 2019/1/25.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBCommModel.h"

@interface XBCommisCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UILabel *totalAmountLab;
@property (nonatomic, strong) UILabel *UsernameLab;
@property (nonatomic, strong) UILabel *MobileLab;

@property (nonatomic, strong) XBCommModel *commisModel;
@property (assign, nonatomic) NSInteger commisIndex;

@end
