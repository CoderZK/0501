//
//  XBJinRR_LookLoanDetailViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/31.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_LookLoanDetailViewController.h"
#import "XBJinRRProductCell.h"
#import "XBJinRR_NormalHeaderView.h"
#import "XBJinRRMyHasTypeCell.h"
#import "XBJinRR_LookLoanCustomerLabelCell.h"
#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"
#import "XBEDAILoanTopCell.h"
#import "XBJinRRWebViewUrlViewController.h"
@interface XBJinRR_LookLoanDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong) XBJinRRHomeHotModel *showModel;
/**
 *  sectionHeaderTitle
 */
@property(nonatomic, copy)NSArray *sectionTitles;
/**
 *  获取到的数据字典
 */
@property(nonatomic, strong)NSMutableDictionary *detailInfoDic;
/**
 *  下款攻略数组
 */
@property(nonatomic, strong)NSMutableArray *Downconts;
/**
 *  申请条件
 */
@property(nonatomic, strong)NSMutableArray *ConditIDs;
/**
 *  所需材料
 */
@property(nonatomic, strong)NSMutableArray *NeedIDs;
/**
 *  通过率
 */
@property(nonatomic, strong)NSString *PassRate;
@end

@implementation XBJinRR_LookLoanDetailViewController

-(NSMutableArray *)NeedIDs{
    if (!_NeedIDs) {
        _NeedIDs = [NSMutableArray new];
    }
    return _NeedIDs;
}
-(NSMutableArray *)ConditIDs{
    if (!_ConditIDs) {
        _ConditIDs = [NSMutableArray new];
    }
    return _ConditIDs;
}
-(NSMutableArray *)Downconts{
    if (!_Downconts) {
        _Downconts = [NSMutableArray new];
    }
    return _Downconts;
}

-(NSMutableDictionary *)detailInfoDic{
    if (!_detailInfoDic) {
        _detailInfoDic = [NSMutableDictionary new];
    }
    return _detailInfoDic;
}

-(NSArray *)sectionTitles{
    if (!_sectionTitles) {
        _sectionTitles = @[@"下款攻略",@"申请条件",@"所需材料"].mutableCopy;
    }
    return _sectionTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"找借贷"];
    
    [self setNavWithTitle:@"借款" isShowBack:YES];
    
    self.view.backgroundColor  = [UIColor whiteColor];
    [self initTableView];
    [self addRefresh];
}

#pragma mark -- 获取外链地址
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself getOpenUrl];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}
- (void )getOpenUrl{
    WS(bself);
    [self.view showLoadMessageAtCenter:@"加载数据中..."];
    

    [XBJinRRNetworkApiManager getLoadOpenUrlDetailWithID:self.aID Block:^(id data) {
        [bself.view hide];
        
        [bself.tableView.mj_header endRefreshing];
        NSDictionary *dic = data[@"data"];
        
        bself.PassRate = dic[@"PassRate"];
        
        bself.Downconts = dic[@"Downconts"];
        bself.NeedIDs = dic[@"NeedIDs"];
        bself.ConditIDs = dic[@"ConditIDs"];
        bself.detailInfoDic = dic.mutableCopy;
        
        bself.showModel = [XBJinRRHomeHotModel new];
        bself.showModel.ID = [NSString stringWithFormat:@"%@",bself.aID];
        bself.showModel.Name = [NSString stringWithFormat:@"%@",dic[@"Name"]];
        bself.showModel.Logurl = [NSString stringWithFormat:@"%@",dic[@"Logurl"]];
        bself.showModel.AppNumbs = [NSString stringWithFormat:@"%@",dic[@"AppNumbs"]];
        bself.showModel.Intro = [NSString stringWithFormat:@"%@",dic[@"Intro"]];
        bself.showModel.Jkdays = [NSString stringWithFormat:@"%@",dic[@"Jkdays"]];
        bself.showModel.DayfeeRate = [NSString stringWithFormat:@"%@",dic[@"DayfeeRate"]];
        bself.showModel.TypeName = [NSString stringWithFormat:@"%@",dic[@"TypeName"]];
        
        [bself.tableView reloadData];
//        MyLog(@"获取外链地址 --  %@",data);
    } fail:^(NSError *errorString) {
        [bself.view hide];
        
        [bself.tableView.mj_header endRefreshing];
    }];
}

