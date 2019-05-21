//
//  XBJinRRCredibilityModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/6.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRCredibilityModel : NSObject
/**
 *  "征信列表ID"
 */
@property(nonatomic, copy)NSString *ID;
/**
 *  "真实姓名"
 */
@property(nonatomic, copy)NSString *TrueName;
/**
 *  "手机号码"
 */
@property(nonatomic, copy)NSString *Mobile;
/**
 *  查询时间
 */
@property(nonatomic, copy)NSString *Checktime;
/**
 *  "查询状态"   1.待付款   2已付款   3查询失败  4已查询    5已取消
 */
@property(nonatomic, copy)NSString *Status;
/**
 *  订单金额
 */
@property(nonatomic, copy)NSString *OrderAmount;
@end
