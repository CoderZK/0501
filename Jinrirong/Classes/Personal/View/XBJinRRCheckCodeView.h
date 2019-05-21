//
//  XBJinRRCheckCodeView.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/11.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRCheckCodeView : UIView


/**
 *  图片验证码正确
 */
@property(nonatomic, copy)void (^picCodeSuccessBlock)(void);

/**
 *  当前是注册还是忘记密码获取验证码
 */
@property(nonatomic, strong)NSString *messageType;

- (void)setPhone:(NSString *)phone codePic:(NSString *)codePic;
- (void)show;
- (void)hide;
@end
