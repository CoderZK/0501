//
//  XBJinRRLookLoanViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRLookLoanViewController.h"
#import "XBJinRRMoneyTypeModel.h"
#import "XBJinRRTypeMenu.h"
#import "XBJinRRHomeHotModel.h"
#import "XBJinRRProductCell.h"
#import "XBJinRR_LookLoanDetailViewController.h"
#import "LrdSuperMenu.h"

@interface XBJinRRLookLoanViewController ()<UITableViewDelegate, UITableViewDataSource,LrdSuperMenuDataSource, LrdSuperMenuDelegate,XBJinRRTypeMenuDelegate>
{
    UIImageView *iconImageView;
}
@property (nonatomic,strong) XBJinRRTypeMenu *typeMenu;

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,copy) NSString *jkday;//期限id
@property (nonatomic,copy) NSString *tid;//金额id
@property (nonatomic,copy) NSString *cid;//类型 我有id
@property (nonatomic,copy) NSString *nids;//类型 我需要id

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;



@property (nonatomic, strong) LrdSuperMenu *menu;
/**
 *  金额数组列表
 */
@property(nonatomic, strong)NSMutableArray *moneyDataArray;
/**
 *  类型数组列表
 */
@property(nonatomic, strong)NSMutableArray *myHasDataArray;
/**
 *  类型数组列表
 */
@property(nonatomic, strong)NSMutableArray *myNeedDataArray;
/**
 *  贷款期限数组列表
 */
@property(nonatomic, strong)NSMutableArray *loanTimeoutDataArray;
@end

@implementation XBJinRRLookLoanViewController

static NSString *XBJinRRLookLoanCellID = @"XBJinRRLookLoanCellID";
-(NSMutableArray *)loanTimeoutDataArray{
    if (!_loanTimeoutDataArray) {
        _loanTimeoutDataArray = [NSMutableArray new];
    }
    return _loanTimeoutDataArray;
}

-(NSMutableArray *)myHasDataArray{
    if (!_myHasDataArray) {
        _myHasDataArray = [NSMutableArray new];
    }
    return _myHasDataArray;
}
-(NSMutableArray *)myNeedDataArray{
    if (!_myNeedDataArray) {
        _myNeedDataArray = [NSMutableArray new];
    }
    return _myNeedDataArray;
}
-(XBJinRRTypeMenu *)typeMenu{
    if (!_typeMenu) {
        _typeMenu = [[XBJinRRTypeMenu alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT+[MyAdapter laDapter:40], SCREEN_WIDTH,0)];
        _typeMenu.backgroundColor = [UIColor whiteColor];
        _typeMenu.myDelegate = self;
    }
    return _typeMenu;
}

-(NSMutableArray *)moneyDataArray{
    if (!_moneyDataArray) {
        _moneyDataArray = [NSMutableArray new];
    }
    return _moneyDataArray;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
//    [self setNavTitleStr:@"找借款"];
    [self setNavWithTitle:@"找借贷" isShowBack:NO];
    
    
    
    self.jkday = @"0";
    self.tid = @"0";
    self.cid = @"0";
    self.nids = @"0";
    
    _menu = [[LrdSuperMenu alloc] initWithOrigin:CGPointMake(0, NAV_HEIGHT) andHeight:44];
    _menu.selectedTextColor = MainColor;
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view addSubview:_menu];
    [_menu selectDeafultIndexPath];
    [self.view addSubview:self.typeMenu];
    
    
    
    
    [self createUI];
    [self requestMenuData];
    [self.tableView.mj_header beginRefreshing];
    
    

    NSDictionary *dict1 = [Dialog Instance].YouTanDic;
    if (!isEmptyStr(dict1[@"YtanImg"])) {
        iconImageView = [ViewCreate createImageViewFrame:CGRectMake(SCREEN_WIDTH-SIZE(80), SCREEN_HEIGHT-SIZE(180), SIZE(60), SIZE(60)*1.5) image:@"suspend_icon1"];
        iconImageView.userInteractionEnabled = YES;
        [self.view addSubview:iconImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [iconImageView addGestureRecognizer:tap];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:dict1[@"YtanImg"]]];
    }
    
    [NSNotic_Center addObserver:self selector:@selector(changeNidSearchAgin:) name:SELECTEDLOANTYPENID object:nil];//监听首页选择的那种类型的贷款方式
    
}
- (void )changeNidSearchAgin:(NSNotification *)noti{
    NSDictionary *dic = noti.object;
    self.cid = isEmptyStr(dic[@"cid"])?@"0":dic[@"cid"];
    self.jkday = @"0";
    self.tid = @"0";
    self.nids = @"0";
    [self loadData];
    [self.tableView.mj_header beginRefreshing];
}
-(void)dealloc{
    [NSNotic_Center removeObserver:self];
}

