//
//  XBJinRR_ShareLoadInfoViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/29.
//  Copyright © 2018年 ahxb. All rights reserved.
//  同城jie贷产品推广

#import "XBJinRR_ShareLoadInfoViewController.h"
#import "XBJinRR_NormalHeaderView.h"
#import "XBJinRR_LoadShareJoinStyleCell.h"
#import "XBJinRR_LoadShareSalaryDescriptionCell.h"
#import "XBJinRR_LoadShareProductCell.h"
#import "XBJinRR_LoadShareChartsCell.h"
#import "XBJinRR_LoadShareCustomerModel.h"
#import "XBJinRRHomeBannerModel.h"
#import "XBJinRR_LoadShareMyPosterImageViewController.h"
#import "XBJinRRBigBankCardCell.h"
#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"
#import "XBJinRRNewSalaryDesCell.h"


@interface XBJinRR_ShareLoadInfoViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property(nonatomic, strong)UITableView *tableView;
/**
 *  排行榜数据列表
 */
@property(nonatomic, strong)NSMutableArray *customerList;
/**
 *  sectionHeaderTitle
 */
@property(nonatomic, copy)NSArray *sectionTitles;
/**
 *  banner图
 */
@property(nonatomic, strong)NSMutableArray *bannerArray;
/**
 *  需要展示的信息
 */
@property(nonatomic, strong)NSMutableDictionary *iteminfo;
@end

@implementation XBJinRR_ShareLoadInfoViewController
-(NSMutableDictionary *)iteminfo{
    if (!_iteminfo) {
        _iteminfo = [NSMutableDictionary new];
    }
    return _iteminfo;
}

-(NSMutableArray *)customerList{
    if (!_customerList) {
        _customerList = [NSMutableArray new];
    }
    return _customerList;
}

-(NSArray *)sectionTitles{
    if (!_sectionTitles) {
        NSString *lastMonthDateStr = [LLUtils getLastMonthDateStr];
        NSArray *arr = [lastMonthDateStr componentsSeparatedByString:@"-"];
        _sectionTitles = @[@{@"titleStr":@"产品名称",@"desStr":@""},@{@"titleStr":@"参与方式",@"desStr":@""},@{@"titleStr":@"工资介绍",@"desStr":@""},@{@"titleStr":@"排行榜",@"desStr":[NSString stringWithFormat:@"%@年%@月排行榜(前十名)",arr.count==2? arr[0]:@"",arr.count==2? arr[1]:@""]}];
    }
    return _sectionTitles;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:@"借贷产品推广" isShowBack:YES];
    [self initTableView];
    [self addRefresh];
}


//刷新控件
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself loadMainRequestData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void )loadMainRequestData{
    
    [self getLoadSharePosterSource:^(BOOL isSuccess) {
      
    }];
    [self getLoadShareCustomerWithDate:^(BOOL isSuccess) {
        
    }];
    
//    WS(bself);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    [self getLoadSharePosterSource:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_enter(group);
//    [self getLoadShareCustomerWithDate:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_group_leave(group);
//        }
//    }];
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        [bself.tableView.mj_header endRefreshing];
//        [bself.tableView reloadData];
//    });
}



