//
//  XBJinRRCommissionAlertView.h
//  Jinrirong
//
//  Created by ahxb on 2018/10/10.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//取消按钮点击事件
typedef void(^CancelBlock)(void);
//确定按钮点击事件
typedef void(^CheckAdvertiseBlock)(NSDictionary *advertiseDic);
@interface XBJinRRCommissionAlertView : UIView
@property(nonatomic, copy)CancelBlock cancel_block;
@property(nonatomic, copy)CheckAdvertiseBlock checkAdvertise_block;

/**
 *  @param sourceInfoDic  点击X按钮
 *  @param cancelBlock 取消按钮点击事件
 *  @param CheckAdvertiseBlock   查看广告详情点击事件
 *
 *  @return LDStatmentShowTimeListView
 */
+(instancetype)CommissionAlterViewWithSourceInfoDic:(NSDictionary *)sourceInfoDic cancelBtClcik:(CancelBlock)cancelBlock
                      checkAdvertiseBlock:(CheckAdvertiseBlock )CheckAdvertiseBlock;

@end

NS_ASSUME_NONNULL_END
