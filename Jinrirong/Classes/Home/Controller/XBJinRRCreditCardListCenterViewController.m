//
//  XBJinRRCreditCardListCenterViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/2.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCreditCardListCenterViewController.h"
#import "XBJinRRCreatSmallPicTableViewCell.h"
#import "LrdSuperMenu.h"
#import "XBJinRRMoneyTypeModel.h"
#import "XBJinRRCreditCardModel.h"
#import "XBJinRRcreditcarddetaileViewController.h"


@interface XBJinRRCreditCardListCenterViewController ()<UITableViewDelegate,UITableViewDataSource,LrdSuperMenuDataSource, LrdSuperMenuDelegate>
{
    NSInteger page;
}
@property (nonatomic, strong) LrdSuperMenu *menu;
@property(nonatomic, strong)UITableView *tableView;
/**
 *  银行类型
 */
@property(nonatomic, strong)NSMutableArray *bankTypeArray;
/**
 *  卡种类型
 */
@property(nonatomic, strong)NSMutableArray *cardTypeArray;
/**
 *  货币类型
 */
@property(nonatomic, strong)NSMutableArray *coinTypeArray;
/**
 *  年费类型
 */
@property(nonatomic, strong)NSMutableArray *yearPaymentTypeArray;

/**
 *  卡类型id
 */
@property(nonatomic, copy)NSString *cardid;
/**
 *  币种id
 */
@property(nonatomic, copy)NSString *bitid;
/**
 *  年费id
 */
@property(nonatomic, copy)NSString *feeid;
/**
 *  信用卡数据
 */
@property(nonatomic, strong)NSMutableArray *creditCardArray;
@end

@implementation XBJinRRCreditCardListCenterViewController

-(NSMutableArray *)creditCardArray{
    if (!_creditCardArray) {
        _creditCardArray = [NSMutableArray new];
    }
    return _creditCardArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"信用卡中心"];
    [self setNavWithTitle:@"信用卡中心" isShowBack:YES];
    
    _bankTypeArray = [NSMutableArray new];
    _cardTypeArray = [NSMutableArray new];
    _coinTypeArray = [NSMutableArray new];
    _yearPaymentTypeArray = [NSMutableArray new];
    self.bankid = isEmptyStr(self.bankid)?@"0":self.bankid;
    self.cardid = @"0";
    self.bitid = @"0";
    self.feeid = @"0";
    page = 0;
    
    
    _menu = [[LrdSuperMenu alloc] initWithOrigin:CGPointMake(0, NAV_HEIGHT) andHeight:44];
    _menu.selectedTextColor = MainColor;
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view addSubview:_menu];
    [_menu selectDeafultIndexPath];

    
    [self initTableView];
    [self requestData];
    [self addRefresh];
}

#pragma mark -- 请求头部筛选条件数据

//刷新控件
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page=0;
        [bself getCreditCardList];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page ++;
        [bself getCreditCardList];
    }];
}

- (void)requestData
{
    WS(bself);
    __block BOOL isLoadSuccess0,isLoadSuccess1,isLoadSuccess2,isLoadSuccess3;
    [self getbankTypeBlock:^(BOOL isSuccess) {
        isLoadSuccess0 = isSuccess;
        if (isLoadSuccess0&&isLoadSuccess1&&isLoadSuccess2&&isLoadSuccess3) {
            
        }else{
//            [bself requestData];//一旦有一个失败循环请求，直到请求成功
        }
    }];
    [self getCardTypeBlock:^(BOOL isSuccess) {
        isLoadSuccess1 = isSuccess;
        if (isLoadSuccess0&&isLoadSuccess1&&isLoadSuccess2&&isLoadSuccess3) {
            
        }else{
//            [bself requestData];//一旦有一个失败循环请求，直到请求成功
        }
    }];
    [self getCoinTypeBlock:^(BOOL isSuccess) {
        isLoadSuccess2 = isSuccess;
        if (isLoadSuccess0&&isLoadSuccess1&&isLoadSuccess2&&isLoadSuccess3) {
            
        }else{
//            [bself requestData];//一旦有一个失败循环请求，直到请求成功
        }
    }];
    [self getYearPaymentTypeBlock:^(BOOL isSuccess) {
        isLoadSuccess3 = isSuccess;
        if (isLoadSuccess0&&isLoadSuccess1&&isLoadSuccess2&&isLoadSuccess3) {
            
        }else{
//            [bself requestData];//一旦有一个失败循环请求，直到请求成功
        }
    }];
}

