//
//  XBJinRRCredibilityCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/6.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRCredibilityModel.h"

@interface XBJinRRCredibilityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) XBJinRRCredibilityModel *tModel;
@end