#pragma mark -- 获取贷款分销推广海报数据
//获取banner
-(void)getLoadSharePosterSource:(void(^)(BOOL isSuccess))callBack{
    WS(wSelf);
    [XBJinRRNetworkApiManager getAdsWithAid:@"6" num:@"10" block:^(id data) {
        callBack(YES);
        if (rusultIsCorrect) {
            NSArray *bannerArray = [XBJinRRHomeBannerModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            wSelf.bannerArray = bannerArray.mutableCopy;
            [wSelf.tableView.mj_header endRefreshing];
            [wSelf.tableView reloadData];
        }else{
        }
        
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}
-(void)setBannerArray:(NSMutableArray *)bannerArray{
    NSMutableArray *mArr  = [NSMutableArray new];
    for (int i=0; i<bannerArray.count; i++) {
        XBJinRRHomeBannerModel *model = bannerArray[i];
        [mArr addObject:model.Pic];
    }
    self.cycleScrollView.imageURLStringsGroup  = mArr;
    
}


#pragma mark -- 获取贷款分销客户列表信息
- (void )getLoadShareCustomerWithDate:(void(^)(BOOL isSuccess))callBack{
    WS(bself);
    [XBJinRRNetworkApiManager getLoadShareCustomerWithID:self.model.ID Block:^(id data) {
        callBack(YES);
        MyLog(@"分销推广客户列表  --- %@",data);
        if (rusultIsCorrect) {
            NSDictionary *dataDic = data[@"data"];
            NSArray *arr = [XBJinRR_LoadShareCustomerModel mj_objectArrayWithKeyValuesArray:dataDic[@"lists"]];
            bself.customerList = arr.mutableCopy;
            bself.iteminfo = dataDic[@"iteminfo"];
            [bself.tableView reloadData];
            [bself.tableView.mj_header endRefreshing];
        }
    } fail:^(NSError *errorString) {
        callBack(NO);
    }];
}



#pragma mark - 头部轮播

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"cycleScrollView_icon"]];
        //    cycleScrollView.imageURLStringsGroup = imageUrlArr;
        [self.view addSubview:cycleScrollView];
        _cycleScrollView = cycleScrollView;
    }
    return _cycleScrollView;
}


