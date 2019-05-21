//
//  XBJinRRHomeViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRHomeViewController.h"
#import "XBJinRRHomeBannerModel.h"
#import "XBJinRRHomBannerCell.h"
#import "XBJinRRMsgCell.h"
#import "XBJinRRHomeNoticeModel.h"
#import "XBJinRRNavCell.h"
#import "XBJinRRHomeNavModel.h"
#import "XBJinRRMenuCell.h"
#import "XBJinRRIntelligentRecommendationCell.h"
#import "XBJinRRHomeRecommandModel.h"
#import "XBJinRRHomeHotModel.h"
#import "XBJinRRProductCell.h"
#import "XBJinRRMyMessageMainViewController.h"
#import "XBJinRR_LookLoanDetailViewController.h"
#import "XBJinRR_AgentViewController.h"
#import "XBJinRRCheckCreditViewController.h"
#import "XBJinRRCreditCardCenterViewController.h"
#import "XBJinRRSystemNotificationViewController.h"
#import "XBJinRRMainAdvertisementAlertView.h"

#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"


#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
@interface XBJinRRHomeViewController ()<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate>
{
    UIButton *msgBtn;
    UIImageView *iconImageView;
    NSString *_latitude;
    NSString *_longitude;
    NSString * _DetailedAddress;
    BOOL _isfrist;
}
@property (nonatomic,strong) NSArray *hotDataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *bannerArray;
@property (nonatomic,strong) NSArray *noticeArray;
@property (nonatomic,strong) NSArray *navArray;
@property (nonatomic,strong) NSArray *recommandArray;
@property (nonatomic,strong) UILabel *cityNameLabel;


@property (nonatomic ,strong)CLLocationManager * lm;

@property (nonatomic ,strong)MKMapView *mapView;

@end

@implementation XBJinRRHomeViewController

static NSString *XBJinRRHomBannerCellID = @"XBJinRRHomBannerCellID";
static NSString *XBJinRRMsgCellID = @"XBJinRRMsgCellID";
static NSString *XBJinRRNavCellID = @"XBJinRRNavCellID";
static NSString *XBJinRRMenuCellID = @"XBJinRRMenuCellID";
static NSString *XBJinRRIntelligentRecommendationCellID = @"XBJinRRIntelligentRecommendationCellID";
static NSString *XBJinRRHotDataNameCellID = @"XBJinRRHotDataNameCellID";
static NSString *XBJinRRProductCellID = @"XBJinRRProductCellID";

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
    [self createUI];
    
    iconImageView = [ViewCreate createImageViewFrame:CGRectMake(SCREEN_WIDTH-SIZE(80), SCREEN_HEIGHT-SIZE(180), SIZE(60), SIZE(60)*1.5) image:@"suspend_icon1"];
    iconImageView.userInteractionEnabled = YES;
    iconImageView.hidden = YES;
    [self.view addSubview:iconImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [iconImageView addGestureRecognizer:tap];
    
    [self addRefresh];
    
    
    
    [self City];
    
}

- (void)City{
    
    
    
    //没用高德地图，所以不用改key值！！！
    _latitude = @"";
    _longitude = @"";
    _DetailedAddress = @"";
    _isfrist = YES;
    
    if ([CLLocationManager locationServicesEnabled]) {
        if (nil == _lm) {
            _lm = [[CLLocationManager alloc]init];
            _lm.delegate = self;
            //设置定位精度
            _lm.desiredAccuracy = kCLLocationAccuracyBest;
            //设置位置更新的最小距离
            _lm.distanceFilter = 100.f;
            if (IS_IOS8) {//ios8之后点版本需要使用下面的方法才能定位。使用一个即可。
                //[_lm requestAlwaysAuthorization];
                [_lm requestWhenInUseAuthorization];
            }
        }
    }else{
        NSLog(@"定位服务不可利用");
    }
    [_lm startUpdatingLocation];
    
    
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH ,SCREEN_HEIGHT)];
    //设置地图的显示风格
    //    self.mapView.mapType = MKMapTypeStandard;
    //    //设置地图可缩放
    //    self.mapView.zoomEnabled = YES;
    //    //设置地图可滚动
    //    self.mapView.scrollEnabled = YES;
    //    //设置地图可旋转
    //    self.mapView.rotateEnabled = YES;
    ////    设置显示用户显示位置
    //    self.mapView.showsUserLocation = YES;
    //为MKMapView设置delegate
    self.mapView.delegate = self;
    self.mapView.hidden = YES;
    self.mapView.userTrackingMode=MKUserTrackingModeFollow;
    NSLog(@"用户当前是否位于地图中：%d",self.mapView.userLocationVisible);
    
    
    
    [self.view addSubview:self.mapView];
    
    
    
    
}


- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    
    NSLog(@"XBEDAINormalQuestionCell ================%@",error);
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocationCoordinate2D coord = [userLocation coordinate];
    NSLog(@"纬度:%f,经度:%f",coord.latitude,coord.longitude);
    _longitude = [NSString stringWithFormat:@"%f",coord.longitude];
    _latitude = [NSString stringWithFormat:@"%f",coord.latitude];;
    
    
    
    if (_isfrist == YES) {
        _isfrist = NO;
        
        WS(weakSelf);
        [self reverseGeocoder];
        
    }else{
        
    }
    
    
    
    
}

/**
 地理反编码
 */
- (void)reverseGeocoder{
    //创建地理编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    //经度
    NSString *longitude = _longitude;
    //纬度
    NSString *latitude = _latitude;
    
    
    //创建位置
    CLLocation *location=[[CLLocation alloc]initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    
    WS(weakSelf);
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        NSLog(@"地图\n===%@",[NSThread currentThread]);

        
        //判断是否有错误或者placemarks是否为空
        if (error !=nil || placemarks.count==0) {
            NSLog(@"%@",error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            //详细地址
            NSString *addressStr = placemark.name;
            NSLog(@"详细地址1：%@",addressStr);
            NSLog(@"详细地址2：%@",placemark.addressDictionary);
            NSLog(@"详细地址3：%@",placemark.locality);
            
            NSDictionary * dic = placemark.addressDictionary;
            NSArray * arr = dic[@"FormattedAddressLines"];
            
            self->_DetailedAddress = [NSString stringWithFormat:@"%@",arr[0]];
            
            //获取外网ip
            
            NSError *error;
            NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
            NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
            
            //判断返回字符串是否为所需数据
            if ([ip hasPrefix:@"var returnCitySN = "]) {
                //对字符串进行处理，然后进行json解析
                //删除字符串多余字符串
                NSRange range = NSMakeRange(0, 19);
                [ip deleteCharactersInRange:range];
                NSString * nowIp =[ip substringToIndex:ip.length-1];
                //将字符串转换成二进制进行Json解析
                NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dict);
                
                NSString * ipstr = [NSString stringWithFormat:@"%@",dict[@"cip"]];
                
                [XBJinRRNetworkApiManager center_member_modifyAddWithip:ipstr city:self->_DetailedAddress Block:^(id data) {
                    NSLog(@"sasasas");
                } fail:^(NSError *errorString) {
                    NSLog(@"%@",errorString);
                }];
            }

        }
        
    }];
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark -- 获取网络数据
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself requestData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    [self tanimgBlock];
}
//获取首页弹框视图链接数据
- (void )tanimgBlock{
    WS(bself);
    [XBJinRRNetworkApiManager tanimgBlock:^(id data) {
        
        NSLog(@"弹框\n===%@",[NSThread currentThread]);
        
        if (rusultIsCorrect) {
            NSDictionary *infoDic = data[@"data"];
            NSDictionary *dict = infoDic[@"BigTan"];
            if (!isEmptyStr(dict[@"TanImg"])) {
                [XBJinRRMainAdvertisementAlertView alterViewWithSourceInfoDic:dict cancelBtClcik:^{
                } checkAdvertiseBlock:^(NSDictionary *advertiseDic) {
                    if (!isEmptyStr(advertiseDic[@"TanUrl"])) {
                        XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
                        [vc setUrl:advertiseDic[@"TanUrl"] webType:WebTypeOther];
                        vc.titleString = @"系统公告";
                        [bself.navigationController pushViewController:vc animated:YES];
                    }
                }];
            }
            
            NSDictionary *dict1 = infoDic[@"YouTan"];
            [Dialog Instance].YouTanDic = dict1;
            if (!isEmptyStr(dict1[@"YtanImg"])) {
                self->iconImageView.hidden = NO;
                [self->iconImageView sd_setImageWithURL:[NSURL URLWithString:dict1[@"YtanImg"]]];
            }
            
        }
    } fail:^(NSError *errorString) {
        
    }];
}



