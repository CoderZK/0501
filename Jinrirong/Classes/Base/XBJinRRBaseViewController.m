//
//  XBJinRRBaseViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"
#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"


@interface XBJinRRBaseViewController ()

@end

@implementation XBJinRRBaseViewController
//友盟统计页面点击次数
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}
- (void)setNavTitleStr:(NSString *)navTitleStr
{
    _navTitleStr = navTitleStr;
    self.navigationItem.title = navTitleStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NORMAL_BGCOLOR;
    // Do any additional setup after loading the view.
    
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

#pragma mark - 设置导航栏
- (void)setNavWithTitle:(NSString *)title isShowBack:(BOOL)isShowBack{
    if (isShowBack) {
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.frame = CGRectMake(0, 0, 15, 20);
        [self.leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 2)];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn:)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.navigationItem.title = title;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
}


#pragma mark - 导航栏点击方法
- (void)clickLeftBtn:(UIButton *)leftBtn;
{
    [self.navigationController popViewControllerAnimated:YES];
}
//获取当前视图控制器
//+ (UIViewController *)presentingVC{
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal){
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows){
//            if (tmpWin.windowLevel == UIWindowLevelNormal){
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    UIViewController *result = window.rootViewController;
//    while (result.presentedViewController) {
//        result = result.presentedViewController;
//    }
//    if ([result isKindOfClass:[XBJinRRBaseTabbarViewController class]]) {
//        result = [(XBJinRRBaseTabbarViewController *)result selectedViewController];
//    }
//    if ([result isKindOfClass:[UINavigationController class]]) {
//        result = [(UINavigationController *)result topViewController];
//    }
//    return result;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
