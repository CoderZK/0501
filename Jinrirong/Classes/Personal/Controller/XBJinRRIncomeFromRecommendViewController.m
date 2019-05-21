//
//  XBJinRRIncomeFromRecommendViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//  推广收入

#import "XBJinRRIncomeFromRecommendViewController.h"
#import "XBJinRRIncomeFromRecommendCell.h"
#import "XBJinRRCreditReportingListCell.h"
#import "XBJinRRPromotdataModel.h"
#import "XBJinRRMakeincomeModel.h"
#import "HMPopMenu.h"

@interface XBJinRRIncomeFromRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;//后台要求0位默认第一页
    UIView *bgView;
    UILabel *desLabel;
}
/**
 *  网贷按钮
 */
@property(nonatomic, strong)UIButton *loanBtn;
/**
 *  信用卡按钮
 */
@property(nonatomic, strong)UIButton *creditBtn;
/**
 *  征信按钮
 */
@property(nonatomic, strong)UIButton *creditReportingBtn;

/**
 *  达标按钮
 */
@property(nonatomic, strong)UIButton *reachBtn;
/**
 *  待达标按钮
 */
@property(nonatomic, strong)UIButton *unreachBtn;
//@property(nonatomic, strong)UIView *descriptionView;

@property(nonatomic, strong)UITableView *tableView;

/**
 *  当前选中的是哪个按钮 0网贷|1信用卡|2征信
 */
@property(nonatomic, copy)NSString *whichBtn;
/**
 *  是否已达标 0待达标|1已达标
 */
@property(nonatomic, copy)NSString *isReach;
/**
 *  网贷|信用卡 数据源数组
 */
@property(nonatomic, strong)NSMutableArray *sourceDataArray;
/**
 *  征信数据
 */
@property(nonatomic, strong)NSMutableArray *makeincomeDataArray;
@end

@implementation XBJinRRIncomeFromRecommendViewController
-(NSMutableArray *)makeincomeDataArray{
    if (!_makeincomeDataArray) {
        _makeincomeDataArray = [NSMutableArray new];
    }
    return _makeincomeDataArray;
}
-(NSMutableArray *)sourceDataArray{
    if (!_sourceDataArray) {
        _sourceDataArray = [NSMutableArray new];
    }
    return _sourceDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NORMAL_BGCOLOR;
    self.whichBtn = @"0";
    self.isReach = @"0";
    page = 0;
    [self creatTopViewUI];
    [self initTableView];
    [self addRefresh];
}

