//
//  kkkkDongTaiVC.m
//  Jinrirong
//
//  Created by zk on 2019/5/9.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import "kkkkDongTaiVC.h"
#import "kkkkDongTaiAddVC.h"
#import "kkkkDongTaiCell.h"
#import "kkkkDongTaiDetailVC.h"
@interface kkkkDongTaiVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation kkkkDongTaiVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的动态";
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
   
    [button setTitle:@"添加" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"kkkkDongTaiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)getData {
    
    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    BOOL isOpen = [db open];
    NSString * sql = [NSString stringWithFormat:@"select * from kkkk_mineDongTai where userId=%@",[UDefault getObject:@"phone"]];
    
    if (isOpen) {
        [self.dataArray removeAllObjects];
       FMResultSet * result = [db executeQuery:sql];
        while ([result next]) {
            kkkkModel * model = [[kkkkModel alloc] init];
            model.ID = [result stringForColumn:@"ID"];
            model.title = [result stringForColumn:@"title"];
            model.content = [result stringForColumn:@"content"];
            model.userId = [result stringForColumn:@"userId"];
            model.like = [result intForColumn:@"like"];
            model.scan = [result intForColumn:@"scan"];
            [self.dataArray insertObject:model atIndex:0];
            
        }
        [self.tableView reloadData];
        [db close];
    }else {
        [SVProgressHUD showErrorWithStatus:@"服务异常!"];
    }
    
    
    
    
}

- (void)add{
  
    kkkkDongTaiAddVC * vc =[[kkkkDongTaiAddVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    kkkkModel * model = self.dataArray[indexPath.row];
    kkkkDongTaiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = model.title;
    cell.contentLB.text = model.content;
    [cell.scanBt setTitle:[NSString stringWithFormat:@"查看 %ld",model.scan] forState:UIControlStateNormal];
    [cell.likeBt setTitle:[NSString stringWithFormat:@"喜欢 %ld",model.like] forState:UIControlStateNormal];
    cell.likeBt.tag =indexPath.row;
    [cell.likeBt addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)likeAction:(UIButton *)button {
    kkkkModel * model = self.dataArray[button.tag];
    NSString * sql =  [NSString stringWithFormat:@"update kkkk_mineDongTai set like = %ld where ID = %@",model.like + 1 ,model.ID];
    
    FMDatabase * db =[FMDBSingle shareFMDB].fd;
    if ([db open]) {
        BOOL delete = [db executeUpdate:sql ];
        if (delete) {
            
            model.like++;
            [self.tableView reloadData];
       
            };
        }else {
            NSLog(@"%@",@"失败");
        }
    
     [db close];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kkkkModel * model = self.dataArray[indexPath.row];
    kkkkDongTaiDetailVC * vc =[[kkkkDongTaiDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
