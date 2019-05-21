//
//  kkkkkk.h
//  Jinrirong
//
//  Created by zk on 2019/5/8.
//  Copyright © 2019 ahxb. All rights reserved.
//

#ifndef kkkkkk_h
#define kkkkkk_h

//基类
#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "BaseTableViewController.h"
#import "BaseTableViewHeaderFooterView.h"
#import "BaseCollectionReusableView.h"
#import "BaseCollectionViewController.h"
#import "BaseViewController+PublicMethod.h"

#import "UIView+BSExtension.h"
#import "UIImageView+WebCache.h"
#import <IQKeyboardManager.h>
#import "NSString+Size.h"
#import "UIButton+Badge.h"
#import "UIViewController+AlertShow.h"
#import "FMDBSingle.h"
#import "FYSignleTool.h"
#import "kkkkModel.h"

//状态栏
#define sstatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏
#define NaviH  44

//屏幕的长宽
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]



#endif /* kkkkkk_h */
