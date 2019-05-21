//
//  XBJinRRCreditCardModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/2.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRCreditCardModel : NSObject

/**
 *  信用卡ID'
 */
@property(nonatomic, copy)NSString *ID;
/**
 *  信用卡
 */
@property(nonatomic, copy)NSString *Name;
/**
 *  信用卡简单介绍
 */
@property(nonatomic, copy)NSString *Intro;
/**
 *  信用卡logo图
 */
@property(nonatomic, copy)NSString *Logurl;
/**
 *  申请人数
 */
@property(nonatomic, copy)NSString *AppNumbs;
/**
 *  银行名称
 */
@property(nonatomic, copy)NSString *BankName;


@end