- (void)buttonMoney:(UITapGestureRecognizer *)tap{
    
    HMPopMenu *popMenu = [[HMPopMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [popMenu showInRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

#pragma mark -- 头部ui
- (void )creatTopViewUI{
    bgView = [ViewCreate createLineFrame:CGRectMake(0,NAV_HEIGHT+44, SCREEN_WIDTH, SIZE(140)) backgroundColor:WhiteColor];
//    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    UIView *line0 = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(10)) backgroundColor:NORMAL_BGCOLOR];
    [bgView addSubview:line0];
    
    CGFloat width = SCREEN_WIDTH/3.f;
    self.loanBtn = [ViewCreate createButtonFrame:CGRectMake(0,SIZE(10), width, SIZE(50)) title:@"网贷" titleColor:MainColor font:FONT(17) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    self.loanBtn.tag = 10010;
    [self.loanBtn addTarget:self action:@selector(checkDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.loanBtn];
    
    self.creditBtn = [ViewCreate createButtonFrame:CGRectMake(width,SIZE(10) , width, SIZE(50)) title:@"信用卡" titleColor:BlackColor font:FONT(17) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    self.creditBtn.tag = 10011;
    [self.creditBtn addTarget:self action:@selector(checkDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.creditBtn];
    
    self.creditReportingBtn = [ViewCreate createButtonFrame:CGRectMake(width*2,SIZE(10), width, SIZE(50)) title:@"征信" titleColor:BlackColor font:FONT(17) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    self.creditReportingBtn.tag = 10012;
    [self.creditReportingBtn addTarget:self action:@selector(checkDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.creditReportingBtn];
    
    
//    self.descriptionView = [ViewCreate createLineFrame:CGRectMake(0, SIZE(60), SCREEN_WIDTH, SIZE(30)) backgroundColor:NORMAL_BGCOLOR];
//    [bgView addSubview:self.descriptionView];
    
    desLabel = [ViewCreate createLabelFrame:CGRectMake(SIZE(10), SIZE(60), SCREEN_WIDTH-SIZE(20), SIZE(30)) backgroundColor:ClearColor text:@"" textColor:RGB(166, 166, 166) textAlignment:Left font:FONT(15)];
    desLabel.numberOfLines = 2;
    NSMutableAttributedString *atrri0 = [[NSMutableAttributedString alloc] initWithString:@"温馨提示：" attributes:@{NSFontAttributeName:FONT(10),NSForegroundColorAttributeName:MainColor}];
    NSMutableAttributedString *atrri1 = [[NSMutableAttributedString alloc] initWithString:@"该明细在介绍页提交信息的客户记录，不能视为申请订单" attributes:@{NSFontAttributeName:FONT(10),NSForegroundColorAttributeName:RGB(166, 166, 166)}];
    [atrri0 appendAttributedString:atrri1];
    desLabel.attributedText = atrri0;
    [bgView addSubview:desLabel];
    
//    desLabel.userInteractionEnabled = YES;
//    self.descriptionView.userInteractionEnabled = YES;
    
    self.unreachBtn = [ViewCreate createButtonFrame:CGRectMake(0,SIZE(90), SCREEN_WIDTH*0.5, SIZE(40)) title:@"待达标" titleColor:MainColor font:FONT(17) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    self.unreachBtn.tag = 10013;
//    self.unreachBtn.backgroundColor = [UIColor redColor];
//    self.unreachBtn.userInteractionEnabled = NO;
    [self.unreachBtn addTarget:self action:@selector(checkDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.unreachBtn];
    
    UIImageView *imageMoney = [[UIImageView alloc] init];
    imageMoney.image = [UIImage imageNamed:@"moneysay"];
    imageMoney.frame = CGRectMake(0, 0, 20, 20);
    imageMoney.userInteractionEnabled = YES;
    imageMoney.center = CGPointMake(SCREEN_WIDTH/4 + 40,self.unreachBtn.frame.size.height/2);
    [self.unreachBtn addSubview:imageMoney];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonMoney:)];
    tapGesture.numberOfTapsRequired = 1;
    [imageMoney addGestureRecognizer:tapGesture];
    
//    UIButton *button = [[UIButton alloc] init];
//    [button addTarget:self action:@selector(buttonMoney) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 0, 20, 20);
//    //    button.backgroundColor = [UIColor redColor];
//    [imageMoney addSubview:button];
    
    self.reachBtn = [ViewCreate createButtonFrame:CGRectMake(SCREEN_WIDTH*0.5,SIZE(90), SCREEN_WIDTH*0.5, SIZE(40)) title:@"已达标" titleColor:BlackColor font:FONT(17) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    self.reachBtn.tag = 10014;
    [self.reachBtn addTarget:self action:@selector(checkDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.reachBtn];
}
- (void )checkDataBtnClick:(UIButton *)sender{
    
    
    page = 0;
    self.makeincomeDataArray = nil;
    self.sourceDataArray = nil;
    switch (sender.tag) {
        case 10010:
            //网贷
        {
            self.whichBtn = @"0";
            self.isReach = @"0";

            [self.loanBtn setTitleColor:MainColor forState:UIControlStateNormal];
            [self.reachBtn setTitleColor:BlackColor forState:UIControlStateNormal];

            [self.creditBtn setTitleColor:BlackColor forState:UIControlStateNormal];
            [self.creditReportingBtn setTitleColor:BlackColor forState:UIControlStateNormal];
            [self.unreachBtn setTitleColor:MainColor forState:UIControlStateNormal];

            self.reachBtn.hidden = NO;
            self.unreachBtn.hidden = NO;
            desLabel.hidden = NO;
            [bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(NAV_HEIGHT);
                make.left.right.offset(0);
                make.height.mas_equalTo(SIZE(140));
            }];
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.loanBtn.mas_bottom).offset(SIZE(80));
                make.left.right.bottom.mas_offset(0);
            }];
        }
            break;
        case 10011:
            //信用卡
        {
            self.whichBtn = @"1";
            self.isReach = @"0";

            [self.loanBtn setTitleColor:BlackColor forState:UIControlStateNormal];
            [self.reachBtn setTitleColor:BlackColor forState:UIControlStateNormal];

            [self.creditBtn setTitleColor:MainColor forState:UIControlStateNormal];
            [self.creditReportingBtn setTitleColor:BlackColor forState:UIControlStateNormal];
            [self.unreachBtn setTitleColor:MainColor forState:UIControlStateNormal];

            self.reachBtn.hidden = NO;
            self.unreachBtn.hidden = NO;
            desLabel.hidden = NO;
            [bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(NAV_HEIGHT);
                make.left.right.offset(0);
                make.height.mas_equalTo(SIZE(140));
            }];
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.loanBtn.mas_bottom).offset(SIZE(80));
                make.left.right.bottom.mas_offset(0);
            }];
        }
            break;
        case 10012:
            //征信
        {
//            page = 1;
            self.whichBtn = @"2";
            self.isReach = @"0";


            [self.loanBtn setTitleColor:BlackColor forState:UIControlStateNormal];
            [self.reachBtn setTitleColor:BlackColor forState:UIControlStateNormal];

            [self.creditBtn setTitleColor:BlackColor forState:UIControlStateNormal];
            [self.creditReportingBtn setTitleColor:MainColor forState:UIControlStateNormal];
            [self.unreachBtn setTitleColor:BlackColor forState:UIControlStateNormal];

            self.reachBtn.hidden = YES;
            self.unreachBtn.hidden = YES;
            desLabel.hidden = YES;
//            CGRectMake(0,NAV_HEIGHT+44, SCREEN_WIDTH, SIZE(140))
            [bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(NAV_HEIGHT);
                make.left.right.offset(0);
                make.height.mas_equalTo(SIZE(60));
            }];
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.loanBtn.mas_bottom).offset(0);
                make.left.right.mas_offset(0);
                 make.bottom.mas_offset(-25);
            }];

        }
            break;
        case 10013:
            //待达标
        {
            self.isReach = @"0";
            [self.reachBtn setTitleColor:BlackColor forState:UIControlStateNormal];
            [self.unreachBtn setTitleColor:MainColor forState:UIControlStateNormal];
        }
            break;
        case 10014:
            //已达标
        {
            self.isReach = @"1";
            [self.reachBtn setTitleColor:MainColor forState:UIControlStateNormal];
            [self.unreachBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        }
            break;

        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
}
//刷新控件
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page=0;
        if ([bself.whichBtn isEqualToString:@"2"]) {
            [bself loadData];
        }else{
            [bself requestData];
        }
        
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page ++;
        if ([bself.whichBtn isEqualToString:@"2"]) {
            [bself loadData];
        }else{
            [bself requestData];
        }
    }];
}




