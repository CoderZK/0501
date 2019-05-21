//
//  XBProductCell.h
//  Jinrirong
//
//  Created by 少少 on 2019/1/25.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBProduceModel.h"

@interface XBProductCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UILabel *NameLab;
@property (nonatomic, strong) UILabel *totalLab;


@property (nonatomic, strong) XBProduceModel *productModel;
@property (assign, nonatomic) NSInteger commisIndex;
@end