//银行类型
- (void )getbankTypeBlock:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    [XBJinRRNetworkApiManager getCreditCardsCetegoryListWithType:@"1" Block:^(id data) {
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRMoneyTypeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            XBJinRRMoneyTypeModel * model = [[XBJinRRMoneyTypeModel alloc]init];
            model.Name = @"银行不限";
            model.ID = @"0";
            model.isSelected = YES;
            [bself.bankTypeArray addObject:model];
            [bself.bankTypeArray addObjectsFromArray:arr];
            callBack(YES);
        }else{
            callBack(NO);
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}
//卡种类型
- (void )getCardTypeBlock:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    [XBJinRRNetworkApiManager getCreditCardsCetegoryListWithType:@"2" Block:^(id data) {
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRMoneyTypeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            XBJinRRMoneyTypeModel * model = [[XBJinRRMoneyTypeModel alloc]init];
            model.Name = @"卡种不限";
            model.ID = @"0";
            model.isSelected = YES;
            [bself.cardTypeArray addObject:model];
            [bself.cardTypeArray addObjectsFromArray:arr];
            callBack(YES);
        }else{
            callBack(NO);
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}
//币种类型
- (void )getCoinTypeBlock:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    [XBJinRRNetworkApiManager getCreditCardsCetegoryListWithType:@"3" Block:^(id data) {
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRMoneyTypeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            XBJinRRMoneyTypeModel * model = [[XBJinRRMoneyTypeModel alloc]init];
            model.Name = @"币种不限";
            model.ID = @"0";
            model.isSelected = YES;
            [bself.coinTypeArray addObject:model];
            [bself.coinTypeArray addObjectsFromArray:arr];
            callBack(YES);
        }else{
            callBack(NO);
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}
//年费类型
- (void )getYearPaymentTypeBlock:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    [XBJinRRNetworkApiManager getCreditCardsCetegoryListWithType:@"4" Block:^(id data) {
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRMoneyTypeModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            XBJinRRMoneyTypeModel * model = [[XBJinRRMoneyTypeModel alloc]init];
            model.Name = @"年费不限";
            model.ID = @"0";
            model.isSelected = YES;
            [bself.yearPaymentTypeArray addObject:model];
            [bself.yearPaymentTypeArray addObjectsFromArray:arr];
            
            callBack(YES);
        }else{
            callBack(NO);
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}

//获取信用卡列表
- (void )getCreditCardList{
    WS(bself);
    NSDictionary *params = @{@"page":@(page),@"rows":@"8",@"bankid":self.bankid,@"cardid":self.cardid,@"bitid":self.bitid,@"feeid":self.feeid};
    [XBJinRRNetworkApiManager getCreditCardListWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRCreditCardModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            if (self->page>0) {
                [bself.creditCardArray addObjectsFromArray:arr];
            }else{
                bself.creditCardArray = arr.mutableCopy;
            }
            [bself.tableView reloadData];
        }else{
            if (self->page>0) {
                
            }else{
                bself.creditCardArray = nil;
                [bself.tableView reloadData];
            }
        }
    } fail:^(NSError *errorString) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark -- 筛选框代理方法
- (NSInteger)numberOfColumnsInMenu:(LrdSuperMenu *)menu {
    return 4;
}

- (NSInteger)menu:(LrdSuperMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column==0) {
        return  self.bankTypeArray.count;
    }else if (column==1){
        return  self.cardTypeArray.count;
    }else if (column==2){
        return  self.coinTypeArray.count;
    }
    return  self.yearPaymentTypeArray.count;
}


////获取title
//- (NSString *)titleForRowAtIndexPath:(LrdIndexPath *)indexPath{
//    if (indexPath.column == 0) {
//        return @"银行";
//    }else if(indexPath.column == 1) {
//        return @"卡种";
//    }else if(indexPath.column == 2) {
//        return @"币种";
//    }else {
//        return @"年费";
//    }
//}

- (NSString *)menu:(LrdSuperMenu *)menu titleForRowAtIndexPath:(LrdIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (self.bankTypeArray.count>0) {
            XBJinRRMoneyTypeModel *model = self.bankTypeArray[indexPath.row];
            return model.Name;
        }else{
            return @"银行";
        }
    }else if(indexPath.column == 1) {
        if (self.cardTypeArray.count>0) {
            XBJinRRMoneyTypeModel *model = self.cardTypeArray[indexPath.row];
            return model.Name;
        }else{
            return @"卡种";
        }
    }else if(indexPath.column == 2) {
        if (self.coinTypeArray.count>0) {
            XBJinRRMoneyTypeModel *model = self.coinTypeArray[indexPath.row];
            return model.Name;
        }else{
            return @"币种";
        }
    }else {
        if (self.bankTypeArray.count>0) {
            XBJinRRMoneyTypeModel *model = self.yearPaymentTypeArray[indexPath.row];
            return model.Name;
        }else{
            return @"年费";
        }
    }
}
- (NSInteger)menu:(LrdSuperMenu *)menu numberOfItemsInRow:(NSInteger)row inColumn:(NSInteger)column {
    return 0;
}
-(void)menu:(LrdSuperMenu *)menu didSelectRowAtIndexPath:(LrdIndexPath *)indexPath
{
    page=0;
    if (indexPath.column == 0) {
        XBJinRRMoneyTypeModel *model = self.bankTypeArray[indexPath.row];
        self.bankid = model.ID;
    }else if(indexPath.column == 1) {
        XBJinRRMoneyTypeModel *model = self.cardTypeArray[indexPath.row];
        self.cardid = model.ID;
    }else if(indexPath.column == 2) {
        XBJinRRMoneyTypeModel *model = self.coinTypeArray[indexPath.row];
        self.bitid = model.ID;
    }else {
        XBJinRRMoneyTypeModel *model = self.yearPaymentTypeArray[indexPath.row];
        self.feeid = model.ID;
    }
    [self.tableView.mj_header beginRefreshing];
}


-(void)menu:(LrdSuperMenu *)menu didSelectIndex:(NSInteger)index IsShow:(BOOL)isShow
{
}

#pragma mark -- 创建表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRCreatSmallPicTableViewCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRCreatSmallPicTableViewCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menu.mas_bottom).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.creditCardArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBJinRRCreatSmallPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCreatSmallPicTableViewCell"];
    XBJinRRCreditCardModel *creditCardModel = self.creditCardArray[indexPath.row];
    cell.creditCardModel = creditCardModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBJinRRCreditCardModel *creditCardModel = self.creditCardArray[indexPath.row];
    XBJinRRcreditcarddetaileViewController *detaileVc = [XBJinRRcreditcarddetaileViewController new];
    detaileVc.ID = creditCardModel.ID;
    [self.navigationController pushViewController:detaileVc animated:YES];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
