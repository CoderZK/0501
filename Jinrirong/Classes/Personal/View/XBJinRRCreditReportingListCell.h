//
//  XBJinRRCreditReportingListCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRMakeincomeModel.h"

@interface XBJinRRCreditReportingListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic)XBJinRRMakeincomeModel *tModel;
@end
