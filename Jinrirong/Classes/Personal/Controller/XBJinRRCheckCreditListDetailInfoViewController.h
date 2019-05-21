//
//  XBJinRRCheckCreditListDetailInfoViewController.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/6.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"
#import "XBJinRRCredibilityModel.h"

@interface XBJinRRCheckCreditListDetailInfoViewController : XBJinRRBaseViewController
/**
 *  征信详情展示页
 */
@property(nonatomic, strong)XBJinRRCredibilityModel *tModel;


/**
 *  再次查询征信成功
 */
@property(nonatomic, copy)void (^recheckCreditInfoBlock)(void );

@end
