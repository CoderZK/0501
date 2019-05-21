//
//  XBJinRRCustomerListHeaderViewCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRCustomerListHeaderViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *timeBgView;
@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;//月结产品描述

/**
 *  点击选择日期
 */
@property(nonatomic, copy)void (^clickBlock)(void);


/**
 *  确定刷新
 */
@property(nonatomic, copy)void (^refreshBlock)(void);
@end