- (void)requestData
{
    
    
    [self isnoreadmsg:^(BOOL isSuccess) {
         NSLog(@"=======\n====\n===%@",[NSThread currentThread]);
    }];

    [self getAdsWithAid:^(BOOL isSuccess) {}];

    [self getNoticeWithBlock:^(BOOL isSuccess) {}];

    [self getCateWithBlock:^(BOOL isSuccess) {}];
    [self getItemsWithIsrec:^(BOOL isSuccess) {}];
    [self getItemsWithIsrect:^(BOOL isSuccess) {}];
    
    
//    WS(bself);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    [self isnoreadmsg:^(BOOL isSuccess) {
//        if (isSuccess) {
//
//            NSLog(@"=======\n====\n===%@",[NSThread currentThread]);
//
//
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getAdsWithAid:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getNoticeWithBlock:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getCateWithBlock:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getItemsWithIsrec:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getItemsWithIsrect:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        [bself.tableView.mj_header endRefreshing];
//        [bself.tableView.mj_footer endRefreshing];
//        [bself.tableView reloadData];
//    });
}

//查看是否有未读消息
- (void )isnoreadmsg:(void(^)(BOOL isSuccess))callBack{
    WS(wSelf);
    [XBJinRRNetworkApiManager isnoreadmsgBlock:^(id data) {
        callBack(YES);
        if (rusultIsCorrect) {
            NSDictionary *dic = data[@"data"];
            if ([[NSString stringWithFormat:@"%@",dic[@"xtmsg"]] isEqualToString:@"0"]&&[[NSString stringWithFormat:@"%@",dic[@"tzmsg"]] isEqualToString:@"0"]) {
                [self->msgBtn setImage:[UIImage imageNamed:@"personal_news"] forState:UIControlStateNormal];
            }else{
                [self->msgBtn setImage:[UIImage imageNamed:@"personal_newsclick"] forState:UIControlStateNormal];
            }
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
        [wSelf.tableView.mj_header endRefreshing];
    }];
}

//获取banner
-(void)getAdsWithAid:(void(^)(BOOL isSuccess))callBack{
    WS(wSelf);
    [XBJinRRNetworkApiManager getAdsWithAid:@"1" num:@"10" block:^(id data) {
        
        if ([[NSString stringWithFormat:@"%@",data[@"result"]] isEqualToString:@"1"]) {
            NSArray *bannerArray = [XBJinRRHomeBannerModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            wSelf.bannerArray = bannerArray;
            [wSelf.tableView reloadData];
            callBack(YES);
        }else{
            callBack(NO);
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
        [wSelf.tableView.mj_header endRefreshing];
    }];
}

//获取消息
-(void)getNoticeWithBlock:(void(^)(BOOL isSuccess))callBack{
    WS(wSelf);
    [XBJinRRNetworkApiManager getNoticeWithBlock:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"result"]] isEqualToString:@"1"]) {
            NSArray *noticeArray = [XBJinRRHomeNoticeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            wSelf.noticeArray = noticeArray;
             [wSelf.tableView reloadData];
            callBack(YES);
        }else{
            callBack(NO);
            
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
        [wSelf.tableView.mj_header endRefreshing];
    }];
}

