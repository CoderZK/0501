//
//  XBJinRRDrawSuccessViewController.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"

@interface XBJinRRDrawSuccessViewController : XBJinRRBaseViewController
/**
 *  是否是银行卡
 */
@property(nonatomic, assign)BOOL isBankCard;
/**
 *  账号
 */
@property(nonatomic, copy)NSString *account;
/**
 *  金额
 */
@property(nonatomic, copy)NSString *money;
/**
 *  申请成功后返回刷新
 */
@property(nonatomic, copy)void (^refreshBlock)(void );
@end
