//
//  XBJinRRIncomeFromVipViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//  会员收入

#import "XBJinRRIncomeFromVipViewController.h"
#import "XBJinRRIncomeFromVipCustomerCell.h"
#import "XBJinRRReferincomeModel.h"
#import "XBJinRRPromotdataModel.h"

@interface XBJinRRIncomeFromVipViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property(nonatomic, strong)UITableView *tableView;

/**
 *  一级会员
 */
@property(nonatomic, strong)UIButton *levelOneBtn;
/**
 *  二级会员
 */
@property(nonatomic, strong)UIButton *levelTwoBtn;
/**
 *  是否是一级会员
 */
@property(nonatomic, assign)BOOL isLevelOne;
/**
 *  数据源数组
 */
@property(nonatomic, strong)NSMutableArray *sourceDataArray;
@end

@implementation XBJinRRIncomeFromVipViewController
-(NSMutableArray *)sourceDataArray{
    if (!_sourceDataArray) {
        _sourceDataArray = [NSMutableArray new];
    }
    return _sourceDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLevelOne = YES;
    page = 0;
    [self creatTopUI];
    [self initTableView];
    [self addRefresh];
}
#pragma mark -- 获取头部UI
- (void )creatTopUI{
    UIView *topView = [ViewCreate createLineFrame:CGRectMake(0,NAV_HEIGHT+44, SCREEN_WIDTH, SIZE(50)) backgroundColor:WhiteColor];
    
    self.levelOneBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50)) title:@"推荐会员" titleColor:MainColor font:FONT(17) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    self.levelOneBtn.tag = 10010;
    [self.levelOneBtn addTarget:self action:@selector(checkDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.levelOneBtn];
    //    UIView *line = [ViewCreate createLineFrame:CGRectMake((SCREEN_WIDTH-1)*0.5, 5, 1, SIZE(50)-10) backgroundColor:NORMAL_BGCOLOR];
    //    [topView addSubview:line];
    //    self.levelTwoBtn = [ViewCreate createButtonFrame:CGRectMake((SCREEN_WIDTH-1)*0.5+1, 0, (SCREEN_WIDTH-1)*0.5, SIZE(50)) title:@"二级会员" titleColor:RGB(120, 120, 120) font:FONT(17) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    //    self.levelTwoBtn.tag = 10011;
    //    [self.levelTwoBtn addTarget:self action:@selector(checkDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [topView addSubview:self.levelTwoBtn];
    
    [self.view addSubview:topView];
}
//点击了哪一级会员
- (void )checkDataBtnClick:(UIButton *)sender{
    
}




#pragma mark -- 表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+SIZE(50),SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT-SIZE(50)) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRIncomeFromVipCustomerCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRIncomeFromVipCustomerCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(NAV_HEIGHT+44+SIZE(50));
        make.left.right.bottom.mas_offset(0);
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceDataArray.count;
    //    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBJinRRIncomeFromVipCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRIncomeFromVipCustomerCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XBJinRRReferincomeModel *tModel = self.sourceDataArray[indexPath.row];
    cell.model = tModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 网络请求

//刷新控件
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page=0;
        [bself loadMainDataSource];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page ++;
        [bself loadMainDataSource];
    }];
}
- (void )loadMainDataSource{
    WS(bself);
    NSDictionary *params = @{@"page":@(page),@"rows":@"10"};
    [XBJinRRNetworkApiManager referincomeWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRReferincomeModel mj_objectArrayWithKeyValuesArray:[[Security shareSecurity] decryptDicAES256Data:data[@"data"]]];//data[@"data"]
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
