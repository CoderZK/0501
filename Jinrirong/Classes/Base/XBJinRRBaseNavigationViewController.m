//
//  XBJinRRBaseNavigationViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseNavigationViewController.h"


@interface XBJinRRBaseNavigationViewController ()

@end

@implementation XBJinRRBaseNavigationViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(id)initWithRootViewController:(UIViewController *)rootViewController{
    
    if (self = [super initWithRootViewController:rootViewController]) {
        
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
        self.navigationBar.barTintColor = MainColor;
        self.navigationBar.tintColor = [UIColor whiteColor];
        
//        //导航渐变色
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.colors = @[(id)RGB(255, 0, 0).CGColor,(id)RGB(255, 102, 0).CGColor];
//        gradientLayer.locations = @[@0.3, @1.0];
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1.0, 0);
//
//        if (iSiPhoneX) {
//            gradientLayer.frame = CGRectMake(0, -44, SCREEN_WIDTH, 88);
//        } else {
//            gradientLayer.frame = CGRectMake(0, -20, SCREEN_WIDTH, 64);
//        }
        
        
        //        [self.navigationBar.layer addSublayer:gradientLayer];
        //        [self.navigationBar setTranslucent:YES];
        
//        if (@available(iOS 11.0, *)) {
//            [self.navigationBar.layer insertSublayer:gradientLayer atIndex:2];
//        } else {
//            //            [self.navigationBar.layer insertSublayer:gradientLayer atIndex:2];
//            self.navigationBar.barTintColor = [UIColor redColor];
//        }
        
        
        
    }
    return self;
}
#pragma mark - 动态修改状态栏跟顶部导航栏的颜色
//-(void)changeNavigationBarBackgroundColor:(UIColor *)barBackgroundColor{
//    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
//        NSArray *subviews =self.navigationController.navigationBar.subviews;
//        for (id viewObj in subviews) {
//            if (isIOS10) {
//                //iOS10,改变了状态栏的类为_UIBarBackground
//                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
//                if ([classStr isEqualToString:@"_UIBarBackground"]) {
//                    UIImageView *imageView=(UIImageView *)viewObj;
//                    imageView.hidden=YES;
//                }
//            }else{
//                //iOS9以及iOS9之前使用的是_UINavigationBarBackground
//                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
//                if ([classStr isEqualToString:@"_UINavigationBarBackground"]) {
//                    UIImageView *imageView=(UIImageView *)viewObj;
//                    imageView.hidden=YES;
//                }
//            }
//        }
//        UIImageView *imageView = [self.navigationController.navigationBar viewWithTag:111];
//        if (!imageView) {
//            imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, self.view.width, 64)];
//            imageView.tag = 111;
//            [imageView setBackgroundColor:barBackgroundColor];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.navigationController.navigationBar insertSubview:imageView atIndex:0];
//            });
//        }else{
//            [imageView setBackgroundColor:barBackgroundColor];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.navigationController.navigationBar sendSubviewToBack:imageView];
//            });
//
//        }
//
//    }
//}
//
//-(void)changeNavigationBarBackgroundColor{
//    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
//        NSArray *subviews =self.navigationBar.subviews;
//        for (id viewObj in subviews) {
//            NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
//            if ([classStr isEqualToString:@"UIView"] || [classStr isEqualToString:@"CAGradientLayer"]) {
//                UIImageView *imageView=(UIImageView *)viewObj;
//                [self.navigationBar sendSubviewToBack:imageView];
//            }
//
//        }
//
//
//
//    }
//}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imgView =  [self findHairlineImageViewUnder:self.navigationBar];
    imgView.hidden = YES;
}

//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count != 0) {
        
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    [super pushViewController:viewController animated:animated];
}

@end
