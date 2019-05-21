//
//  XBJinRRCreditCardCenterViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/2.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCreditCardCenterViewController.h"
#import "XBJinRRCreditCardCenterTopCell.h"
#import "XBJinRRCreatCardBigPicCell.h"
#import "XBJinRRCreatSmallPicTableViewCell.h"
#import "XBJinRR_NormalHeaderView.h"
#import "XBJinRRCreditCardListCenterViewController.h"
#import "XBJinRRCreditCardModel.h"
#import "XBJinRRBankCardModel.h"
#import "XBJinRRcreditcarddetaileViewController.h"

@interface XBJinRRCreditCardCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
/**
 *  顶部信用卡数组
 */
@property(nonatomic, strong)NSMutableArray *topCreditCardArray;
/**
 *  中部银行卡数组
 */
@property(nonatomic, strong)NSMutableArray *centerBankCardArray;
/**
 *  底部热门推荐信用卡数组
 */
@property(nonatomic, strong)NSMutableArray *hotRecommendCreditCardArray;
/**
 *  是否展开
 */
@property(nonatomic, assign)BOOL isExport;
@end

@implementation XBJinRRCreditCardCenterViewController

-(NSMutableArray *)topCreditCardArray{
    if (!_topCreditCardArray) {
        _topCreditCardArray = [NSMutableArray new];
    }
    return _topCreditCardArray;
}

-(NSMutableArray *)centerBankCardArray{
    if (!_centerBankCardArray) {
        _centerBankCardArray = [NSMutableArray new];
    }
    return _centerBankCardArray;
}

-(NSMutableArray *)hotRecommendCreditCardArray{
    if (!_hotRecommendCreditCardArray) {
        _hotRecommendCreditCardArray = [NSMutableArray new];
    }
    return _hotRecommendCreditCardArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"信用卡中心"];
    [self setNavWithTitle:@"信用卡中心" isShowBack:YES];
    self.isExport = NO;
    [self initTableView];
    [self addRefresh];
}

#pragma mark -- 刷新控件
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
    [self getTopCreditCards:^(BOOL isSuccess) {}];
  
    [self getHotRecomendCreditCards:^(BOOL isSuccess) {}];
  
    [self getbankBlock:^(BOOL isSuccess) {}];

    
//    WS(bself);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    [self getTopCreditCards:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//     dispatch_group_enter(group);
//    [self getHotRecomendCreditCards:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getbankBlock:^(BOOL isSuccess) {
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

