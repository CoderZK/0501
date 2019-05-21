//
//  XBTeamViewController.m
//  Jinrirong
//
//  Created by 少少 on 2019/1/21.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBTeamViewController.h"
#import "XBTeamModel.h"
#import "XBJinTeamCell.h"

#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface XBTeamViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *detailList;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation XBTeamViewController

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self.segmentedControl removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavWithTitle:@"" isShowBack:YES];
    
    _detailList = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self ;
    _tableView.delegate = self ;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self requestFirst];
    
}

- (void)requestFirst {
    
    [_detailList removeAllObjects];
    
    WS(bself);
    
    [XBJinRRNetworkApiManager centersWithType:@"1" MemberRecommendBlock:^(id data) {
        NSArray *dataArray = data[@"data"];
        
        NSLog(@"dataArray == %@",dataArray);
        
        for (NSDictionary *dic in dataArray) {
            
            XBTeamModel *detailModel = [[XBTeamModel alloc] initWithDictionary:dic];
            [bself.detailList addObject:detailModel];
        }
        
        NSLog(@"detailList == %@",bself.detailList);
        [bself.tableView reloadData];
        
    } fail:^(NSError *errorString) {
        
    }];
}

- (void)requestSecond {
    
    [_detailList removeAllObjects];
    
    WS(bself);
    
    [XBJinRRNetworkApiManager centersWithType:@"2" MemberRecommendBlock:^(id data) {
        NSArray *dataArray = data[@"data"];
        
        
        for (NSDictionary *dic in dataArray) {
            
            XBTeamModel *detailModel = [[XBTeamModel alloc] initWithDictionary:dic];
            [bself.detailList addObject:detailModel];
        }
        
        NSLog(@"detailList == %@",bself.detailList);
        [bself.tableView reloadData];
        
    } fail:^(NSError *errorString) {
        
    }];
    
}

-(void)change:(UISegmentedControl*)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            
             [self requestFirst];
            break;
        case 1:
            
           [self requestSecond];

            break;

        default:
            break;
    }
}

#pragma mark - 设置导航栏
- (void)setNavWithTitle:(NSString *)title isShowBack:(BOOL)isShowBack{
    
    if (isShowBack) {
        
        NSArray *array = @[@"直属团队",@"二级团队"];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:array];
        segmentedControl.frame = CGRectMake(100, 10, 200, 30);
        segmentedControl.layer.cornerRadius = 15.0f;
        segmentedControl.layer.borderWidth = 1.5;
        segmentedControl.tintColor = [UIColor whiteColor];

        segmentedControl.layer.borderColor = [UIColor whiteColor].CGColor;
        segmentedControl.layer.masksToBounds = YES;
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],UITextAttributeTextColor,nil];
        NSDictionary *dics = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor,nil];
        segmentedControl.selectedSegmentIndex = 0;

        [segmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
        [segmentedControl setTitleTextAttributes:dics forState:UIControlStateNormal];
        [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        self.segmentedControl = segmentedControl;
        [self.navigationController.navigationBar addSubview:self.segmentedControl];
        

        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.frame = CGRectMake(0, 0, 15, 20);
        [self.leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 2)];
        //        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn:)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.navigationItem.title = title;
 
}

#pragma mark - 导航栏点击方法
- (void)clickLeftBtn:(UIButton *)leftBtn;
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XBJinTeamCell *detailCell = [XBJinTeamCell cellWithTableView:tableView];
    
    detailCell.teamModel = [_detailList objectAtIndex:indexPath.row];
    
    return detailCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    HistoryPlayDetailViewController *histpryPalyDetai = [[HistoryPlayDetailViewController alloc] initWithNibName:NSStringFromClass([HistoryPlayDetailViewController class]) bundle:nil];
//    histpryPalyDetai.historyDetailModel = [_detailList objectAtIndex:indexPath.row];
//    histpryPalyDetai.dataSource = _detailList;
//    histpryPalyDetai.currentIndex = indexPath.row;
//    histpryPalyDetai.isPlay = YES;
//    [self.navigationController pushViewController:histpryPalyDetai animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_detailList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}


@end
