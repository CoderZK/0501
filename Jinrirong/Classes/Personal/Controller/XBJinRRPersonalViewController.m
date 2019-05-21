//
//  XBJinRRPersonalViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPersonalViewController.h"
#import "XBJinRRPersonalHeaderCell.h"
#import "XBJinRRPersonalMoneyCell.h"
#import "XBJinRRPersonalNormalCell.h"
#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"
#import "XBJinRRPersonInfoModel.h"
#import "XBJinRRPersonalBaseInfoViewController.h"
#import "XBJinRRBuyAgencyViewController.h"
#import "XBJinRRCheckCreditViewController.h"
#import "XBJinRRMyMessageMainViewController.h"
#import "ShareAndPromotionViewController.h"
#import "XBJinRRSettingViewController.h"
#import "XBJinRRBankuaisModel.h"
#import "XBJinRRPurseManagerViewController.h"
#import "XBJinRRSourceOfIncomeViewController.h"
#import "XBJinRRNewUserHelpViewController.h"
#import "XBJinRRPersonaIForeItemCell.h"
#import "XBJinRR_AgentViewController.h"
#import "XBJinRRPriceListViewController.h"
#import "XBJinRRCommissionAlertView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "XBTeamViewController.h"
#import "XBCommissionController.h"
#import "XBProductController.h"

@interface XBJinRRPersonalViewController ()<UITableViewDelegate, UITableViewDataSource,XBJinRRPersonalHeaderCellDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    UIImageView *iconImageView;
}
/**
 *  是否有未读消息
 */
@property(nonatomic, copy)NSString *isNoReadMsg;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *dataDict;
@property (nonatomic,strong) XBJinRRPersonInfoModel *personInfoModel;
/**
 *  个人中心四个模块数组
 */
@property(nonatomic, strong)NSMutableArray *topItemArray;
@property(nonatomic, weak)UIView *wrapperView;
@property(nonatomic, weak)UIImageView *wrapperImageView;
@end

@implementation XBJinRRPersonalViewController

static NSString *XBJinRRPersonalHeaderCellID = @"XBJinRRPersonalHeaderCellID";
static NSString *XBJinRRPersonalMoneyCellID = @"XBJinRRPersonalMoneyCellID";
static NSString *XBJinRRPersonalNormalCellID = @"XBJinRRPersonalNormalCellID";


- (void )click{
    NSDictionary *dic = [Dialog Instance].YouTanDic;
    if (!isEmptyStr(dic[@"YtanUrl"])) {
        XBJinRRWebViewController *webVc = [XBJinRRWebViewController new];
        [webVc setUrl:[NSString stringWithFormat:@"%@",dic[@"YtanUrl"]] webType:WebTypeOther];
        webVc.titleString = @"";
        [self.navigationController pushViewController:webVc animated:YES];
    }
}

-(NSMutableArray *)topItemArray{
    if (!_topItemArray) {
        _topItemArray = [NSMutableArray new];
    }
    return _topItemArray;
}

- (NSDictionary *)dataDict
{
    if (_dataDict == nil) {
        _dataDict = @{@"section2":@[@{@"icon":@"per-inf",@"name":@"基本信息"},@{@"icon":@"per-agent",@"name":@"购买代理"},@{@"icon":@"per-check",@"name":@"查征信"}],@"section3":@[@{@"icon":@"per-news",@"name":@"我的消息"},@{@"icon":@"per-share1",@"name":@"分享推广"},@{@"icon":@"per-phone",@"name":@"联系我们"},@{@"icon":@"per-fit",@"name":@"系统设置"}]};
    }
    return _dataDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:@"" isShowBack:YES];
    [self createUI];
    
    
    NSDictionary *dict1 = [Dialog Instance].YouTanDic;
    if (!isEmptyStr(dict1[@"YtanImg"])) {
        iconImageView = [ViewCreate createImageViewFrame:CGRectMake(SCREEN_WIDTH-SIZE(80), SCREEN_HEIGHT-SIZE(180), SIZE(60), SIZE(60)*1.5) image:@"suspend_icon1"];
        iconImageView.userInteractionEnabled = YES;
        [self.view addSubview:iconImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [iconImageView addGestureRecognizer:tap];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:dict1[@"YtanImg"]]];
    }
    
    self.isNoReadMsg = @"0";
    
    [self addRefresh];
    
    [NSNotic_Center addObserver:self selector:@selector(updateData) name:SIGNINSUCCESS object:nil];
    //    [NSNotic_Center addObserver:self selector:@selector(updateData) name:SIGNOUTSUCCESS object:nil];
    [NSNotic_Center addObserver:self selector:@selector(updateData) name:BUYAGENCYSUCCESS object:nil];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//登录成功后刷新数据
- (void )updateData{
    
    
    [self.tableView.mj_header beginRefreshing];
}