#pragma mark -- 展示表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[XBJinRR_LoadShareJoinStyleCell class] forCellReuseIdentifier:@"XBJinRR_LoadShareJoinStyleCell"];
    [_tableView registerClass:[XBJinRR_LoadShareSalaryDescriptionCell class] forCellReuseIdentifier:@"XBJinRR_LoadShareSalaryDescriptionCell"];
    [_tableView registerClass:[XBJinRR_LoadShareProductCell class] forCellReuseIdentifier:@"XBJinRR_LoadShareProductCell"];
    [_tableView registerClass:[XBJinRR_LoadShareChartsCell class] forCellReuseIdentifier:@"XBJinRR_LoadShareChartsCell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRBigBankCardCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRBigBankCardCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRNewSalaryDesCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRNewSalaryDesCell"];
    self.tableView.tableHeaderView = self.cycleScrollView;
    
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
    if (self.customerList.count>0) {
        return self.sectionTitles.count;
    }
    return self.sectionTitles.count-1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==self.sectionTitles.count-1) {
        return self.customerList.count+1;
    }
    if (section==1) {
        NSArray *arr = self.iteminfo[@"PartType"];
        if (arr.count>0) {
            return 1;
        }
        else{
            return 0;
        }
    }
    if (section==2) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SIZE(150);
    }
    if (indexPath.section==1) {
        NSMutableString *mStr = [NSMutableString new];
        NSArray *arr = self.iteminfo[@"PartType"];//isEmptyStr(self.iteminfo[@"PartType"])?@[]:[self.iteminfo[@"PartType"] componentsSeparatedByString:@","];
        for (int i=0; i<arr.count; i++) {
            [mStr appendString:[NSString stringWithFormat:@"· %@\n",arr[i]]];
        }
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle1.lineSpacing = 10;
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:mStr attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
        CGFloat height = [LLUtils getAttributedStringHeight:attri1];
        return arr.count>0?height+20:0.001;
    }
    else if (indexPath.section == 2) {
        
        if (indexPath.row==0) {
            NSMutableString *mStr = [NSMutableString new];
            NSArray *arr = self.iteminfo[@"FeeIntro"];//isEmptyStr(self.iteminfo[@"FeeIntro"])?@[]:[self.iteminfo[@"FeeIntro"] componentsSeparatedByString:@","];
            for (int i=0; i<arr.count; i++) {
                [mStr appendString:[NSString stringWithFormat:@"· %@\n",arr[i]]];
            }
            NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle1.lineSpacing = 10;
            NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:mStr attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
            CGFloat height = [LLUtils getAttributedStringHeight:attri1];
            return arr.count>0?height+20:0.001;
        }else if (indexPath.row==1){
            return SIZE(200);
        }else{
            NSMutableString *mStr = [NSMutableString new];
            NSArray *arr = self.iteminfo[@"AccountType"];// isEmptyStr(self.iteminfo[@"AccountType"])?@[]:[self.iteminfo[@"AccountType"] componentsSeparatedByString:@","];
            for (int i=0; i<arr.count; i++) {
                [mStr appendString:[NSString stringWithFormat:@"· %@\n",arr[i]]];
            }
            NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle1.lineSpacing = 10;
            NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:mStr attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
            CGFloat height = [LLUtils getAttributedStringHeight:attri1];
            return arr.count>0?height+20:0.001;
        }

    }
    return SIZE(50);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XBJinRRBigBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRBigBankCardCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.bankCardImageView sd_setImageWithURL:[NSURL URLWithString:self.model.Logurl]];
        cell.bankNameLabel.text = self.model.Name;
        return cell;
    }
    if (indexPath.section == 1) {
//        XBJinRR_LoadShareJoinStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_LoadShareJoinStyleCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
        NSArray *arr = self.iteminfo[@"PartType"];//isEmptyStr(self.iteminfo[@"PartType"])?@[]:[self.iteminfo[@"PartType"] componentsSeparatedByString:@","];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        
        NSMutableString *mStr = [NSMutableString new];
        for (int i=0; i<arr.count; i++) {
            [mStr appendString:[NSString stringWithFormat:@"· %@\n",arr[i]]];
        }
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle1.lineSpacing = 10;
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:mStr attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
        cell.textLabel.attributedText = attri1;
        return cell;
    }
    else if (indexPath.section == 2) {
        if (indexPath.row==1) {
            XBJinRRNewSalaryDesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRNewSalaryDesCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.infoDic = self.iteminfo;
            return cell;
        }else{
            
            NSArray *arr ;
            if (indexPath.row==0) {
                arr = self.iteminfo[@"FeeIntro"];//isEmptyStr(self.iteminfo[@"FeeIntro"])?@[]:[self.iteminfo[@"FeeIntro"] componentsSeparatedByString:@","];
            }else{
                arr = self.iteminfo[@"AccountType"];//isEmptyStr(self.iteminfo[@"AccountType"])?@[]:[self.iteminfo[@"AccountType"] componentsSeparatedByString:@","];
            }
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.numberOfLines = 0;
            
            NSMutableString *mStr = [NSMutableString new];
            for (int i=0; i<arr.count; i++) {
                [mStr appendString:[NSString stringWithFormat:@"· %@\n",arr[i]]];
            }
            NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle1.lineSpacing = 10;
            NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:mStr attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
            
            NSMutableParagraphStyle *paragraphStyle0 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle0.lineSpacing = 10;
            NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:arr.count>0?indexPath.row==0?@"工资介绍\n":@"结算方式\n":@"" attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(66, 66, 66),NSParagraphStyleAttributeName:paragraphStyle0}];
            
            [attri0 appendAttributedString:attri1];
            
            cell.textLabel.attributedText = attri0;
            return arr.count>0?cell:[UITableViewCell new];
        }
    }
    else if (indexPath.section == 3) {
        
        XBJinRR_LoadShareChartsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_LoadShareChartsCell"];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            [cell setChart:@"名次" phoneNumber:@"手机号" loadMoney:@"放款金额(万元)" isHiddenLineAndShowLayer:NO chartLabelColor:nil];
        }
        else if (indexPath.row == 1){
            XBJinRR_LoadShareCustomerModel *tmodel = self.customerList[indexPath.row-1];
            UIColor *bgColor = RGB(251, 100, 0);
            [cell setChart:[NSString stringWithFormat:@"%ld",indexPath.row] phoneNumber:tmodel.Mobile loadMoney:tmodel.Money isHiddenLineAndShowLayer:YES chartLabelColor:bgColor];
        }
        else if (indexPath.row == 2){
            XBJinRR_LoadShareCustomerModel *tmodel = self.customerList[indexPath.row-1];
            UIColor *bgColor = RGB(252, 173, 0);
            [cell setChart:[NSString stringWithFormat:@"%ld",indexPath.row] phoneNumber:tmodel.Mobile loadMoney:tmodel.Money isHiddenLineAndShowLayer:YES chartLabelColor:bgColor];
        }
        else if (indexPath.row == 3){
            XBJinRR_LoadShareCustomerModel *tmodel = self.customerList[indexPath.row-1];
            UIColor *bgColor = RGB(255, 203, 84);
            [cell setChart:[NSString stringWithFormat:@"%ld",indexPath.row] phoneNumber:tmodel.Mobile loadMoney:tmodel.Money isHiddenLineAndShowLayer:YES chartLabelColor:bgColor];
        }
        else{
            XBJinRR_LoadShareCustomerModel *tmodel = self.customerList[indexPath.row-1];
            [cell setChart:[NSString stringWithFormat:@"%ld",indexPath.row] phoneNumber:tmodel.Mobile loadMoney:tmodel.Money isHiddenLineAndShowLayer:YES chartLabelColor:[UIColor whiteColor]];
        }
        
        return cell;
    }
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- tableView头部视图 
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        NSArray *arr = self.iteminfo[@"PartType"];
        return  arr.count>0?SIZE(50):0.001;
    }
    return SIZE(50);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        NSArray *arr = self.iteminfo[@"PartType"];
        if (arr.count>0) {
            NSDictionary *titleInfoDic = self.sectionTitles[section];
            XBJinRR_NormalHeaderView *headerView = [[XBJinRR_NormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50))];
            headerView.titleStr  = [NSString stringWithFormat:@"%@",titleInfoDic[@"titleStr"]];
            headerView.desStr  = [NSString stringWithFormat:@"%@",titleInfoDic[@"desStr"]];
            return headerView;
        }else{
            return [UIView new];
        }
    }
    NSDictionary *titleInfoDic = self.sectionTitles[section];
    XBJinRR_NormalHeaderView *headerView = [[XBJinRR_NormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50))];
    headerView.titleStr  = [NSString stringWithFormat:@"%@",titleInfoDic[@"titleStr"]];
    headerView.desStr  = [NSString stringWithFormat:@"%@",titleInfoDic[@"desStr"]];
    return headerView;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.customerList.count>0) {
        if (section == 3) {
            return SIZE(100);
        }else{
            return 0.001;
        }
    }else{
        if (section == 2) {
            return SIZE(100);
        }else{
            return 0.001;
        }
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.customerList.count>0) {
        if (section == 3) {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(70))];
            bgView.backgroundColor = [UIColor clearColor];
            UIButton *codeImageBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(30), SIZE(20), SCREEN_WIDTH-SIZE(60), SIZE(50)) title:@"立即生成二维码" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
            codeImageBtn.layer.masksToBounds = YES;
            codeImageBtn.layer.cornerRadius = SIZE(25);
            [codeImageBtn addTarget:self action:@selector(codeImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:codeImageBtn];
            return bgView;
        }else{
            return [UIView new];
        }
    }else{
        if (section == 2) {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(70))];
            bgView.backgroundColor = [UIColor clearColor];
            UIButton *codeImageBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(30), SIZE(20), SCREEN_WIDTH-SIZE(60), SIZE(50)) title:@"立即生成二维码" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
            codeImageBtn.layer.masksToBounds = YES;
            codeImageBtn.layer.cornerRadius = SIZE(25);
            [codeImageBtn addTarget:self action:@selector(codeImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:codeImageBtn];
            return bgView;
        }else{
            return [UIView new];
        }
    }
    
}



#pragma mark -- 生成二维码按钮被点击
- (void )codeImageBtnClick{
   
    if (isEmptyStr([UDefault getObject:TOKEN])) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    
    
    XBJinRR_LoadShareMyPosterImageViewController *vc = [XBJinRR_LoadShareMyPosterImageViewController new];
    vc.ID = self.model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
