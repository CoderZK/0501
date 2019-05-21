//
//  XBJinRRMainAdvertisementAlertView.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>


//取消按钮点击事件
typedef void(^CancelBlock)(void);
//确定按钮点击事件
typedef void(^CheckAdvertiseBlock)(NSDictionary *advertiseDic);


@interface XBJinRRMainAdvertisementAlertView : UIView

@property(nonatomic, copy)CancelBlock cancel_block;
@property(nonatomic, copy)CheckAdvertiseBlock checkAdvertise_block;
/**
 *  @param sourceInfoDic  点击X按钮
 *  @param cancelBlock 取消按钮点击事件
 *  @param CheckAdvertiseBlock   查看广告详情点击事件
 *
 *  @return LDStatmentShowTimeListView
 */
+(instancetype)alterViewWithSourceInfoDic:(NSDictionary *)sourceInfoDic cancelBtClcik:(CancelBlock)cancelBlock
                           checkAdvertiseBlock:(CheckAdvertiseBlock )CheckAdvertiseBlock;


@end
