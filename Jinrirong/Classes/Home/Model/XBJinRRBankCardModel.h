//
//  XBJinRRBankCardModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/2.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRBankCardModel : NSObject

/**
 *  银行卡ID
 */
@property(nonatomic, copy)NSString *ID;
/**
 *  银行名称
 */
@property(nonatomic, copy)NSString *BankName;
/**
 *  log图
 */
@property(nonatomic, copy)NSString *Logurl;
/**
 *  简单介绍
 */
@property(nonatomic, copy)NSString *Intro;
/**
 *  漂浮文字
 */
@property(nonatomic, copy)NSString *Desc;
@end
