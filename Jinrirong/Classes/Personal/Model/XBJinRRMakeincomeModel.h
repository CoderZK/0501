//
//  XBJinRRMakeincomeModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRMakeincomeModel : NSObject
/**
 *  "推广收入"
 */
@property(nonatomic, copy)NSString *Amount;
/**
 *  "推广的会员贷款或查征信的时间"
 */
@property(nonatomic, copy)NSString *UpdateTime;
/**
 *  "推广会员的手机号码"
 */
@property(nonatomic, copy)NSString *Mobile;
/**
 *  "贷款项目的名称或被查征信人的真实姓名"
 */
@property(nonatomic, copy)NSString *Name;
@end
