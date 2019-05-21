//
//  XBJinRRWalletInfoModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRWalletInfoModel : NSObject
/**
 *  "提现列表ID"
 */
@property(nonatomic, copy)NSString *ID;
/**
 *  "提现金额"
 */
@property(nonatomic, copy)NSString *Money;
/**
 *  "当前余额"
 */
@property(nonatomic, copy)NSString *CurlMoney;
/**
 *  "提现时间"
 */
@property(nonatomic, copy)NSString *AddTime;
@end
