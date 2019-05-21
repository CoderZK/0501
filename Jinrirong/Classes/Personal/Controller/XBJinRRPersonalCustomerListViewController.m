//
//  XBJinRRPersonalCustomerListViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//  客户列表

#import "XBJinRRPersonalCustomerListViewController.h"
#import "XBJinRRCustomerListHeaderViewCell.h"
#import "XBJinRRCustomerListInfoCell.h"
#import "XBJinRRCustomerListInfoModel.h"
#import "DatePickerView.h"

@interface XBJinRRPersonalCustomerListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSString *nowDate;//当前时间
@property(nonatomic, assign)NSInteger page;
/**
 *  客户列表数组
 */
@property(nonatomic, strong)NSMutableArray *customerListArray;
@property(nonatomic, copy)NSString  *applyCount;
@end

@implementation XBJinRRPersonalCustomerListViewController
-(NSMutableArray *)customerListArray{
    if (!_customerListArray) {
        _customerListArray = [NSMutableArray new];
    }
    return _customerListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.applyCount = [NSString new];
    self.page = 0;
    self.nowDate = [LLUtils getLastMonthDateStr];
    [self initTableView];
    [self addRefresh];
    
}

#pragma mark -- 表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = RGB(243, 243, 243);
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRCustomerListHeaderViewCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRCustomerListHeaderViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRCustomerListInfoCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRCustomerListInfoCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-40);
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return self.customerListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 152;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(bself);
    if (indexPath.section ==0) {
        XBJinRRCustomerListHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCustomerListHeaderViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.timeLabel.text = self.nowDate;
        
        NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  共",self.nowDate] attributes:@{NSFontAttributeName:FONT(14),NSForegroundColorAttributeName:RGB(169, 169, 169)}];
        NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:self.applyCount attributes:@{NSFontAttributeName:FONT(16),NSForegroundColorAttributeName:MainColor}];
        NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:@"位申请" attributes:@{NSFontAttributeName:FONT(14),NSForegroundColorAttributeName:RGB(169, 169, 169)}];
        [attri0 appendAttributedString:attri1];
        [attri0 appendAttributedString:attri2];
        cell.desLabel.attributedText  = attri0;
        cell.refreshBlock = ^{
            [bself.tableView.mj_header beginRefreshing];
        };
        cell.clickBlock = ^{
            DatePickerView *dataPicker = [[DatePickerView alloc] init];
            [dataPicker show];
            
            dataPicker.DatePickerBlock = ^(NSString *dateString) {
                bself.nowDate = dateString;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
                [bself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            };
        };

        return cell;
    }else{
        XBJinRRCustomerListInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCustomerListInfoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        XBJinRRCustomerListInfoModel *model = self.customerListArray[indexPath.row];
        cell.tModel = model;
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    NSDictionary *params = @{@"dates":self.nowDate,@"page":@(self.page),@"rows":@"10"};
    MyLog(@"params  ---  %@",params);
    [XBJinRRNetworkApiManager getclientWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        MyLog(@"%@",data);
        if (rusultIsCorrect) {
            NSDictionary *dataDic = data[@"data"];
            bself.applyCount = dataDic[@"applytotal"];
            if (bself.page>0) {
                
                NSArray *arr = [XBJinRRCustomerListInfoModel mj_objectArrayWithKeyValuesArray:dataDic[@"info"]];
                [bself.customerListArray addObjectsFromArray:arr];
            }else{
                NSArray *arr = [XBJinRRCustomerListInfoModel mj_objectArrayWithKeyValuesArray:dataDic[@"info"]];
                bself.customerListArray = arr.mutableCopy;
            }
            
        }else{
            if (bself.page>0) {
                
            }else{
                bself.customerListArray = nil;
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