#pragma mark -- 请求数据
- (void)loadData
{
    _pageIndex = 0;
    [self requestData];
}
- (void)loadMoreData
{
    _pageIndex++;
    [self requestData];
}
- (void)requestData
{
    WS(wSelf);
   
    [XBJinRRNetworkApiManager getItemsWithPage:_pageIndex rows:8 tid:self.tid cid:self.cid nids:self.nids jkday:self.jkday block:^(id data) {
        [wSelf.tableView.mj_header endRefreshing];
        [wSelf.tableView.mj_footer endRefreshing];
        
        NSArray *dataArray = [XBJinRRHomeHotModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
        
        if (wSelf.pageIndex == 0) {
            [wSelf.dataArray removeAllObjects];
        }
        
        [wSelf.dataArray addObjectsFromArray:dataArray];
    
        [wSelf.tableView reloadData];
    } fail:^(NSError *errorString) {
        
        [wSelf.tableView.mj_header endRefreshing];
        [wSelf.tableView.mj_footer endRefreshing];
    }];
}
- (void)requestMenuData
{
    WS(wSelf);
    [XBJinRRNetworkApiManager getMoneyTypeWithBlock:^(id data) {
        NSArray *moneyDataArray = [XBJinRRMoneyTypeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
//        XBJinRRMoneyTypeModel * model = [[XBJinRRMoneyTypeModel alloc]init];
//        model.Name = @"金额不限";
//        model.ID = @"0";
//        model.isSelected = YES;
//        [wSelf.moneyDataArray addObject:model];
        [wSelf.moneyDataArray addObjectsFromArray:moneyDataArray];
    } fail:^(NSError *errorString) {
        
    }];
    
    
    [XBJinRRNetworkApiManager getMoneyJktimesBlock:^(id data) {
        NSArray *DataArray = [XBJinRRMoneyTypeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
        XBJinRRMoneyTypeModel * model = [[XBJinRRMoneyTypeModel alloc]init];
        model.Name = @"期限不限";
        model.ID = @"0";
        model.isSelected = YES;
        [wSelf.loanTimeoutDataArray addObject:model];
        [wSelf.loanTimeoutDataArray addObjectsFromArray:DataArray];
    } fail:^(NSError *errorString) {
        
    }];
    
    
    [XBJinRRNetworkApiManager getCateTypeWithBlock:^(id data) {
        NSArray *myHasDataArray = [XBJinRRMoneyTypeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
        
        [XBJinRRNetworkApiManager getNeedTypeWithBlock:^(id data) {
            NSArray *myNeedDataArray = [XBJinRRMoneyTypeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            
            wSelf.myHasDataArray = myHasDataArray.mutableCopy;
            wSelf.myNeedDataArray = myNeedDataArray.mutableCopy;
            

            wSelf.typeMenu.hasDataArray = myHasDataArray;
            wSelf.typeMenu.needDataArray = myNeedDataArray;
        } fail:^(NSError *errorString) {
            
        }];
        
    } fail:^(NSError *errorString) {
        
    }];
    
}
- (void)createUI
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menu.frame), SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)-44) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    [tableView registerClass:[XBJinRRProductCell class] forCellReuseIdentifier:XBJinRRLookLoanCellID];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView = tableView;
}

#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(bself);
    XBJinRRProductCell *productCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRLookLoanCellID];
    XBJinRRHomeHotModel *hotModel = self.dataArray[indexPath.row];
    productCell.hotModel = hotModel;
    productCell.clickApplyBtnBlock = ^{
        XBJinRR_LookLoanDetailViewController *vc = [XBJinRR_LookLoanDetailViewController new];
        vc.aID = hotModel.ID;
        vc.hidesBottomBarWhenPushed = YES;
        [bself.navigationController pushViewController:vc animated:YES];
    };
    return productCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBJinRRHomeHotModel *tModel = self.dataArray[indexPath.row];
    XBJinRR_LookLoanDetailViewController *vc = [XBJinRR_LookLoanDetailViewController new];
    vc.aID = tModel.ID;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark -- 筛选框代理方法
