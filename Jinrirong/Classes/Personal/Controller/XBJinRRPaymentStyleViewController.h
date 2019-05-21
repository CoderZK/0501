//
//  XBJinRRPaymentStyleViewController.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"

@interface XBJinRRPaymentStyleViewController : XBJinRRBaseViewController
/**
 *  是否是购买代理
 */
@property(nonatomic, assign)BOOL isAgency;
/**
 *  需要支付的金额
 */
@property(nonatomic, copy)NSString *payMoney;
/**
 *  提交列表的ID"
 */
@property(nonatomic, copy)NSString *ID;
@end
