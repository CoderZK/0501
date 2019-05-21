//
//  XBJinRR_NewsViewController.m
//  Jinrirong
//
//  Created by 张艳江 on 2019/4/12.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBJinRR_NewsViewController.h"
#import "XBJinRRNewsSectionView.h"
#import "XBJinRR_NewsCell.h"
#import "XBJinRRNewsListModel.h"
#import "XBJinRRNewsDetailViewController.h"
#import "SDCycleScrollView.h"
#import "XBJinRRHomeBannerModel.h"
#import "XBJinRRPersonInfoModel.h"
#import "XBJinRRBuyAgencyViewController.h"

@interface XBJinRR_NewsViewController ()<UITableViewDataSource,UITableViewDelegate,XBJinRRNewsSectionViewDelegate,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView      *scrollBgView;

@property (strong, nonatomic) SDCycleScrollView      *cycleScrollView;
@property (strong, nonatomic) NSArray                *bannerArray;
@property (strong, nonatomic) XBJinRRNewsSectionView *sectionView;
@property (strong, nonatomic) NSArray                *sectionArray;
@property (assign, nonatomic) NSInteger              page;
@property (strong, nonatomic) NSMutableArray         *newsArray;
@property (strong, nonatomic) NSString               *cid;
@property (assign, nonatomic) NSInteger              tag;
@property (assign, nonatomic) NSInteger              seeLeve;//可查看的等级
@property (nonatomic,strong) XBJinRRPersonInfoModel  *personInfoModel;

@end

@implementation XBJinRR_NewsViewController

- (XBJinRRNewsSectionView *)sectionView{
    if (!_sectionView) {
        _sectionView = [XBJinRRNewsSectionView addSectionView];
        _sectionView.lineView1.hidden = YES;
        _sectionView.lineView2.hidden = YES;
        _sectionView.delegate = self;
    }
    return _sectionView;
}
- (NSMutableArray *)newsArray{
    if (!_newsArray) {
        _newsArray = [NSMutableArray array];
    }
    return _newsArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *token = [UDefault getObject:TOKEN];
    if (token.length > 0) {
        [XBJinRRNetworkApiManager getPersonInfoBlock:^(id data) {
            NSLog(@"个人信息返回%@",data);
            self.personInfoModel = [XBJinRRPersonInfoModel mj_objectWithKeyValues:data];
        } fail:^(NSError *errorString) {
            
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavWithTitle:@"资讯" isShowBack:NO];
    
    self.tableView.separatorColor = RGB(239, 239, 239);
    self.tableView.rowHeight = 105;
    self.tableView.backgroundColor = NORMAL_BGCOLOR;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBJinRR_NewsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //获取轮播图
    [self.scrollBgView addSubview:self.cycleScrollView];
    [self requestScrollData];
    //请求数据
    self.tag = 0;
    self.page = 0;
    [self requestData];
    [self addRefresh];
}
#pragma mark --
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 0;
        [bself.newsArray removeAllObjects];
        [bself requestNewsData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself requestNewsData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBJinRR_NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.newsArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBJinRRNewsListModel *model  = self.newsArray[indexPath.row];
    
    NSString *token = [UDefault getObject:TOKEN];
    if ([model.IsVip intValue] == 1) {
        if (token == nil || [token isEqualToString:@""]) {
            [self isLogin];
            return;
        }
        if ([self.personInfoModel.Mtype intValue] < self.seeLeve) {
            [Dialog toastCenter:@"你还不是代理，请先购买"];
            //购买代理
            XBJinRRBuyAgencyViewController *vc = [[XBJinRRBuyAgencyViewController alloc] init];
            vc.agencyType = self.personInfoModel.Mtype;
            vc.Rule       = self.personInfoModel.Rule;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            XBJinRRNewsDetailViewController *vc = [XBJinRRNewsDetailViewController new];
            vc.tModel = model;
            vc.isNews = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        XBJinRRNewsDetailViewController *vc = [XBJinRRNewsDetailViewController new];
        vc.tModel = model;
        vc.isNews = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - 点击分区代理
- (void)clickNewsSctionButtonWithTag:(NSInteger)tag{
    
    if (self.tag == tag) {
        return;
    }
    self.tag = tag;
    XBJinRRNewsListModel *model = self.sectionArray[tag];
    self.cid = model.ID;
    self.page = 0;
    [self.newsArray removeAllObjects];
    [self.tableView.mj_header beginRefreshing];
    [self requestNewsData];
}
#pragma mark - 请求数据
- (void)requestScrollData{
    [XBJinRRNetworkApiManager getAdsWithAid:@"8" num:@"10" block:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"result"]] isEqualToString:@"1"]) {
            self.bannerArray = [XBJinRRHomeBannerModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            //NSLog(@"轮播图%@====%ld",data,self.bannerArray.count);
            self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120) delegate:self placeholderImage:[UIImage imageNamed:@""]];
            self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            NSMutableArray *images = [NSMutableArray array];
            for (XBJinRRHomeBannerModel *model in self.bannerArray) {
                [images addObject:model.Pic];
            }
            self.cycleScrollView.imageURLStringsGroup = [images copy];
            [self.scrollBgView addSubview:self.cycleScrollView];
        }
    } fail:^(NSError *errorString) {
    }];
}
- (void)requestData{
    
    [XBJinRRNetworkApiManager newsBlock:^(id data) {
        //NSLog(@"---%@",data[@"message"]);
        self.sectionArray = [XBJinRRNewsListModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
        [self.sectionView.sectionBtn0 setTitle:data[@"data"][0][@"Name"] forState:0];
        [self.sectionView.sectionBtn1 setTitle:data[@"data"][1][@"Name"] forState:0];
        [self.sectionView.sectionBtn2 setTitle:data[@"data"][2][@"Name"] forState:0];
        
        self.cid = data[@"data"][0][@"ID"];
        [self requestNewsData];
    } fail:^(NSError *errorString) {
        NSLog(@"失败返回的错误%@", errorString);
    }];
}
- (void)requestNewsData{
    
    [XBJinRRNetworkApiManager getNewsWithPage:self.page rows:10 cid:self.cid block:^(id data) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.seeLeve = [data[@"wzdj"] intValue];
        NSArray *tempArray = [XBJinRRNewsListModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
        [self.newsArray addObjectsFromArray:tempArray];
        [self.tableView reloadData];
    } fail:^(NSError *errorString) {
        NSLog(@"失败返回的错误%@", errorString);
    }];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    XBJinRRHomeBannerModel *model = self.bannerArray[index];
    if ([model.Url containsString:@"http"]) {
        XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
        [vc setUrl:model.Url webType:WebTypeOther];
        vc.titleString = model.Name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
