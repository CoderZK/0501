//
//  ShoppingMall
//
//  Created by ahxb on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPopupItem.h"
@interface UIView (Category)
//把View加在Window上
- (void) addToWindow;

@end

@interface UIView (Screenshot)

//View截图
- (UIImage*) screenshot;

//ScrollView截图 contentOffset
- (UIImage*) screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;

//View按Rect截图
- (UIImage*) screenshotInFrame:(CGRect)frame;

//整个view转成图片
- (UIImage*) convertToImage;
@end

@interface UIView (Animation)

//左右抖动动画
- (void) shakeAnimation;

//旋转180度
- (void) trans180DegreeAnimation;
- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
- (void)doBorderCornerRadius:(CGFloat)cornerRadius;

//版本更新弹框 （强制）
-(void)alertNoBackView:(NSString*)title prompt:(NSString *)prompt okName:(NSString *)okName  withBlock:(MMPopupItemHandler)handler;
//版本更新弹框 （非强制）
-(void)alertView:(NSString*)title prompt:(NSString *)prompt cancelName:(NSString *)cancelName okName:(NSString *)okName withBlock:(MMPopupItemHandler)handler;
@end

