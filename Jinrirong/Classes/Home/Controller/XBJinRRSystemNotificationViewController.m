//
//  XBJinRRSystemNotificationViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//  系统公告列表

#import "XBJinRRSystemNotificationViewController.h"
#import "XBJinRRNewsListModel.h"
#import "XBJinRRNewsDetailViewController.h"

@interface XBJinRRSystemNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
/**
 *  新闻列表数组
 */
@property(nonatomic, strong)NSMutableArray *newsList;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation XBJinRRSystemNotificationViewController

-(NSMutableArray *)newsList{
    if (!_newsList) {
        _newsList = [NSMutableArray new];
    }
    return _newsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 0;
    [self setNavWithTitle:@"系统公告" isShowBack:YES];
    [self initTableView];
    [self addRefresh];
}



#pragma mark -- 表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
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
    return self.newsList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.font = FONT(15);
    cell.textLabel.textColor = RGB(66, 66, 66);
    cell.detailTextLabel.font = FONT(15);
    cell.detailTextLabel.textColor = RGB(66, 66, 66);
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    XBJinRRNewsListModel *model  = self.newsList[indexPath.row];
    NSString *titleStr = model.Title;
    if (titleStr.length>10) {
       titleStr = [titleStr substringToIndex:10];
    }
    cell.textLabel.text = titleStr;
    cell.detailTextLabel.text = model.AddTime;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBJinRRNewsDetailViewController *vc = [XBJinRRNewsDetailViewController new];
    XBJinRRNewsListModel *model  = self.newsList[indexPath.row];
    vc.tModel = model;
    vc.isNews = NO;
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

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
- (void )requestData{
    WS(bself);
    NSDictionary *params = @{@"cid":@"2",@"page":@(page),@"rows":@"10"};
    [XBJinRRNetworkApiManager getnewslistWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        if (rusultIsCorrect) {
            NSArray *arr = [XBJinRRNewsListModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            if (self->page>0) {
                [bself.newsList addObjectsFromArray:arr];
            }else{
                bself.newsList = arr.mutableCopy;
            }
            
        }else{
            if (self->page>0) {
                
            }else{
                bself.newsList = nil;
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
