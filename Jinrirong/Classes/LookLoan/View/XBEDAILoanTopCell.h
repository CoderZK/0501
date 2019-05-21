//
//  XBEDAILoanTopCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/7/2.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRHomeHotModel.h"

@interface XBEDAILoanTopCell : UITableViewCell

@property (nonatomic,strong) XBJinRRHomeHotModel *hotModel;
/**
 *  申请按钮
 */
@property (nonatomic,strong) UIButton *applyBtn;
/**
 *  通过率
 */
@property(nonatomic, strong)NSString *PassRate;
/**
 *  申请按钮点击回调
 */
@property(nonatomic, copy)void (^clickApplyBtnBlock)(void);
@end
