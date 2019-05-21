//
//  XBJinRRGetCaseViewController.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"

@interface XBJinRRGetCaseViewController : XBJinRRBaseViewController
/**
 *  提现手续费
 */
@property(nonatomic, copy)NSString *cost;
/**
 *  可结算余额
 */
@property(nonatomic, copy)NSString *balances;
/**
 *  申请成功后返回刷新
 */
@property(nonatomic, copy)void (^refreshBlock)(void );
@end