- (NSInteger)numberOfColumnsInMenu:(LrdSuperMenu *)menu {
    return 3;
}

- (NSInteger)menu:(LrdSuperMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    return column==0?self.loanTimeoutDataArray.count:column==1?self.moneyDataArray.count:0;
}

- (NSString *)menu:(LrdSuperMenu *)menu titleForRowAtIndexPath:(LrdIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (self.loanTimeoutDataArray.count>0) {
            XBJinRRMoneyTypeModel *model = self.loanTimeoutDataArray[indexPath.row];
            return model.Name;
        }
        return @"期限";
    }else if(indexPath.column == 1) {
        if (self.moneyDataArray.count>0) {
            XBJinRRMoneyTypeModel *model = self.moneyDataArray[indexPath.row];
            return model.Name;
        }
        return @"金额";

    }else {
        return @"类型";
    }
}


- (NSInteger)menu:(LrdSuperMenu *)menu numberOfItemsInRow:(NSInteger)row inColumn:(NSInteger)column {
    return 0;
}

-(void)menu:(LrdSuperMenu *)menu didSelectRowAtIndexPath:(LrdIndexPath *)indexPath
{
    if (indexPath.column==0) {
        XBJinRRMoneyTypeModel *model = self.loanTimeoutDataArray[indexPath.row];
        self.jkday = model.ID;
        [self.tableView.mj_header beginRefreshing];
    }
    if (indexPath.column==1) {
        XBJinRRMoneyTypeModel *model = self.moneyDataArray[indexPath.row];
        self.tid = model.ID;
        [self.tableView.mj_header beginRefreshing];
    }
}


-(void)menu:(LrdSuperMenu *)menu didSelectIndex:(NSInteger)index IsShow:(BOOL)isShow
{
    if (index==2) {
        if (self.typeMenu.frame.size.height==0) {
            //显示
            
            [UIView animateWithDuration:0.2 animations:^{
                self.typeMenu.frame = CGRectMake(0, NAV_HEIGHT+[MyAdapter laDapter:40],SCREEN_WIDTH, SIZE(250));
            }];
        }else{
            //隐藏
            [UIView animateWithDuration:0.2 animations:^{
                
                self.typeMenu.frame = CGRectMake(0, NAV_HEIGHT+[MyAdapter laDapter:40], SCREEN_WIDTH, 0);
                
            }];
        }
        [self.view bringSubviewToFront:self.typeMenu];
    }else{
        if (self.typeMenu.frame.size.height!=0) {
            //隐藏
            [UIView animateWithDuration:0.2 animations:^{
                
                self.typeMenu.frame = CGRectMake(0, NAV_HEIGHT+[MyAdapter laDapter:40], SCREEN_WIDTH, 0);
                
            }];
        }
    }
}

-(void)backClickBlock
{
    if (self.typeMenu.frame.size.height!=0) {
        //隐藏
        [UIView animateWithDuration:0.2 animations:^{
            
            self.typeMenu.frame = CGRectMake(0, NAV_HEIGHT+[MyAdapter laDapter:40], SCREEN_WIDTH, 0);
            
        }];
    }
}



#pragma mark - XBJinRRTypeMenuDelegate
- (void)XBJinRRTypeMenuClickBtnWithCid:(NSString *)cid nids:(NSString *)nids
{
    [UIView animateWithDuration:0.2 animations:^{

        self.typeMenu.frame = CGRectMake(0, NAV_HEIGHT+[MyAdapter laDapter:40], SCREEN_WIDTH, 0);
        [self.menu hideView];
    }];

    self.cid = isEmptyStr(cid)?@"0":cid;
    self.nids = isEmptyStr(nids)?@"0":nids;
    [self.tableView.mj_header beginRefreshing];
}

@end
