//
//  XBJinRR_ShareBottomView.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRR_ShareBottomView : UIView
/**
 *  点击了哪个按钮
 */
@property(nonatomic, copy)void (^clickOrderIndexCallBack)(NSInteger index);
@end