//刷新控件
-(void)addRefresh{
    
    
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself requestData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)requestData
{
    
    [self isnoreadmsg:^(BOOL isSuccess) {
        
    }];
    
    [self getpersonalInfoBlock:^(BOOL issuccess) {
        
    }];
    [self getbankuaisBlock:^(BOOL issuccess) {
        
    }];
    
//    WS(bself);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    [self isnoreadmsg:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getpersonalInfoBlock:^(BOOL issuccess) {
//        if (issuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getbankuaisBlock:^(BOOL issuccess) {
//        if (issuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        [bself.tableView.mj_header endRefreshing];
//        //        [bself.tableView.mj_footer endRefreshing];
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
                wSelf.isNoReadMsg = @"0";
                
            }else{
                wSelf.isNoReadMsg = @"1";
                
            }
            [self.tableView reloadData];
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
        [wSelf.tableView.mj_header endRefreshing];
    }];
}



- (void )getpersonalInfoBlock:(void(^)(BOOL issuccess))callback{
    WS(bself);
    [XBJinRRNetworkApiManager getPersonInfoBlock:^(id data) {
        callback(YES);
        XBJinRRPersonInfoModel *personInfoModel = [XBJinRRPersonInfoModel mj_objectWithKeyValues:data];
        bself.personInfoModel = personInfoModel;
        [self.tableView reloadData];
    } fail:^(NSError *errorString) {
        callback(NO);
        [bself.tableView.mj_header endRefreshing];
    }];
}

- (void )getbankuaisBlock:(void(^)(BOOL issuccess))callback{
    WS(bself);
    [XBJinRRNetworkApiManager getbankuaisBlock:^(id data) {
        callback(YES);
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRBankuaisModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            bself.topItemArray = arr.mutableCopy;
            
            [bself.tableView.mj_header endRefreshing];
            [bself.tableView.mj_footer endRefreshing];
            [bself.tableView reloadData];
        }
    } fail:^(NSError *errorString) {
        callback(NO);
        [bself.tableView.mj_header endRefreshing];
    }];
}

#pragma mark -- 布局
- (void)createUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];//当前版本
    UILabel *showVersionLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50)) backgroundColor:ClearColor text:[NSString stringWithFormat:@"当前版本%@",localVersion] textColor:RGB(166, 166, 166) textAlignment:Center font:FONT(16)];
    tableView.tableFooterView = showVersionLabel;
    
    
    [tableView registerClass:[XBJinRRPersonalHeaderCell class] forCellReuseIdentifier:XBJinRRPersonalHeaderCellID];
    [tableView registerClass:[XBJinRRPersonalMoneyCell class] forCellReuseIdentifier:XBJinRRPersonalMoneyCellID];
    [tableView registerClass:[XBJinRRPersonalNormalCell class] forCellReuseIdentifier:XBJinRRPersonalNormalCellID];
    [tableView registerNib:[UINib nibWithNibName:@"XBJinRRPersonaIForeItemCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRPersonaIForeItemCell"];
    self.tableView = tableView;
}

