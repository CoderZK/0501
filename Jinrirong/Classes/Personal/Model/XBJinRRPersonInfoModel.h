//
//  XBJinRRPersonInfoModel.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/14.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRPersonInfoModel : NSObject

/**
 *  会员手机号码
 */
@property (nonatomic,copy) NSString *Mobile;
/**
 *  身份：1.学生 2.上班族 3.自主创业 4.无业
 */
@property (nonatomic,copy) NSString *Position;
/**
 *  身份证号码
 */
@property (nonatomic,copy) NSString *CardNo;
/**
 * 会员ID
 */
@property (nonatomic,copy) NSString *ID;
/**
 * 总收入
 */
@property (nonatomic,copy) NSString *Income;
/**
 * 会员代理级别  1普通会员  2渠道代理  3团队经理  4城市经理
 */
@property (nonatomic,copy) NSString *Mtype;

/**
 * 角色名
 */
@property (nonatomic,copy) NSString *Rule;

/**
 * 可结算
 */
@property (nonatomic,copy) NSString *Balance;
/**
 * 手机使用时长  1.一年以下  2.一年以上  3.两年以上   4.三年以上
 */
@property (nonatomic,copy) NSString *UseTime;
/**
 * 客服电话
 */
@property (nonatomic,copy) NSString *severTel;
/**
 * 是否有信用卡  0无  1有
 */
@property (nonatomic,copy) NSString *IsCredit;
/**
 * 头像url
 */
@property (nonatomic,copy) NSString *HeadImgVal;
/**
 * 会员真实姓名
 */
@property (nonatomic,copy) NSString *TrueName;
/**
 * 推荐码
 */
@property (nonatomic,copy) NSString *Tjcode;
/**
 * 已结算
 */
@property (nonatomic,copy) NSString *Account;




/**
 * 会员用户名
 */
@property (nonatomic,copy) NSString *UserName;
/**
 * 推荐人  （没有则是“无推荐人”）
 */
@property (nonatomic,copy) NSString *Referee;

@property (nonatomic,copy) NSString *wechatKefu;
@property (nonatomic,copy) NSString *wechatQR;

@end
