//
//  XBJinRRSourceOfIncomeViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//  收入来源 --- 推广收入|会员收入

#import "XBJinRRSourceOfIncomeViewController.h"

#import "XBJinRRIncomeFromRecommendViewController.h"
#import "XBJinRRIncomeFromVipViewController.h"

@interface XBJinRRSourceOfIncomeViewController ()
/**
 *  推广收入
 */
@property(nonatomic, strong)XBJinRRIncomeFromRecommendViewController *recommendViewController;
/**
 *  会员收入
 */
@property(nonatomic, strong)XBJinRRIncomeFromVipViewController *vipViewController;

/**
 * 记录当前segmentedControl的下标
 */
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) XBJinRRBaseViewController *currentVC;

@end

@implementation XBJinRRSourceOfIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:@"" isShowBack:YES];
    [self createSegmentedControl];
}








- (void) createSegmentedControl {
    
    self.recommendViewController = [XBJinRRIncomeFromRecommendViewController new];
    self.recommendViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT);
    [self addChildViewController:self.recommendViewController];
    
    self.vipViewController = [XBJinRRIncomeFromVipViewController new];
    self.vipViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT);
    [self addChildViewController:self.vipViewController];
    
    
    //设置默认控制器为fristVc
    self.currentVC = self.recommendViewController;
    [self.view addSubview:self.recommendViewController.view];
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"推广收入", @"会员收入", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    
    /*
     这个是设置按下按钮时的颜色
     */
    segmentedControl.tintColor = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    
    
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:FONT(15),NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:MainColor forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentedControl;
    
    segmentedControl.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 30);
    
    segmentedControl.layer.cornerRadius = 15;
    segmentedControl.layer.masksToBounds = YES;
    segmentedControl.layer.borderWidth = 1.0;
    segmentedControl.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
}

- (void) doSomethingInSegment: (UISegmentedControl *) segmented {
    switch (segmented.selectedSegmentIndex) {
        case 0:
            [self replaceFromOldViewController:self.vipViewController toNewViewController:self.recommendViewController];
            _index = 0;
            
            break;
        case 1:
            [self replaceFromOldViewController:self.recommendViewController toNewViewController:self.vipViewController];
            _index = 1;
            break;
        default:
            break;
    }
}

/**
 *  实现控制器的切换
 *
 *  @param oldVc 当前控制器
 *  @param newVc 要切换到的控制器
 */
- (void)replaceFromOldViewController:(XBJinRRBaseViewController *)oldVc toNewViewController:(XBJinRRBaseViewController *)newVc{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController    当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options              动画效果(渐变,从下往上等等,具体查看API)UIViewAnimationOptionTransitionCrossDissolve
     *  animations            转换过程中得动画
     *  completion            转换完成
     */
    [self addChildViewController:newVc];
    
    [self transitionFromViewController:oldVc toViewController:newVc duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newVc didMoveToParentViewController:self];
            [oldVc willMoveToParentViewController:nil];
            [oldVc removeFromParentViewController];
            self.currentVC = newVc;
        }else{
            self.currentVC = oldVc;
        }
    }];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
