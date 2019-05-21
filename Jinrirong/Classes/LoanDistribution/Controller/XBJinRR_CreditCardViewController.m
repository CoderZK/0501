//
//  XBJinRR_LoadViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/25.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_CreditCardViewController.h"
#import "XBJinRR_LoadTopCell.h"
#import "XBJinRR_LoadListCell.h"
#import "XBJinRR_ShareLoadInfoViewController.h"

#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"

@interface XBJinRR_CreditCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, assign)NSInteger page;

@property(nonatomic, strong)UITableView *tableView;
/**
 *  推荐产品数组
 */
@property(nonatomic, strong)NSMutableArray *recommendLists;
/**
 *  产品列表
 */
@property(nonatomic, strong)NSMutableArray *Lists;

@end

@implementation XBJinRR_CreditCardViewController
-(NSMutableArray *)recommendLists{
    if (!_recommendLists) {
        _recommendLists = [NSMutableArray new];
    }
    return _recommendLists;
}
-(NSMutableArray *)Lists{
    if (!_Lists) {
        _Lists = [NSMutableArray new];
    }
    return _Lists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NORMAL_BGCOLOR;
    self.page = 0;
    [self initTableView];
    [self addRefresh];
}

#pragma mark --
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 0;
        [bself loadMainData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadMainData];
    }];
}

- (void )loadMainData{
    
 
    [self loadRecommendsCorrect:^(BOOL isSuccess) {
       
    }];
 
    [self loadListCorrect:^(BOOL isSuccess) {
       
    }];

    
//    WS(bself);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    [self loadRecommendsCorrect:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self loadListCorrect:^(BOOL isSuccess) {
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

//获取新品推荐列表
- (void )loadRecommendsCorrect:(void(^)(BOOL isSuccess))callBack{
    //getposterWithItype
    WS(bself);
    [XBJinRRNetworkApiManager getposterWithItype:@"2" Block:^(id data) {
        //Itype 类别:1贷款商品 2信用卡商品
        callBack(YES);
        MyLog(@"%@",data);
        if (rusultIsCorrect) {
            NSArray *modelArr = [XBJinRR_RecommendsLoadModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            bself.recommendLists = modelArr.mutableCopy;
            [bself.tableView.mj_header endRefreshing];
            [bself.tableView.mj_footer endRefreshing];
            [bself.tableView reloadData];
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}


//获取新品推荐列表
- (void )loadListCorrect:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    NSDictionary *params = @{@"page":@(self.page),@"rows":@"6",@"Itype":@"2"};
    [XBJinRRNetworkApiManager getposterWithParams:params Block:^(id data) {
        callBack(YES);
        if (rusultIsCorrect) {
            NSArray *modelArr = [XBJinRR_RecommendsLoadModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            if (bself.page>0) {
                NSMutableArray *mArr = bself.Lists;
                [mArr addObjectsFromArray:modelArr];
                bself.Lists = mArr;
            }else{
                bself.Lists = modelArr.mutableCopy;
            }
             [bself.tableView reloadData];
            
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
    
}








- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[XBJinRR_LoadTopCell class] forCellReuseIdentifier:@"XBJinRR_LoadTopCell"];
    [_tableView registerClass:[XBJinRR_LoadListCell class] forCellReuseIdentifier:@"XBJinRR_LoadListCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(44+180);
        make.left.right.bottom.mas_offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        if (self.recommendLists.count>0) {
            return 1;
        }
    }
    return self.Lists.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(bself);
    if (indexPath.section == 0) {
        XBJinRR_LoadTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_LoadTopCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.recommendLists.count>0) {
            cell.recommends = self.recommendLists;
            cell.clickItemBlock = ^(NSInteger index) {

                if (isEmptyStr([UDefault getObject:TOKEN])) {
                    XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
                    XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
                    [bself presentViewController:nav animated:YES completion:nil];
                    return;
                }
                
                XBJinRR_ShareLoadInfoViewController *vc  = [XBJinRR_ShareLoadInfoViewController new];
                XBJinRR_RecommendsLoadModel *recommend = bself.recommendLists[index];
                vc.model = recommend;
                vc.hidesBottomBarWhenPushed = YES;
                [bself.navigationController pushViewController:vc animated:YES];
            };
        }
        return cell;
    }
    
    XBJinRR_LoadListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_LoadListCell"];
    XBJinRR_RecommendsLoadModel *model = self.Lists[indexPath.row];
    cell.recommendModel = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    
    if (isEmptyStr([UDefault getObject:TOKEN])) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    XBJinRR_ShareLoadInfoViewController *vc  = [XBJinRR_ShareLoadInfoViewController new];
    XBJinRR_RecommendsLoadModel *tmodel = self.Lists[indexPath.row];
    vc.model = tmodel;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return SIZE(160.5);
    }
    return SIZE(100);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(60);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(60)) backgroundColor:WhiteColor];
    UIView *topLineView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10) backgroundColor:NORMAL_BGCOLOR];
    [bgView addSubview:topLineView];
    
    
    UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(15), 10, SCREEN_WIDTH-SIZE(30), SIZE(60-10)) backgroundColor:ClearColor text:@"" textColor:RGB(60, 60, 60) textAlignment:Left font:FONT(16)];
    if (section == 0) {
        titleLabel.text = @"新品推荐";
    }else{
        titleLabel.text = @"产品列表";
    }
    [bgView addSubview:titleLabel];
    return bgView;
}







@end




