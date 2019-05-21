//
//  XBJinRRBuyAgencyViewController.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"

@interface XBJinRRBuyAgencyViewController : XBJinRRBaseViewController
/**
 *  会员代理级别  1普通会员  2渠道代理  3团队经理  4城市经理
 */
@property(nonatomic, copy)NSString *agencyType;

/**
 * 角色名
 */
@property(nonatomic, copy)NSString *Rule;


@end
