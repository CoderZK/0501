//
//  XBJinRRMyPurseTopCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRMyPurseTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *getcashLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;//标签
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;

/**
 *  点击了提现按钮
 */
@property(nonatomic, copy)void (^getWalletClickBlock)(void);

/**
 *  点击了总收入按钮
 */
@property(nonatomic, copy)void (^chechMoreDetailClickBlock)(void);

@end