#pragma mark -- tableView
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(100))];
    UIButton *applyBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(20), SIZE(20), SCREEN_WIDTH-SIZE(40), SIZE(50)) title:@"立即申请" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
    [bgView addSubview:applyBtn];
    [applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    applyBtn.layer.masksToBounds = YES;
    applyBtn.layer.cornerRadius = SIZE(25);
    _tableView.tableFooterView = bgView;
    
    [_tableView registerClass:[XBJinRRProductCell class] forCellReuseIdentifier:@"XBJinRRProductCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[XBJinRR_LookLoanCustomerLabelCell class] forCellReuseIdentifier:@"XBJinRR_LookLoanCustomerLabelCell"];
    [_tableView registerClass:[XBJinRRMyHasTypeCell class] forCellReuseIdentifier:@"XBJinRRMyHasTypeCell"];
    [_tableView registerClass:[XBEDAILoanTopCell class] forCellReuseIdentifier:@"XBEDAILoanTopCell"];
    
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
    return 1+self.sectionTitles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else if (section==1) {
        return self.Downconts.count>0?1:0;
    }
    else if (section==2) {
        return self.ConditIDs.count>0?1:0;
    }
    else{
        return self.NeedIDs.count>0?2:1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 140;
    }
    else if (indexPath.section==1) {
        NSMutableString *mStr = [NSMutableString new];
        for (int i=0; i<self.Downconts.count; i++) {
            [mStr appendString:[NSString stringWithFormat:@"· %@\n",self.Downconts[i]]];
        }
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle1.lineSpacing = 10;
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:mStr attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
        CGFloat height = [LLUtils getAttributedStringHeight:attri1];
        return self.Downconts.count>0?height+20:0;
    }
    else if (indexPath.section==2) {
        return self.ConditIDs.count>0?10+(((self.ConditIDs.count-1) / 4)+1)*(40+10):0;
    }
    else{
        if (indexPath.row==0) {
            if (self.NeedIDs.count>0) {
                return self.NeedIDs.count>0?10+(((self.NeedIDs.count-1) / 4)+1)*(40+10):0;
            }else{
                return SIZE(150);
            }
        }else{
            return SIZE(150);
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        XBEDAILoanTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBEDAILoanTopCell"];
        cell.PassRate = self.PassRate;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hotModel = self.showModel;
        cell.applyBtn.hidden =  YES;
        cell.clickApplyBtnBlock = ^{
            //啥事不做
        };
        return cell;
    }
    else if (indexPath.section==1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        
        NSMutableString *mStr = [NSMutableString new];
        for (int i=0; i<self.Downconts.count; i++) {
            [mStr appendString:[NSString stringWithFormat:@"· %@\n",self.Downconts[i]]];
        }
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle1.lineSpacing = 10;
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:mStr attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
        cell.textLabel.attributedText = attri1;
        return cell;
    }
    else if (indexPath.section == 2){
        XBJinRRMyHasTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRMyHasTypeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hasDataArray = self.ConditIDs;
        cell.isNotSelect = YES;
        return cell;
    }
    else if (indexPath.section == 3){
        if (indexPath.row==0) {
            if (self.NeedIDs.count>0) {
                XBJinRRMyHasTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRMyHasTypeCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.hasDataArray = self.NeedIDs;
                cell.isNotSelect = YES;
                return cell;
            }else{
                XBJinRR_LookLoanCustomerLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_LookLoanCustomerLabelCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.applyPeopleCount = [NSString stringWithFormat:@"%@",isEmptyStr(self.showModel.AppNumbs)?@"":self.showModel.AppNumbs];
                return cell;
            }
            
        }else{
            XBJinRR_LookLoanCustomerLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_LookLoanCustomerLabelCell"];
            cell.applyPeopleCount = [NSString stringWithFormat:@"%@",self.showModel.AppNumbs];
            return cell;
        }
    }
    return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- tableView头部视图
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 10;
    }
    else if (section==1) {
        return self.Downconts.count>0?SIZE(50):10;
    }
    else if (section==2) {
        return self.ConditIDs.count>0?SIZE(50):10;
    }
    else{
        return self.NeedIDs.count>0?SIZE(50):10;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return [UIView new];
    }
    else if (section==1) {
        XBJinRR_NormalHeaderView *headerView = [[XBJinRR_NormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50))];
        headerView.isHiddenLine = YES;
        headerView.titleStr  = [NSString stringWithFormat:@"%@",self.sectionTitles[section-1]];
        return self.Downconts.count>0?headerView:[UIView new];
    }
    else if (section==2) {
        XBJinRR_NormalHeaderView *headerView = [[XBJinRR_NormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50))];
        headerView.isHiddenLine = YES;
        headerView.titleStr  = [NSString stringWithFormat:@"%@",self.sectionTitles[section-1]];
        return self.ConditIDs.count>0?headerView:[UIView new];
    }
    else{
        XBJinRR_NormalHeaderView *headerView = [[XBJinRR_NormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50))];
        headerView.isHiddenLine = YES;
        headerView.titleStr  = [NSString stringWithFormat:@"%@",self.sectionTitles[section-1]];
        return self.NeedIDs.count>0?headerView:[UIView new];
    }
}

#pragma mark -- footerView
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}




//立即申请按钮被点击
- (void )applyBtnClick{
    
    NSString *token = [UDefault getObject:TOKEN];
    if (token == nil || [token isEqualToString:@""]) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [XBJinRRNetworkApiManager productStatisticsWithID:self.aID Block:^(id data) {
        
    } fail:^(NSError *errorString) {
        
    }];
    XBJinRRWebViewUrlViewController *vc = [XBJinRRWebViewUrlViewController new];
    vc.webUrl = [NSString stringWithFormat:@"%@",self.detailInfoDic[@"Openurl"]];
//    [vc setUrl:[NSString stringWithFormat:@"%@",self.detailInfoDic[@"Openurl"]] webType:WebTypeOther];
    vc.titleName = [NSString stringWithFormat:@"%@",self.showModel.Name];
    [self.navigationController pushViewController:vc animated:YES];
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
