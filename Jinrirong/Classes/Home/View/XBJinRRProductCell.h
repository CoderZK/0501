//
//  XBJinRRProductCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRHomeHotModel.h"

@interface XBJinRRProductCell : UITableViewCell

@property (nonatomic,strong) XBJinRRHomeHotModel *hotModel;
/**
 *  申请按钮
 */
@property (nonatomic,strong) UIButton *applyBtn;
/**
 *  申请按钮点击回调
 */
@property(nonatomic, copy)void (^clickApplyBtnBlock)(void);
@end
