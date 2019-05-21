//
//  XBJinRRPromotdataModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRPromotdataModel : NSObject
/**
 *  "订单编号"
 */
@property(nonatomic, copy)NSString *OrderSn;
/**
 *  "手机号码"
 */
@property(nonatomic, copy)NSString *Mobile;
/**
 *  "提交时间"
 */
@property(nonatomic, copy)NSString *Addtime;
/**
 *  "佣金模式:1按比例 2按金额"
 */
@property(nonatomic, copy)NSString *Yjtype;
/**
 *  "奖金点数(单位%)"
 */
@property(nonatomic, copy)NSString *BonusRate;
/**
 *  "佣金金额(元)"
 */
@property(nonatomic, copy)NSString *Ymoney;
/**
 *  "是否与放款记录匹配:0未匹配(未达标) 1匹配上了(达标了)"
 */
@property(nonatomic, copy)NSString *Status;
/**
 *  "推荐奖金(获得的金额)"
 */
@property(nonatomic, copy)NSString *Bonus;
/**
 *  "项目名称"
 */
@property(nonatomic, copy)NSString *goodname;
/**
 *  "logo地址"
 */
@property(nonatomic, copy)NSString *Logurl;
/**
 *  "结算周期"
 */
@property(nonatomic, copy)NSString *Settletime;

@property(nonatomic, copy)NSString *applyBonus;
@end