//征信数据请求
- (void )loadData{
    WS(bself);
    NSDictionary *params = @{@"type":@"4",@"page":@(page),@"rows":@"10"};
    [XBJinRRNetworkApiManager makeincomeWithParams:params Block:^(id data) {
            [bself.tableView.mj_header endRefreshing];
            [bself.tableView.mj_footer endRefreshing];
            if (rusultIsCorrect) {
                NSArray *arr = [XBJinRRMakeincomeModel mj_objectArrayWithKeyValuesArray:[[Security shareSecurity] decryptDicAES256Data:data[@"data"]]];
                if (self->page>0) {
                    [bself.makeincomeDataArray addObjectsFromArray:arr];
                }else{
                    bself.makeincomeDataArray = arr.mutableCopy;
                }
                
            }else{
                if (self->page>0) {
                    
                }else{
                    bself.makeincomeDataArray = nil;
                }
            }
            [bself.tableView reloadData];
        
    } fail:^(NSError *errorString) {
        
    }];
}





//网贷|信用卡数据请求
- (void)requestData
{
    WS(bself);
    NSString *Itype;
    if ([self.whichBtn isEqualToString:@"0"]) {
        Itype = @"1";
    }
    if ([self.whichBtn isEqualToString:@"1"]) {
        Itype = @"2";
    }
    
    NSDictionary *params = @{@"Itype":Itype,@"isdab":self.isReach,@"page":@(page),@"rows":@"10"};
    [XBJinRRNetworkApiManager getpromotdataWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRPromotdataModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
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
        
    }];
}

#pragma mark -- 表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = RGB(245, 245, 245);
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRIncomeFromRecommendCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRIncomeFromRecommendCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRCreditReportingListCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRCreditReportingListCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loanBtn.mas_bottom).offset(SIZE(80));
        make.left.right.bottom.mas_offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.whichBtn isEqualToString:@"2"]) {
        return self.makeincomeDataArray.count;
    }
    return self.sourceDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.whichBtn isEqualToString:@"2"]) {
        return 70;
    }
    return 131;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.whichBtn isEqualToString:@"2"]) {
        XBJinRRCreditReportingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCreditReportingListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.makeincomeDataArray.count>0) {
            XBJinRRMakeincomeModel *model = self.makeincomeDataArray[indexPath.row];
            cell.tModel = model;
        }
        
        return cell;
    }else{
        XBJinRRIncomeFromRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRIncomeFromRecommendCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.sourceDataArray.count>0) {
            XBJinRRPromotdataModel *model = self.sourceDataArray[indexPath.row];
            cell.tModel = model;
        }
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
