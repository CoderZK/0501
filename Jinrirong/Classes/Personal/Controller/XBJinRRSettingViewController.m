//
//  XBJinRRSettingViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/16.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRSettingViewController.h"
#import "XBJinRR_ChangePwdViewController.h"

@interface XBJinRRSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *aTableView;
/**
 *  数据源
 */
@property(nonatomic, strong)NSMutableArray *sourceData;
@end

@implementation XBJinRRSettingViewController
-(NSMutableArray *)sourceData{
    if (!_sourceData) {
        _sourceData = [NSMutableArray new];
        _sourceData = [@[@[@{@"title":@"修改登录密码",@"content":@""}],@[@{@"title":@"清理缓存",@"content":@"0kb"},@{@"title":@"关于我们",@"content":@""}],@[@{@"title":@"版本介绍",@"content":@""}],@[@{@"title":@"退出登录",@"content":@""}]] mutableCopy];
    }
    return _sourceData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"设置"];
    [self setNavWithTitle:@"设置" isShowBack:YES];
    [self createUI];
    
}

- (void)createUI
{
   self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)) style:UITableViewStyleGrouped];
    self.aTableView.dataSource = self;
    self.aTableView.delegate = self;
    [self.view addSubview:self.aTableView];
    
//    [self.aTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myUITableViewCell"];
    
    if (@available(iOS 11.0,*)) {
        self.aTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.aTableView.estimatedRowHeight = 0;
        self.aTableView.estimatedSectionFooterHeight = 0;
        self.aTableView.estimatedSectionHeaderHeight = 0;
    }
    [self.aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
}
#pragma mark - UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sourceData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr  = self.sourceData[section];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE(55);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myUITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myUITableViewCell"];
    }
    
    
    NSArray *arr = self.sourceData[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    
    
    if (indexPath.section == 3) {
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(55))];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = RGB(71, 71, 71);
        titleLable.font = FONT(17);
        titleLable.text = dic[@"title"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell addSubview:titleLable];
    }else{
        cell.textLabel.text = dic[@"title"];
        
        if (indexPath.section == 1&&indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            MyLog(@"内存 --- %@",[NSString stringWithFormat:@"%1.fM",[LLUtils filePath]]);
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.fM",[LLUtils filePath]];
        }else{
            cell.detailTextLabel.text = dic[@"content"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.textColor = RGB(71, 71, 71);
        cell.detailTextLabel.textColor = RGB(133, 133, 133);
        cell.textLabel.font = FONT(17);
        cell.detailTextLabel.font = FONT(17);
    }
    
    
   
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(bself);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==0&&indexPath.row==0) {
        XBJinRR_ChangePwdViewController *vc  = [XBJinRR_ChangePwdViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    if (indexPath.section==1&&indexPath.row==0) {
        [XBJinRR_CustomerView alertViewWithTitle:@"确定要清理吗？" Content:@"" yesBtnTitle:@"确定" cancelBtnTitle:@"取消" CancelBtClcik:^{
        } sureBtClcik:^{
            [LLUtils clearFileBlock:^{
                [Dialog toastCenter:@"清除成功!"];
                [bself.aTableView reloadData];
            }];
        }];
    }
    if (indexPath.section == 3&&indexPath.row==0) {
        [LLUtils showAlterView:self title:@"确定要退出登录吗?" message:@"" yesBtnTitle:@"确定" noBtnTitle:@"取消" yesBlock:^{
            [bself signOut];
        } noBlock:^{
            
        }];
    }
    
    if (indexPath.section == 1&&indexPath.row==1) {
        XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
        [vc setUrl:nil webType:WebTypeAboutUs];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 2&&indexPath.row==0) {
        XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
        [vc setUrl:nil webType:WebTypeVersionDes];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark -- 退出登录的逻辑
- (void )signOut{
    WS(bself);
    [self.view showLoadMessageAtCenter:@"退出中..."];
    [XBJinRRNetworkApiManager logOutBlock:^(id data) {
        [bself.view hide];
        [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        if (rusultIsCorrect) {
            [UDefault removeObject:TOKEN];
            [UDefault removeObject:MD5KEY];
            [UDefault removeObject:MD5IV];
            [UDefault removeObject:USERNUMBER]; 
//            [NSNotic_Center postNotificationName:SIGNOUTSUCCESS object:nil];
            bself.tabBarController.selectedIndex = 0;
            [bself.navigationController popViewControllerAnimated:YES];
        } 
        
    } fail:^(NSError *errorString) {
        [bself.view hide];
    }];
}









@end