//获取导航
-(void)getCateWithBlock:(void(^)(BOOL isSuccess))callBack{
    WS(wSelf);
    [XBJinRRNetworkApiManager getCateWithBlock:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"result"]] isEqualToString:@"1"]) {
            XBJinRRHomeNavModel *navModel = [XBJinRRHomeNavModel mj_objectWithKeyValues:data[@"data"]];
            wSelf.cityNameLabel.text = navModel.cityname;
            wSelf.navArray = navModel.cateList;
            [wSelf.tableView reloadData];
            callBack(YES);
        }else{
            callBack(NO);
            
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
        [wSelf.tableView.mj_header endRefreshing];
    }];
}
//获取智能推荐
-(void)getItemsWithIsrec:(void(^)(BOOL isSuccess))callBack{
    WS(wSelf);
    [XBJinRRNetworkApiManager getItemsWithIsrec:@"1" rows:@"4" block:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"result"]] isEqualToString:@"1"]) {
            callBack(YES);
            NSArray *recommandArray = [XBJinRRHomeRecommandModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            wSelf.recommandArray = recommandArray;
            
            [wSelf.tableView.mj_header endRefreshing];
            [wSelf.tableView.mj_footer endRefreshing];
            [wSelf.tableView reloadData];
            
        }else{
            callBack(NO);
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
        [wSelf.tableView.mj_header endRefreshing];
    }];
}
//获取热门借款
-(void)getItemsWithIsrect:(void(^)(BOOL isSuccess))callBack{
    WS(wSelf);
    [XBJinRRNetworkApiManager getItemsWithIsrec:@"0" rows:@"100" block:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"result"]] isEqualToString:@"1"]) {
            callBack(YES);
            NSArray *recommandArray = [XBJinRRHomeHotModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            wSelf.hotDataArray = recommandArray;
            [wSelf.tableView reloadData];
        }else{
            callBack(NO);
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
        [wSelf.tableView.mj_header endRefreshing];
    }];
}





