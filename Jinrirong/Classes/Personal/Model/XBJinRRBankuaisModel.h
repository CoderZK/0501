//
//  XBJinRRBankuaisModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/6.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRBankuaisModel : NSObject
/**
 *  "板块的主键id"
 */
@property(nonatomic, copy)NSString *ID;
/**
 *  "名称"
 */
@property(nonatomic, copy)NSString *Name;
/**
 *  "简单描述"
 */
@property(nonatomic, copy)NSString *Intro;
/**
 *  背景图片
 */
@property(nonatomic, copy)NSString *Backurl;
@end
