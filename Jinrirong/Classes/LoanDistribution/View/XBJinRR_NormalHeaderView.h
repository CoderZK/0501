//
//  XBJinRR_NormalHeaderView.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//  通用tableViewHeaderView

#import <UIKit/UIKit.h>

@interface XBJinRR_NormalHeaderView : UIView
/**
 *  title
 */
@property(nonatomic, strong)NSString *titleStr;
/**
 *  desStr
 */
@property(nonatomic, strong)NSString *desStr;
/**
 *  是否隐藏标题前的蓝色线
 */
@property(nonatomic, assign)BOOL isHiddenLine;


/**
 *  是否展示更多按钮
 */
@property(nonatomic, assign)BOOL isShowMoreBtn;
/**
 *  点击了更多按钮回调block
 */
@property(nonatomic, copy)void (^moreBtnClickBlock)(void );

@end
