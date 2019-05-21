//
//  kkkkTabBarVC.m
//  Jinrirong
//
//  Created by zk on 2019/5/8.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import "kkkkTabBarVC.h"
#import "XBJinRRBaseTabbarViewController.h"
#import "XBJinRRBaseNavigationViewController.h"
#import "XBJinRRBaseViewController.h"
#import "XBJinRRHomeViewController.h"
#import "XBJinRRLookLoanViewController.h"
#import "XBJinRR_NewsViewController.h"
//#import "XBJinRRLoanDistributionViewController.h"
#import "XBJinRR_LoadDistributionViewController.h"
#import "XBJinRRPersonalViewController.h"
#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"
#import "kkkkPersonVC.h"

#import "kkkkHomeVC.h"
#import "kkkkMineHaiBaoVC.h"
#import "kkkkNewsVC.h"

@interface kkkkTabBarVC ()<UITabBarControllerDelegate>

@end

@implementation kkkkTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setSubController];
}
- (void)setSubController{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    //    NSArray *VCNameArr = @[@"HomePageViewController",@"CouponViewController",@"ClassifySpecifyViewController",@"ScoringShopViewController",@"MineViewController"];//chb修改的
    NSArray *VCNameArr = @[@"kkkkHomeVC",@"kkkkNewsVC",@"kkkkMineHaiBaoVC",@"kkkkPersonVC"];//chb修改的
    
    NSMutableArray *VCNavArr = [NSMutableArray array];
    
    XBJinRRBaseNavigationViewController *VCNav = nil;
    
    for (NSString *VCName in VCNameArr) {
        
        UIViewController *VC = [[NSClassFromString(VCName) alloc] init];
        
        
        VC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:nil];
        VCNav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:VC];
        //        [WGTemporaryTool standardUserUtil].baseNav =VCNav;
        [VCNavArr addObject:VCNav];
    }
    
    [self setViewControllers:VCNavArr];
    
    //    NSArray *tabBarTitleArr  = @[@"首页",@"分类",@"优惠券",@"积分商城",@"我的"];
    //    NSArray *tabBarImgArr = @[@"icon_nav1",@"icon_nav2",@"icon_nav3",@"icon_nav4",@"icon_nav5"];
    NSArray *tabBarTitleArr  = @[@"首页",@"消息",@"推广",@"我的"];
    NSArray *tabBarImgArr = @[@"home",@"rrnews",@"distribution",@"my"];
    NSArray *tabBarItems = self.tabBar.items;
    
    for (int i = 0; i < tabBarItems.count; i++) {
        
        UITabBarItem *item = tabBarItems[i];
        item.title = tabBarTitleArr[i];
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@selected",tabBarImgArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",tabBarImgArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        //        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:kAppThemeColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
        //
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
        self.tabBar.tintColor = MainColor;
    }
}


- (void )isLogin{
    NSString *token = [UDefault getObject:TOKEN];
    if (token == nil || [token isEqualToString:@""]) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (/*[viewController.tabBarItem.title isEqualToString:@"分销"]||*/
        [viewController.tabBarItem.title isEqualToString:@"我的"]) {
        NSString *token = [UDefault getObject:TOKEN];
        if (token == nil || [token isEqualToString:@""]) {
            [self isLogin];
            return NO;
        }
    }
    
    return YES;
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //    if (tabBarController.selectedIndex == 2 || tabBarController.selectedIndex == 3) {
    //        [self isLogin];
    //    }
}

@end

