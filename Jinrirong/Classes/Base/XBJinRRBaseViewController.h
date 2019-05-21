//
//  XBJinRRBaseViewController.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRBaseViewController : UIViewController
@property (nonatomic,copy) NSString *navTitleStr;

@property(nonatomic,strong)UIButton *leftBtn;

- (void)setNavWithTitle:(NSString *)title isShowBack:(BOOL)isShowBack;
- (void )isLogin;
//获取当前视图控制器
+ (UIViewController *)presentingVC;
@end
