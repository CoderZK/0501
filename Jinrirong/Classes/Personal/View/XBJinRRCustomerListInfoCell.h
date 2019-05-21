//
//  XBJinRRCustomerListInfoCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRCustomerListInfoModel.h"

@interface XBJinRRCustomerListInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
/**
 *  奖金
 */
@property (weak, nonatomic) IBOutlet UILabel *bounceLabel;
/**
 *  客户列表模型
 */
@property(nonatomic, strong)XBJinRRCustomerListInfoModel *tModel;

@end
