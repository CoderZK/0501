//
//  XBJinRR_LoadDistributionViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/25.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_LoadDistributionViewController.h"

#import "XBJinRR_AgentViewController.h"
#import "XBJinRR_CreditCardViewController.h"
#import "XBJinRR_LoadViewController.h"
#import "XBJinRRHomeBannerModel.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"

@interface XBJinRR_LoadDistributionViewController ()<SDCycleScrollViewDelegate>
{
    UIImageView *iconImageView;
}
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)NSArray * titleArray;
/**
 *  bannerArray
 */
@property(nonatomic, strong)NSMutableArray *bannerArray;
@end

@implementation XBJinRR_LoadDistributionViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void )click{
    NSDictionary *dic = [Dialog Instance].YouTanDic;
    if (!isEmptyStr(dic[@"YtanUrl"])) {
        XBJinRRWebViewController *webVc = [XBJinRRWebViewController new];
        [webVc setUrl:[NSString stringWithFormat:@"%@",dic[@"YtanUrl"]] webType:WebTypeOther];
        webVc.titleString = @"";
        [self.navigationController pushViewController:webVc animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    
    self.titleArray = @[@"大额贷款",@"小额贷款",@"信用卡产品",@"一键代理"];
    
    
    NSDictionary *dict1 = [Dialog Instance].YouTanDic;
    if (!isEmptyStr(dict1[@"YtanImg"])) {
        iconImageView = [ViewCreate createImageViewFrame:CGRectMake(SCREEN_WIDTH-SIZE(80), SCREEN_HEIGHT-SIZE(180), SIZE(60), SIZE(60)*1.5) image:@"suspend_icon1"];
        iconImageView.userInteractionEnabled = YES;
        [self.view addSubview:iconImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [iconImageView addGestureRecognizer:tap];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:dict1[@"YtanImg"]]];
    }

    [self initTabbar];
    
    [self getBanner];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark -- 获取
- (void )getBanner{
    
    
    WS(wSelf);
    [XBJinRRNetworkApiManager getAdsWithAid:@"5" num:@"10" block:^(id data) {
        
        if ([[NSString stringWithFormat:@"%@",data[@"result"]] isEqualToString:@"1"]) {
            NSArray *bannerArray = [XBJinRRHomeBannerModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            wSelf.bannerArray = bannerArray.mutableCopy;
            
        }else{
            
        }
    } fail:^(NSError *errorString) {
        
    }];
    
}


-(void)setBannerArray:(NSMutableArray *)bannerArray{
    _bannerArray = bannerArray;
    NSMutableArray *bannerArrayM = [NSMutableArray new];
    for (int i=0; i<_bannerArray.count; i++) {
        XBJinRRHomeBannerModel *model = _bannerArray[i];
        [bannerArrayM addObject:model.Pic];
    }
    self.cycleScrollView.imageURLStringsGroup = bannerArrayM;
}




#pragma mark - 头部轮播

-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"cycleScrollView_icon"]];
    }
    return _cycleScrollView;
}


//SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    XBJinRRHomeBannerModel *model = _bannerArray[index];
    if ([model.Url containsString:@"http"]) {
        //防止链接不正确
        XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
        vc.titleString = model.Name;
        [vc setUrl:model.Url webType:WebTypeOther];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
//        [Dialog toastCenter:@"链接不正确"];
    }
    
    
    
}

//设置可滑动的选块
- (void )initTabbar{
    self.interceptRightSlideGuetureInFirstPage = YES;
    
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = MainColor;
    self.tabBar.itemTitleFont = FONT(17);
    self.tabBar.itemTitleSelectedFont = FONT(17);
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = MainColor;
    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(43, 10, 0, 10) tapSwitchAnimated:NO];
    self.loadViewOfChildContollerWhileAppear = YES;
   
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat bottom = 0;
    if (screenSize.height == 812) {
        bottom += 34;
    }
    if ([self.parentViewController isKindOfClass:[YPTabBarController class]]) {
        bottom += 50;
    }
    
    
    [self setHeaderView:self.cycleScrollView
            needStretch:YES
           headerHeight:180
           tabBarHeight:44
      contentViewHeight:screenSize.height - 180 - 44 - bottom
  tabBarStopOnTopHeight:StatusBarHeight];
    [self setContentScrollEnabled:NO tapSwitchAnimated:NO];
    [self initViewControllers];

}

-(void)didSelectViewControllerAtIndex:(NSUInteger)index{
    if (index==3) {
        
        if (isEmptyStr([UDefault getObject:TOKEN])) {
            self.tabBar.selectedItemIndex = 0;
            XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
            XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        WS(bself);
        XBJinRR_AgentViewController *vc = (XBJinRR_AgentViewController *)self.viewControllers[index];
        vc.changeSelectedIndx = ^(NSInteger index) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                bself.tabBar.selectedItemIndex = 0;
            });
        };
        vc.waymode = @"fenxiao";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


//设置子控制器
- (void)initViewControllers {
    NSMutableArray * vcArray = [[NSMutableArray alloc]init];
    
    XBJinRR_LoadViewController *controller0 = [[XBJinRR_LoadViewController alloc] init];
    controller0.yp_tabItemTitle = self.titleArray[1];
    
    [vcArray addObject:controller0];
    
    XBJinRR_LoadViewController *controller1 = [[XBJinRR_LoadViewController alloc] init];
    controller1.yp_tabItemTitle = self.titleArray[0];
    controller1.isBig = YES;
    [vcArray addObject:controller1];
    
    XBJinRR_CreditCardViewController*controller2 = [[XBJinRR_CreditCardViewController alloc] init];
    controller2.yp_tabItemTitle = self.titleArray[2];
    [vcArray addObject:controller2];
    
    XBJinRR_AgentViewController *controller3 = [[XBJinRR_AgentViewController alloc] init];
    controller3.waymode = @"fenxiao";
    controller3.yp_tabItemTitle = self.titleArray[3];
    [vcArray addObject:controller3];
    
    
    self.viewControllers = [NSMutableArray arrayWithArray:vcArray];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
