//
//  LF_ShowVersionView.h
//  FullAndFresh
//
//  Created by 刘飞 on 2018/5/15.
//  Copyright © 2018年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

//取消按钮点击事件
typedef void(^cancelBlock)(void);

//确定按钮点击事件
typedef void(^sureBlock)(void);

@interface LF_ShowVersionView : UIView

@property(nonatomic,copy)cancelBlock cancel_block;
@property(nonatomic,copy)sureBlock sure_block;
/**
 *  @param title       标题
 *  @param content     内容
 *  @param cancel      取消按钮内容
 *  @param sure        确定按钮内容
 *  @param cancelBlock 取消按钮点击事件
 *  @param sureBlock   确定按钮点击事件
 *
 *  @return SZKAlterView
 */
+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                           cancel:(NSString *)cancel
                             sure:(NSString *)sure
                    cancelBtClcik:(cancelBlock)cancelBlock
                      sureBtClcik:(sureBlock)sureBlock;

@end