- (void)createUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[XBJinRRHomBannerCell class] forCellReuseIdentifier:XBJinRRHomBannerCellID];
    [tableView registerClass:[XBJinRRMsgCell class] forCellReuseIdentifier:XBJinRRMsgCellID];
    [tableView registerClass:[XBJinRRNavCell class] forCellReuseIdentifier:XBJinRRNavCellID];
    [tableView registerClass:[XBJinRRMenuCell class] forCellReuseIdentifier:XBJinRRMenuCellID];
    [tableView registerClass:[XBJinRRIntelligentRecommendationCell class] forCellReuseIdentifier:XBJinRRIntelligentRecommendationCellID];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XBJinRRHotDataNameCellID];
    [tableView registerClass:[XBJinRRProductCell class] forCellReuseIdentifier:XBJinRRProductCellID];
    
    msgBtn = [[UIButton alloc] init];
    [msgBtn setImage:[UIImage imageNamed:@"home-news"] forState:UIControlStateNormal];
    [msgBtn addTarget:self action:@selector(checkMsg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:msgBtn];
    [msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarHeight);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.height.offset(30);
    }];
    
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, 100, 40) backgroundColor:ClearColor];
    UILabel *cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 40)];
    cityNameLabel.font = [UIFont systemFontOfSize:15];
    cityNameLabel.textColor = [UIColor whiteColor];
    
    UIImageView *imageView = [ViewCreate createImageViewFrame:CGRectMake(0, 10, 20, 20) image:@"location_icon"];
    [bgView addSubview:imageView];
    [bgView addSubview:cityNameLabel];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarHeight);
        make.left.equalTo(self.view.mas_left).offset(10);
    }];
    self.cityNameLabel = cityNameLabel;
    
    
}
//查看信息
- (void )checkMsg{
    NSString *token = [UDefault getObject:TOKEN];
    if (token == nil || [token isEqualToString:@""]) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    WS(bself);
    XBJinRRMyMessageMainViewController *vc = [[XBJinRRMyMessageMainViewController alloc] init];
    vc.refreshBlock = ^{
        [bself.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - UITableView代理
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    } else {
        return self.hotDataArray.count+1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = 180;
        } else if (indexPath.row == 1) {
            height = 44;
        }
    } else if (indexPath.section == 1) {
        height = 140;
    } else if (indexPath.section == 2) {
        height = 140;
    } else if (indexPath.section == 3) {
        height = 160;
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            height = 44;
        } else {
            height = 140;
        }
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(bself);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            XBJinRRHomBannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRHomBannerCellID];
            [bannerCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            bannerCell.bannerImages = self.bannerArray;
            bannerCell.tapImageVBlock = ^(NSInteger currentIndex) {
                XBJinRRHomeBannerModel *model = bself.bannerArray[currentIndex];
                if ([model.Url containsString:@"http"]) {
                    
                    XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
                    [vc setUrl:model.Url webType:WebTypeOther];
                    vc.titleString = model.Name;
                    [bself.navigationController pushViewController:vc animated:YES];
//                    if ([model.Url containsString:@"xy.ganzheapp.com"]){
//                        XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
//                        [vc setUrl:model.Url webType:WebTypeOther];
//                        vc.titleString = model.Name;
//                        [bself.navigationController pushViewController:vc animated:YES];
//                    }else {
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.Url]];
//                    }
                    
                    
                }
            };
            return bannerCell;
        } else if (indexPath.row == 1) {
            XBJinRRMsgCell *msgCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRMsgCellID];
            [msgCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            msgCell.noticeArray = self.noticeArray;
            
            msgCell.clickMoreNewsBlock = ^{
                //查看更多新闻
                XBJinRRSystemNotificationViewController *vc = [XBJinRRSystemNotificationViewController new];
                [bself.navigationController pushViewController:vc animated:YES];
            };
            return msgCell;
        }
    } else if (indexPath.section == 1) {
        XBJinRRNavCell *navCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRNavCellID];
        [navCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        navCell.selectedModelBlock = ^(XBJinRRHomeNavItemModel *selectedModel) {
            [NSNotic_Center postNotificationName:SELECTEDLOANTYPENID object:@{@"cid":selectedModel.ID}];
            self.tabBarController.selectedIndex = 1;
        };
        navCell.navArray = self.navArray;
        return navCell;
    } else if (indexPath.section == 2) {
        XBJinRRMenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRMenuCellID];
        menuCell.selectedIndexBlock = ^(NSInteger index) {
            switch (index) {
                case 0:
                    //贷款大全
                    bself.tabBarController.selectedIndex = 1;
                    break;
                case 1:
                    //办信用卡
                {
                    XBJinRRCreditCardCenterViewController *vc = [XBJinRRCreditCardCenterViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                    //我要赚钱
                {
                    NSString *token = [UDefault getObject:TOKEN];
                    if (token == nil || [token isEqualToString:@""]) {
                        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
                        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
                        [self presentViewController:nav animated:YES completion:nil];
                        return;
                    }
                    XBJinRR_AgentViewController *vc = [XBJinRR_AgentViewController new];
                    vc.changeSelectedIndx = ^(NSInteger index) {
                        
                    };
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 3:
                    //贷款征信
                {
 
                    NSString *token = [UDefault getObject:TOKEN];
                    if (token == nil || [token isEqualToString:@""]) {
                        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
                        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
                        [self presentViewController:nav animated:YES completion:nil];
                        return;
                    }
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://pc.ganzheapp.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=credit&aid=6"]];
//                    XBJinRRCheckCreditViewController *vc = [[XBJinRRCheckCreditViewController alloc] init];
//                    vc.hidesBottomBarWhenPushed = YES;
//                    [bself.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        };
        [menuCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return menuCell;
    } else if (indexPath.section == 3) {
        XBJinRRIntelligentRecommendationCell *recommendCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRIntelligentRecommendationCellID];
        [recommendCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        recommendCell.recommendArray = self.recommandArray;
        recommendCell.selectedModelBlock = ^(XBJinRRHomeRecommandModel *recommendModel) {
            XBJinRR_LookLoanDetailViewController *vc = [XBJinRR_LookLoanDetailViewController new];
            vc.aID = recommendModel.ID;
            vc.hidesBottomBarWhenPushed = YES;
            [bself.navigationController pushViewController:vc animated:YES];
        };
        return recommendCell;
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            UITableViewCell *hotDataNameCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRHotDataNameCellID];
            [hotDataNameCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            hotDataNameCell.textLabel.text = @"热门借款";
            hotDataNameCell.textLabel.font = [UIFont systemFontOfSize:15];
            return hotDataNameCell;
        } else {
            XBJinRRProductCell *productCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRProductCellID];
            XBJinRRHomeHotModel *hotModel = self.hotDataArray[indexPath.row-1];
            productCell.hotModel = hotModel;
            productCell.clickApplyBtnBlock = ^{
                
                XBJinRR_LookLoanDetailViewController *vc = [XBJinRR_LookLoanDetailViewController new];
                vc.aID = hotModel.ID;
                vc.hidesBottomBarWhenPushed = YES;
                [bself.navigationController pushViewController:vc animated:YES];
            };
            [productCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return productCell;
        }
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            
        }
    }
    
    
    
    
    if (indexPath.section == 4) {
        if (indexPath.row!=0) {
            XBJinRRHomeHotModel *tModel = self.hotDataArray[indexPath.row-1];
            XBJinRR_LookLoanDetailViewController *vc = [XBJinRR_LookLoanDetailViewController new];
            vc.aID = tModel.ID;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
@end