#pragma mark - UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    }  else if (section == 3) {
        return 3;
    } else {
        return 8;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    } else if (indexPath.section == 1) {
        return 64;
    } else if (indexPath.section == 2) {
        return 170;
    } else {
        return 54;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==0){
        return 0.001;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(bself);
    if (indexPath.section == 0) {
        //头像
        XBJinRRPersonalHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalHeaderCellID];
        headerCell.myDelegate = self;
        headerCell.personInfoModel = self.personInfoModel;
        headerCell.isNoReadMsg = self.isNoReadMsg;
        [headerCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return headerCell;
    } else if (indexPath.section == 1) {
        //钱包
        XBJinRRPersonalMoneyCell *moneyCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalMoneyCellID];
        moneyCell.personInfoModel = self.personInfoModel;
        moneyCell.clickBlock = ^(NSInteger index) {
            if (index==0) {
                //跳转到收入详情
                XBJinRRSourceOfIncomeViewController *vc = [XBJinRRSourceOfIncomeViewController new];
                [bself.navigationController pushViewController:vc animated:YES];
            }else{
                XBJinRRPurseManagerViewController *vc = [XBJinRRPurseManagerViewController new];
                vc.selectedIndex = index;
                [bself.navigationController pushViewController:vc animated:YES];
            }
        };
        [moneyCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return moneyCell;
    } else if (indexPath.section == 2) {
        //我的代呗店等
        XBJinRRPersonaIForeItemCell *normal1Cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRPersonaIForeItemCell"];
        [normal1Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        normal1Cell.sourceArray = self.topItemArray;
        normal1Cell.clickBlock = ^(NSInteger index) {
            //点击了哪个按钮
            switch (index) {
                case 0:
                {
                    XBJinRR_AgentViewController *vc = [XBJinRR_AgentViewController new];
                    vc.changeSelectedIndx = ^(NSInteger index) {
                        
                    };
                    [bself.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    
                    
                    //购买代理
                    XBJinRRBuyAgencyViewController *vc = [[XBJinRRBuyAgencyViewController alloc] init];
                    vc.agencyType = bself.personInfoModel.Mtype;
                    vc.Rule       = bself.personInfoModel.Rule;
                    [bself.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                case 2:
                {
                    [self.view showLoadMessageAtCenter:@"加载数据中..."];
                    //分享推广
                    WS(bself);
                    [XBJinRRNetworkApiManager shareWithBlock:^(id data) {
                        [bself.view hide];
                        if (rusultIsCorrect) {
                            ShareAndPromotionViewController *vc = [[ShareAndPromotionViewController alloc] init];
                            [bself.navigationController pushViewController:vc animated:YES];
                        }else{
                            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
                        }
                    } fail:^(NSError *errorString) {
                        [bself.view hide];
                    }];
                }
                    break;
                case 3:
                {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://pc.ganzheapp.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=credit&aid=6"]];

                    //查征信
//                    XBJinRRCheckCreditViewController *vc = [[XBJinRRCheckCreditViewController alloc] init];
//                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            
        };
        return normal1Cell;
        
    } else if (indexPath.section == 3) {
        //基本信息、价格表
        
        if (indexPath.row==0) {
            XBJinRRPersonalNormalCell *normal1Cell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalNormalCellID];
            normal1Cell.icon.image = [UIImage imageNamed:@"per-inf"];
            normal1Cell.nameLabel.text = @"基本信息";
            [normal1Cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            [normal1Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return normal1Cell;
        }else if (indexPath.row == 1){
            XBJinRRPersonalNormalCell *normal1Cell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalNormalCellID];
            normal1Cell.icon.image = [UIImage imageNamed:@"liebiao"];
            normal1Cell.nameLabel.text = @"客户列表";
            [normal1Cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            [normal1Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return normal1Cell;
        }else {
            XBJinRRPersonalNormalCell *normal1Cell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalNormalCellID];
            normal1Cell.icon.image = [UIImage imageNamed:@"price"];
            normal1Cell.nameLabel.text = @"价格表";
            [normal1Cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            [normal1Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return normal1Cell;
        }
        
    } else {
        
        XBJinRRPersonalNormalCell *normal2Cell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalNormalCellID];
        
        if (indexPath.row==0) {
            normal2Cell.icon.image = [UIImage imageNamed:@"per-team"];
            normal2Cell.nameLabel.text = @"我的团队";
        }
        
        if (indexPath.row==1) {
            normal2Cell.icon.image = [UIImage imageNamed:@"per-commission"];
            normal2Cell.nameLabel.text = @"佣金排行榜";
        }
        
        if (indexPath.row==2) {
            normal2Cell.icon.image = [UIImage imageNamed:@"per-list"];
            normal2Cell.nameLabel.text = @"产品排行榜";
        }
        
        if (indexPath.row==3) {
            normal2Cell.icon.image = [UIImage imageNamed:@"help_icon"];
            normal2Cell.nameLabel.text = @"新手帮助";
        }
        
        if (indexPath.row==4) {
            normal2Cell.icon.image = [UIImage imageNamed:@"per-share1"];
            normal2Cell.nameLabel.text = @"微信客服";
        }
        
        if (indexPath.row==5) {
            normal2Cell.icon.image = [UIImage imageNamed:@"per_wechat"];
            normal2Cell.nameLabel.text = @"关注公众号";
        }
        if (indexPath.row==6) {
            normal2Cell.icon.image = [UIImage imageNamed:@"per-phone"];
            normal2Cell.nameLabel.text = @"联系我们";
        }
        if (indexPath.row==7) {
            normal2Cell.icon.image = [UIImage imageNamed:@"per-fit"];
            normal2Cell.nameLabel.text = @"系统设置";
        }
        
        [normal2Cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [normal2Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return normal2Cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
        return;
    }
    NSString *token = [UDefault getObject:TOKEN];
    if (token == nil || [token isEqualToString:@""]) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            XBJinRRPersonalBaseInfoViewController *vc = [[XBJinRRPersonalBaseInfoViewController alloc] init];
            WS(bself);
            vc.editBlock = ^{
                [bself.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            XBJinRRSourceOfIncomeViewController *vc = [[XBJinRRSourceOfIncomeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //跳网页
            XBJinRRPriceListViewController *vc = [XBJinRRPriceListViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 4) {
        
        if (indexPath.row == 0) {
            
       

            XBTeamViewController *vc = [XBTeamViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else
            
        if (indexPath.row == 1) {
    
            XBCommissionController *vc = [XBCommissionController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 2) {
            //新手帮助 写页面
            XBProductController *vc = [XBProductController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 3) {
            //新手帮助 写页面
            XBJinRRNewUserHelpViewController *vc = [XBJinRRNewUserHelpViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 4) {
            [XBJinRR_CustomerView alertViewWithTitle:@"微信客服" Content:self.personInfoModel.wechatKefu yesBtnTitle:@"复制" cancelBtnTitle:@"取消" CancelBtClcik:^{
                
            } sureBtClcik:^{
                [Dialog toastCenter:@"复制成功"];
                UIPasteboard *board = [UIPasteboard generalPasteboard];
                board.string = self.personInfoModel.wechatKefu;
                NSURL *url = [NSURL URLWithString:@"weixin://"];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
        }
        else if (indexPath.row == 5) {
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            UIView *wrapperView = [[UIView alloc] initWithFrame:window.bounds];
            self.wrapperView = wrapperView;
            wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
            [window addSubview:wrapperView];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
            self.wrapperImageView = imageView;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.personInfoModel.wechatQR]];
            imageView.userInteractionEnabled = YES;
            [wrapperView addSubview:imageView];
            imageView.center = wrapperView.center;
            [UIView animateWithDuration:0.5 animations:^{
                imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            } completion:^(BOOL finished) {
                imageView.transform = CGAffineTransformIdentity;
            }];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wechatQRAction:)];
            [wrapperView addGestureRecognizer:tap];
            UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(wechatQRPressAction:)];
            press.minimumPressDuration = 1.f;
            [imageView addGestureRecognizer:press];
        }
        else if (indexPath.row == 6) {
            
            [XBJinRR_CustomerView alertViewWithTitle:@"联系我们" Content:self.personInfoModel.severTel yesBtnTitle:@"拨打" cancelBtnTitle:@"取消" CancelBtClcik:^{
                
            } sureBtClcik:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.personInfoModel.severTel]]];
            }];
            
        }
//        else if (indexPath.row == 2) {
//            [XBJinRRNetworkApiManager Core_public_getWechatBlock:^(id data) {
//                if (rusultIsCorrect) {
//
//
//
//
//                    NSDictionary * dic1 = data[@"data"];
//                    [XBJinRRCommissionAlertView CommissionAlterViewWithSourceInfoDic:dic1 cancelBtClcik:^{
//
//                    } checkAdvertiseBlock:^(NSDictionary * _Nonnull advertiseDic) {
//                        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//                        pboard.string = dic1[@"WeChatOfficial"];
//                        [Dialog toastCenter:@"复制成功"];
//                    }];
//                }else{
//                    [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
//                }
//            } fail:^(NSError *errorString) {
//                [Dialog toastCenter:[NSString stringWithFormat:@"%@",errorString]];
//            }];
//
//        }
        else if (indexPath.row == 7) {
            
            XBJinRRSettingViewController *vc = [[XBJinRRSettingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
- (void)wechatQRAction:(UIGestureRecognizer *)sender {
    [self.wrapperImageView removeFromSuperview];
    [self.wrapperView removeFromSuperview];
}

- (void)wechatQRPressAction:(UIGestureRecognizer *)sender {
    self.wrapperImageView.hidden = YES;
    self.wrapperView.hidden = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"需要保存图片到相册吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.wrapperImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        [self.wrapperImageView removeFromSuperview];
        [self.wrapperView removeFromSuperview];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.wrapperImageView removeFromSuperview];
        [self.wrapperView removeFromSuperview];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark -- <保存到相册>
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
        [Dialog toastCenter:@"保存成功"];
    }
}
#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//    {
//        if (buttonIndex == 1) {
//            NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",@"0551-63669090"];
//
//            UIWebView *callWebview = [[UIWebView alloc]init];
//
//            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//
//            [self.view addSubview:callWebview];
//        }
//    }

#pragma mark - XBJinRRPersonalHeaderCellDelegate
- (void)XBJinRRPersonalHeaderCellClickLogin
{
    NSString *token = [UDefault getObject:TOKEN];
    if (token == nil || [token isEqualToString:@""]) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    XBJinRRPersonalBaseInfoViewController *vc = [[XBJinRRPersonalBaseInfoViewController alloc] init];
    WS(bself);
    vc.editBlock = ^{
        [bself.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)XBJinRRPersonalHeaderCellClickMsg
{
    WS(bself);
    XBJinRRMyMessageMainViewController *vc = [[XBJinRRMyMessageMainViewController alloc] init];
    vc.refreshBlock = ^{
        [bself.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    
    WS(weakSelf);
    
    [XBJinRRNetworkApiManager getPersonInfoBlock:^(id data) {
        XBJinRRPersonInfoModel *personInfoModel = [XBJinRRPersonInfoModel mj_objectWithKeyValues:data];
        weakSelf.personInfoModel = personInfoModel;
        
    } fail:^(NSError *errorString) {
        
    }];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}





@end
