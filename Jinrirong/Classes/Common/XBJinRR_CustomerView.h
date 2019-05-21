//
//  XBJinRR_CustomerView.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/21.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

//取消按钮点击事件
typedef void(^CancelBlock)(void);
//确定按钮点击事件
typedef void(^SureBlock)(void);

@interface XBJinRR_CustomerView : UIView

@property(nonatomic, copy)CancelBlock cancel_block;
@property(nonatomic, copy)SureBlock sure_block;

/**
 *  @param title  标题
 *  @param content  提示内容
 *  @param yesBtnTitle  右边按钮标题
 *  @param cancelBtnTitle  左边按钮标题
 *  @param cancelBlock 取消按钮点击事件
 *  @param sureBlock   确定按钮点击事件
 *
 *  @return XBJinRR_CustomerView
 */
+(instancetype)alertViewWithTitle:(NSString *)title Content:(NSString *)content yesBtnTitle:(NSString *)yesBtnTitle cancelBtnTitle:(NSString *)cancelBtnTitle  CancelBtClcik:(CancelBlock)cancelBlock
                           sureBtClcik:(SureBlock)sureBlock;

@end
