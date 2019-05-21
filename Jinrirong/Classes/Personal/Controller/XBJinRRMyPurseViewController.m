//
//  XBJinRRMyPurseViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//  我的钱包

#import "XBJinRRMyPurseViewController.h"
#import "XBJinRRMyPurseTopCell.h"
#import "XBJinRRGetCashDetailInfoCell.h"
#import "XBJinRRWalletInfoModel.h"
#import "XBJinRRGetCaseViewController.h"
#import "XBJinRRSourceOfIncomeViewController.h"

@interface XBJinRRMyPurseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)NSInteger page;
/**
 *  提现列表数组
 */
@property(nonatomic, strong)NSMutableArray *getwalletListArray;
/**
 *  我的账户信息
 */
@property(nonatomic, copy)NSDictionary *myAccountInfoDic;
@end

@implementation XBJinRRMyPurseViewController
-(NSDictionary *)myAccountInfoDic{
    if (!_myAccountInfoDic) {
        _myAccountInfoDic = [NSDictionary new];
    }
    return _myAccountInfoDic;
}

-(NSMutableArray *)getwalletListArray{
    if (!_getwalletListArray) {
        _getwalletListArray = [NSMutableArray new];
    }
    return _getwalletListArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    

    
    
    [self initTableView];
    [self addRefresh];
}

- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRMyPurseTopCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRMyPurseTopCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRGetCashDetailInfoCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRGetCashDetailInfoCell"];
    

    
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return self.getwalletListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section==1) {
//        return SIZE(100);
//    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(bself);
    if (indexPath.section==0) {
        XBJinRRMyPurseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRMyPurseTopCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",self.myAccountInfoDic[@"income"]] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:BlackColor}];
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:@"收入总额" attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(149, 149, 149)}];
        [attri0 appendAttributedString:attri1];
        cell.allMoneyLabel.attributedText = attri0;
        NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",self.myAccountInfoDic[@"balances"]] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:BlackColor}];
        NSMutableAttributedString *attri3 = [[NSMutableAttributedString alloc] initWithString:@"可结算总额" attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(149, 149, 149)}];
        [attri2 appendAttributedString:attri3];
        cell.getcashLabel.attributedText =attri2;
        
        cell.getWalletClickBlock = ^{
            XBJinRRGetCaseViewController *vc = [XBJinRRGetCaseViewController new];
            vc.cost = self.myAccountInfoDic[@"cost"];
            vc.balances = self.myAccountInfoDic[@"balances"];
            vc.refreshBlock = ^{
                [bself.tableView.mj_header beginRefreshing];
            };
            [bself.navigationController pushViewController:vc animated:YES];
        };
        
        cell.chechMoreDetailClickBlock = ^{
            //查看收入详情
            XBJinRRSourceOfIncomeViewController *vc = [XBJinRRSourceOfIncomeViewController new];
            [bself.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }
    XBJinRRGetCashDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRGetCashDetailInfoCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XBJinRRWalletInfoModel *model = self.getwalletListArray[indexPath.row];
    cell.tModel = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section==0) {
        return [UIView new];
//    }
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(100))];
//    bgView.backgroundColor = [UIColor clearColor];
//    UIButton *codeImageBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(30), SIZE(30), SCREEN_WIDTH-SIZE(60), SIZE(50)) title:@"查看收入" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
//    codeImageBtn.layer.masksToBounds = YES;
//    codeImageBtn.layer.cornerRadius = SIZE(25);
//    [codeImageBtn addTarget:self action:@selector(seeMoney) forControlEvents:UIControlEventTouchUpInside];
//
//    if (self.getwalletListArray.count>0) {
//        codeImageBtn.backgroundColor = MainColor;
//        codeImageBtn.userInteractionEnabled = YES;
//    }else{
//        codeImageBtn.backgroundColor = RGB(180, 180, 180);
//        codeImageBtn.userInteractionEnabled = NO;
//        codeImageBtn.hidden = YES;
//    }
//
//    [bgView addSubview:codeImageBtn];
//    return bgView;
}







#pragma mark --
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 0;
        [bself getCustomerList];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself getCustomerList];
    }];
}
- (void )getCustomerList{
    WS(bself);
    NSDictionary *params = @{@"page":@(self.page),@"rows":@"10"};
    MyLog(@"params  ---  %@",params);
    [XBJinRRNetworkApiManager getwalletWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
       NSDictionary *dic = [[Security shareSecurity] decryptDicAES256Data:data[@"data"]];
        bself.myAccountInfoDic = dic;
        if (rusultIsCorrect) {
            if (bself.page>0) {
                
                NSArray *arr = [XBJinRRWalletInfoModel mj_objectArrayWithKeyValuesArray:dic[@"info"]];
                [bself.getwalletListArray addObjectsFromArray:arr];
            }else{
                NSArray *arr = [XBJinRRWalletInfoModel mj_objectArrayWithKeyValuesArray:dic[@"info"]];
                bself.getwalletListArray = arr.mutableCopy;
            }
            [bself.tableView reloadData];
        }
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
