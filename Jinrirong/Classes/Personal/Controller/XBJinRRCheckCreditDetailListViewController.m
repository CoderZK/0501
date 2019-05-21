//
//  XBJinRRCheckCreditDetailListViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/6.
//  Copyright © 2018年 ahxb. All rights reserved.
//  查询征信列表

#import "XBJinRRCheckCreditDetailListViewController.h"
#import "XBJinRRCredibilityModel.h"
#import "XBJinRRCredibilityCell.h"
#import "XBJinRRCheckCreditListDetailInfoViewController.h"

@interface XBJinRRCheckCreditDetailListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}

@property(nonatomic, strong)UITableView *tableView;

/**
 *  数据源数组
 */
@property(nonatomic, strong)NSMutableArray *sourceDataArray;



@end

@implementation XBJinRRCheckCreditDetailListViewController
-(NSMutableArray *)sourceDataArray{
    if (!_sourceDataArray) {
        _sourceDataArray = [NSMutableArray new];
    }
    return _sourceDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    [self addRefresh];
    
    
    
    
    if ([self.fromWay isEqualToString:@"payment"]) {
        
        id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
        [self.view addGestureRecognizer:pan];
        
        
        [self setNavWithTitle:@"查询历史" isShowBack:NO];
        //从付款查询征信页面跳转到查询历史页面
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 20, 20);
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        if (@available(iOS 11.0,*)) {
            [backButton setContentMode:UIViewContentModeScaleToFill];
            [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        }
        [backButton addTarget:self action:@selector(dealBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }else{
        [self setNavWithTitle:@"查询历史" isShowBack:YES];
    }
}
- (void) dealBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.fromWay isEqualToString:@"payment"]) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.fromWay isEqualToString:@"payment"]) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}



//刷新控件
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page=0;
        [bself requestData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page ++;
        [bself requestData];
    }];
}

- (void)requestData
{
    WS(bself);
    NSDictionary *params = @{@"page":@(page),@"rows":@"10"};
    [XBJinRRNetworkApiManager getcredibilityWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRCredibilityModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            if (self->page>0) {
                [bself.sourceDataArray addObjectsFromArray:arr];
            }else{
                bself.sourceDataArray = arr.mutableCopy;
            }
            
        }else{
            if (self->page>0) {
                
            }else{
                bself.sourceDataArray = nil;
            }
        }
        [bself.tableView reloadData];
    } fail:^(NSError *errorString) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
    }];
}




#pragma mark -- 创建表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    //    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRCredibilityCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRCredibilityCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBJinRRCredibilityModel *tModel = self.sourceDataArray[indexPath.row];
    XBJinRRCredibilityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCredibilityCell"];
    cell.tModel = tModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBJinRRCheckCreditListDetailInfoViewController *vc = [XBJinRRCheckCreditListDetailInfoViewController new];
    XBJinRRCredibilityModel *tModel = self.sourceDataArray[indexPath.row];
    vc.tModel = tModel;
    [self.navigationController pushViewController:vc animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
