//
//  XBJinRR_LoadShareCustomerModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRR_LoadShareCustomerModel : NSObject
/**
 *  匹配列表ID
 */
@property(nonatomic, copy)NSString *ID;
/**
 *  贷款人手机号码
 */
@property(nonatomic, copy)NSString *Mobile;
/**
 *  贷款金额
 */
@property(nonatomic, copy)NSString *Money;
@end
