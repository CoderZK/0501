//
//  LDImageAndTitleView.h
//  BaseFrame
//
//  Created by Miles on 2017/9/20.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDImageAndTitleView : UIView
@property (nonatomic,strong)UILabel *titleLB;
@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,copy)void(^viewClickCallBack)(UIImageView *imageView,UILabel *titleLB,LDImageAndTitleView *titleView);
@end
