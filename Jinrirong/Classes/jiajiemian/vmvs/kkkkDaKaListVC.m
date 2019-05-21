//
//  kkkkDaKaListVC.m
//  Jinrirong
//
//  Created by zk on 2019/5/10.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import "kkkkDaKaListVC.h"
#import "kkkkDaKaListCell.h"
@interface kkkkDaKaListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation kkkkDaKaListVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"签到记录";
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    

    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"kkkkDaKaListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self getData];
}

- (void)getData {
    
    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    BOOL isOpen = [db open];
    
    NSString * sql = [NSString stringWithFormat:@"select *from kkkk_daKa where userId='%@'",[UDefault getObject:@"phone"]];
    if (isOpen) {
        
        FMResultSet * result = [db executeQuery:sql];
        [self.dataArray removeAllObjects];
        while ([result next]) {
            
            kkkkModel * model = [[kkkkModel alloc] init];
            model.ID = [result stringForColumn:@"ID"];
            model.userId = [result stringForColumn:@"userId"];
            model.time = [result stringForColumn:@"time"];
            model.des = [result stringForColumn:@"des"];

            [self.dataArray insertObject:model atIndex:0];
            
        }
        
        [self.tableView reloadData];
    }
    
    [db close];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    kkkkDaKaListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    kkkkModel * model = self.dataArray[indexPath.row];
    cell.desLB.text = [NSString stringWithFormat:@"签到描述: %@",model.des];
    cell.timeLB.text = [NSString stringWithFormat:@"签到时间: %@",model.time];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