//获取顶部三张银行卡数据
- (void )getTopCreditCards:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    [XBJinRRNetworkApiManager getcreditWithIsrec:@"1" rows:@"6" Block:^(id data) {
        callBack(YES);
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRCreditCardModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            bself.topCreditCardArray = arr.mutableCopy;
            [self.tableView reloadData];
            [bself.tableView.mj_header endRefreshing];
            [bself.tableView.mj_footer endRefreshing];
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
    
}

//获取热门推荐银行卡数据
- (void )getHotRecomendCreditCards:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    [XBJinRRNetworkApiManager getcreditWithIsrec:@"0" rows:@"6" Block:^(id data) {
        callBack(YES);
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRCreditCardModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            bself.hotRecommendCreditCardArray = arr.mutableCopy;
            [self.tableView reloadData];
            [bself.tableView.mj_header endRefreshing];
            [bself.tableView.mj_footer endRefreshing];
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}

//获取银行卡数据
- (void )getbankBlock:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    [XBJinRRNetworkApiManager getbankBlock:^(id data) {
        callBack(YES);
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRBankCardModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            bself.centerBankCardArray = arr.mutableCopy;
            [self.tableView reloadData];
            [bself.tableView.mj_header endRefreshing];
            [bself.tableView.mj_footer endRefreshing];
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}

#pragma mark -- 创建表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[XBJinRRCreditCardCenterTopCell class] forCellReuseIdentifier:@"XBJinRRCreditCardCenterTopCell"];
    [_tableView registerClass:[XBJinRRCreatCardBigPicCell class] forCellReuseIdentifier:@"XBJinRRCreatCardBigPicCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRCreatSmallPicTableViewCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRCreatSmallPicTableViewCell"];
    
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.topCreditCardArray.count>0?1:0;
    }else if (section == 1) {
        return self.centerBankCardArray.count>0?1:0;
    }
    else{
        return self.hotRecommendCreditCardArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (self.topCreditCardArray.count>1) {
            return SIZE(160);
        }else{
            return SIZE(80);
        }
    }else if (indexPath.section == 1){
        if (self.isExport) {
          return self.centerBankCardArray.count%3==0?(self.centerBankCardArray.count/3.0)*SIZE(150):(self.centerBankCardArray.count/3.0+1)*SIZE(150);
        }else{
            if (self.centerBankCardArray.count>6) {
                return 2*SIZE(150);
            }else{
                return self.centerBankCardArray.count%3==0?(self.centerBankCardArray.count/3.0)*SIZE(150):(self.centerBankCardArray.count/3.0+1)*SIZE(150);
            }
        }
    }
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(bself);
    if (indexPath.section==0) {
        XBJinRRCreditCardCenterTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCreditCardCenterTopCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infoArray = self.topCreditCardArray;
        cell.clcickBlock = ^(XBJinRRCreditCardModel *tModel) {
            XBJinRRcreditcarddetaileViewController *detaileVc = [XBJinRRcreditcarddetaileViewController new];
            detaileVc.ID = tModel.ID;
            [bself.navigationController pushViewController:detaileVc animated:YES];
        };
        return cell;
    }else if (indexPath.section==1){
        XBJinRRCreatCardBigPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCreatCardBigPicCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.isExport) {
            cell.cardArray = self.centerBankCardArray;
        }else{
            if (self.centerBankCardArray.count>6) {
                NSMutableArray *mArr = [NSMutableArray new];
                for (int i=0; i<6; i++) {
                    [mArr addObject:self.centerBankCardArray[i]];
                }
                cell.cardArray = mArr;
            }else{
                cell.cardArray = self.centerBankCardArray;
            }
        }
        cell.clcickBlock = ^(XBJinRRBankCardModel *tModel) {
            XBJinRRCreditCardListCenterViewController *vc = [XBJinRRCreditCardListCenterViewController new];
            vc.bankid = tModel.ID;
            [bself.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else{
        XBJinRRCreatSmallPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCreatSmallPicTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        XBJinRRCreditCardModel *creditCardModel = self.hotRecommendCreditCardArray[indexPath.row];
        cell.creditCardModel = creditCardModel;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        XBJinRRCreditCardModel *creditCardModel = self.hotRecommendCreditCardArray[indexPath.row];
        XBJinRRcreditcarddetaileViewController *detaileVc = [XBJinRRcreditcarddetaileViewController new];
        detaileVc.ID = creditCardModel.ID;
        [self.navigationController pushViewController:detaileVc animated:YES];
    }
}

#pragma mark -- sectionHeaderView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.001;
    }else if (section==1){
        return self.centerBankCardArray.count>0?SIZE(50):0.001;
    }else{
        return self.hotRecommendCreditCardArray.count>0?SIZE(50):0.001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WS(bself);
    if (section==0) {
        return [UIView new];
        
    }else if (section==1) {
        if (self.centerBankCardArray.count>0) {
            XBJinRR_NormalHeaderView *headerView = [[XBJinRR_NormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50))];
            headerView.titleStr  = @"快速办卡";
            headerView.isShowMoreBtn = YES;
            headerView.moreBtnClickBlock = ^{
                XBJinRRCreditCardListCenterViewController *vc = [XBJinRRCreditCardListCenterViewController new];
                [bself.navigationController pushViewController:vc animated:YES];
            };
            return headerView;
        }else{
            return [UIView new];
        }
    }else{
        if (self.hotRecommendCreditCardArray.count>0) {
            XBJinRR_NormalHeaderView *headerView = [[XBJinRR_NormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50))];
            headerView.titleStr  = @"热门推荐";
            headerView.isShowMoreBtn = YES;
            headerView.moreBtnClickBlock = ^{
                XBJinRRCreditCardListCenterViewController *vc = [XBJinRRCreditCardListCenterViewController new];
                [bself.navigationController pushViewController:vc animated:YES];
            };
            return headerView;
        }else{
            return [UIView new];
        }
    }
}

#pragma mark -- sectionFooterView
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return self.topCreditCardArray.count>0?10:0.001;
    }
    else if (section==1) {
        return self.centerBankCardArray.count>0?(SIZE(40)+10):0.001;
    }
    return self.hotRecommendCreditCardArray.count>0?10:0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1) {
        if (self.centerBankCardArray.count>0) {
            UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(40+10)) backgroundColor:WhiteColor];
            
            UIImageView *tapImageView = [ViewCreate createImageViewFrame:CGRectMake((SCREEN_WIDTH-SIZE(30))*0.5, SIZE(5), SIZE(30), SIZE(30)) image:self.isExport?@"up_icon":@"down_icon"];
            [bgView addSubview:tapImageView];
            bgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exportCellTap:)];
            [bgView addGestureRecognizer:tap];
            UIView *line = [ViewCreate createLineFrame:CGRectMake(0, SIZE(40), SCREEN_WIDTH, 10) backgroundColor:NORMAL_BGCOLOR];
            [bgView addSubview:line];
            return bgView;
        }
        else{
            return [UIView new];
        }
    }
    return [UIView new];
}

- (void )exportCellTap:(UITapGestureRecognizer *)tapper{
    self.isExport = !self.isExport;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
