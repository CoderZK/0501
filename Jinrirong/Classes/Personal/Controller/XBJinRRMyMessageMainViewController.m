//
//  XBJinRRMyMessageMainViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMyMessageMainViewController.h"
#import "XBJinRRMyMsgItemModel.h"
#import "XBJinRRMyMessageMainCell.h"
#import "XBJinRRMyMessageViewController.h"

@interface XBJinRRMyMessageMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *sysMsgArr;
@property (nonatomic,strong) NSMutableArray *normalMsgArr;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation XBJinRRMyMessageMainViewController

static NSString *XBJinRRMyMessageMainSystemCellID = @"XBJinRRMyMessageMainSystemCellID";
static NSString *XBJinRRMyMessageMainNormalCellID = @"XBJinRRMyMessageMainNormalCellID";

- (NSMutableArray *)sysMsgArr
{
    if (_sysMsgArr == nil) {
        _sysMsgArr = [NSMutableArray array];
    }
    return _sysMsgArr;
}

- (NSMutableArray *)normalMsgArr
{
    if (_normalMsgArr == nil) {
        _normalMsgArr = [NSMutableArray array];
    }
    return _normalMsgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setNavTitleStr:@"我的消息"];
    [self setNavWithTitle:@"我的消息" isShowBack:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self createUI];
    
    [self addRefresh];
}
- (void)createUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[XBJinRRMyMessageMainCell class] forCellReuseIdentifier:XBJinRRMyMessageMainSystemCellID];
    [tableView registerClass:[XBJinRRMyMessageMainCell class] forCellReuseIdentifier:XBJinRRMyMessageMainNormalCellID];
    
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
//刷新控件
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)loadData
{
    WS(bself);
    [XBJinRRNetworkApiManager getMyMsgWithBlock:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        NSArray *arr1 = [XBJinRRMyMsgItemModel mj_objectArrayWithKeyValuesArray:data[@"data"][0]];
        NSArray *arr2 = [XBJinRRMyMsgItemModel mj_objectArrayWithKeyValuesArray:data[@"data"][1]];
        NSMutableArray *totalArr = [NSMutableArray arrayWithArray:arr1];
        [totalArr addObjectsFromArray:arr2];
        
        self.sysMsgArr = nil;
        self.normalMsgArr = nil;
        for (XBJinRRMyMsgItemModel *model in totalArr) {
            if ([model.Type integerValue] == 0) {
                [self.sysMsgArr addObject:model];
            } else if ([model.Type integerValue] == 1) {
                [self.normalMsgArr addObject:model];
            }
        }
        
        [self.tableView reloadData];
        
    } fail:^(NSError *errorString) {
        [bself.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if (self.sysMsgArr.count > 0) {
        count +=1;
    }
    if (self.normalMsgArr.count > 0) {
        count +=1;
    }
    return count;
    
//    if (self.sysMsgArr.count > 0 && self.normalMsgArr.count > 0) {
//        return 2;
//    }
//    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (self.sysMsgArr.count > 0 && self.normalMsgArr.count > 0) {
        if (indexPath.row == 0) {
            XBJinRRMyMessageMainCell *sysMsgCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRMyMessageMainSystemCellID];
            sysMsgCell.myMsgItemModel = self.sysMsgArr[0];
            cell = sysMsgCell;
        } else {
            XBJinRRMyMessageMainCell *normalMsgCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRMyMessageMainNormalCellID];
            normalMsgCell.myMsgItemModel = self.normalMsgArr[0];
            cell = normalMsgCell;
        }
    }else{
        if (indexPath.row == 0) {
            if (self.sysMsgArr.count > 0) {
                XBJinRRMyMessageMainCell *sysMsgCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRMyMessageMainSystemCellID];
                sysMsgCell.myMsgItemModel = self.sysMsgArr[0];
                cell = sysMsgCell;
            }
            if (self.normalMsgArr.count > 0) {
                XBJinRRMyMessageMainCell *normalMsgCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRMyMessageMainNormalCellID];
                normalMsgCell.myMsgItemModel = self.normalMsgArr[0];
                cell = normalMsgCell;
            }
        }
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (self.sysMsgArr.count > 0 && self.normalMsgArr.count > 0) {
        XBJinRRMyMessageViewController *vc = [[XBJinRRMyMessageViewController alloc] init];
        if (indexPath.row == 0) {
            vc.dataArray = self.sysMsgArr;
            [self setreadsWithType:@"0"];
        } else if (indexPath.row == 1) {
            vc.dataArray = self.normalMsgArr;
            [self setreadsWithType:@"1"];
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        XBJinRRMyMessageViewController *vc = [[XBJinRRMyMessageViewController alloc] init];
        if (self.sysMsgArr.count > 0) {
            if (indexPath.row == 0) {
                vc.dataArray = self.sysMsgArr;
                [self setreadsWithType:@"0"];
            }
        }
        if (self.normalMsgArr.count > 0) {
            if (indexPath.row == 0) {
                vc.dataArray = self.normalMsgArr;
                [self setreadsWithType:@"1"];
            }
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}


- (void )setreadsWithType:(NSString *)type{
    WS(bself);
    [XBJinRRNetworkApiManager setreadsWithType:type Block:^(id data) {
        if(rusultIsCorrect ){
            bself.refreshBlock();
        }
    } fail:^(NSError *errorString) {
        
    }];
}








@end
