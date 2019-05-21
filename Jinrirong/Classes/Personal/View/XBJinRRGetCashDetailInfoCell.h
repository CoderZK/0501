//
//  XBJinRRGetCashDetailInfoCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRWalletInfoModel.h"

@interface XBJinRRGetCashDetailInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuELabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/**
 *  提现数据模型
 */
@property(nonatomic, strong)XBJinRRWalletInfoModel *tModel;
@end
