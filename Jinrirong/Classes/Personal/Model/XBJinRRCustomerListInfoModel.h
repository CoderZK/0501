//
//  XBJinRRCustomerListInfoModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRCustomerListInfoModel : NSObject
/**
 *  "产品ID"
 */
@property(nonatomic, copy)NSString *ID;

/**
 *  "产品类别   1平台网贷    2信用卡贷"
 */
@property(nonatomic, copy)NSString *Itype;
/**
 *  "产品名称"
 */
@property(nonatomic, copy)NSString *Name;
/**
 *  "产品编码"
 */
@property(nonatomic, copy)NSString *GoodsNo;
/**
 *  "该产品申请人数"
 */
@property(nonatomic, copy)NSString *applycount;
/**
 *  "放款成功人数"
 */
@property(nonatomic, copy)NSString *fksuccess;
/**
 *  "奖金"
 */
@property(nonatomic, copy)NSString *BonusAll;
@end
