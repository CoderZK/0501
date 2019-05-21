//
//  kkkkHomeVC.m
//  Jinrirong
//
//  Created by zk on 2019/5/8.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import "kkkkHomeVC.h"
#import "kkkkHomeOneCell.h"
#import "kkkkHomeTwoCell.h"
#import "kkkkCell.h"
#import "kkkkDongTaiVC.h"
#import "kkkkDaKaVCViewController.h"
#import "kkkkGongZuoJiHuaListVC.h"
@interface kkkkHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong)UIButton *loanButton;

@end

@implementation kkkkHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.navigationItem.title = @"首页";
    

    
    [self.tableView registerNib:[UINib nibWithNibName:@"kkkkHomeOneCell" bundle:nil] forCellReuseIdentifier:@"cellone"];
    [self.tableView registerClass:[kkkkHomeTwoCell class] forCellReuseIdentifier:@"twoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1) {
        return 185;
    }else if (indexPath.section == 2) {
        return 60;
    }
    return 80;
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
    if (indexPath.section == 0) {
        kkkkHomeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellone" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        kkkkHomeTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        
        __weak typeof(self) weakSelf = self;
        
//        __weak kkkkHomeVC * weakSelf = self;
        
        
        cell.didIndexBlock = ^(NSInteger index) {
          
            if (index == 0) {
                kkkkDongTaiVC * vc =[[kkkkDongTaiVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if (index == 1) {
                
                kkkkDaKaVCViewController * vc =[[kkkkDaKaVCViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if (index == 2) {
                kkkkGongZuoJiHuaListVC * vc =[[kkkkGongZuoJiHuaListVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }

            
        };
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }else if (indexPath.section == 2) {
        
     
        
    }
    kkkkHomeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
