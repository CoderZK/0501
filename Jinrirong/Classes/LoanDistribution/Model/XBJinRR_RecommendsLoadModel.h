//
//  XBJinRR_RecommendsLoadModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/28.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRR_RecommendsLoadModel : NSObject


/**
 *  产品ID（信用卡ID或是网贷平台ID）
 */
@property(nonatomic, strong)NSString *ID;
/**
 *  产品名称（信用卡名称或是网贷平台名称）',
 */
@property(nonatomic, strong)NSString *Name;
/**
 *  '产品logo',
 */
@property(nonatomic, strong)NSString *Logurl;
/**
 *  是否推荐'
 */
@property(nonatomic, strong)NSString *IsRec;
/**
 *  '佣金模式:1按比例 2按金额'(Yjtype为2用这个,单:元)
 */
@property(nonatomic, strong)NSString *Yjtype;
/**
 *  '根据会员类型展示的返点数',(Yjtype为1用这个,单位:个点)
 */
@property(nonatomic, strong)NSString *BonusRate;
/**
 *  :'佣金金额'
 */
@property(nonatomic, strong)NSString *Ymoney;
/**
 *  :'佣金金额'S
 */
@property(nonatomic, strong)NSString *Smoney;
/**
 *  描述
 */
@property(nonatomic, strong)NSString *Intro;
/**
 *  申请人数
 */
@property(nonatomic, strong)NSString *AppNumbs;
/**
 *  分类：1大额、2小额
 */
@property(nonatomic, strong)NSString *fenlei;







@end
