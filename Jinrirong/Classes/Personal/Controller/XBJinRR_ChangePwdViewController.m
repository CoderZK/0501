//
//  XBJinRR_ChangePwdViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/21.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_ChangePwdViewController.h"
#import "XBJinRR_CustomerEditCell.h"

@interface XBJinRR_ChangePwdViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray *titles;
@end

@implementation XBJinRR_ChangePwdViewController
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@{@"title":@"原密码",@"placeholder":@"请输入原密码"},@{@"title":@"新密码",@"placeholder":@"请输入登录密码"},@{@"title":@"确认密码",@"placeholder":@"请再次输入密码"}];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"修改登录密码"];
    [self setNavWithTitle:@"修改登录密码" isShowBack:YES];
    [self initTableView];
}


#pragma mark -- 创建表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    if (@available (iOS 11.0,*)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRR_CustomerEditCell" bundle:nil] forCellReuseIdentifier:@"XBJinRR_CustomerEditCell"];
    [self.view addSubview:_tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBJinRR_CustomerEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_CustomerEditCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.titles[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"title"]];
    cell.inputTF.placeholder = [NSString stringWithFormat:@"%@",dic[@"placeholder"]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE(55);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SIZE(80);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgVIew = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(80)) backgroundColor:ClearColor];
    UIButton *submitBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(15), SIZE(20), SCREEN_WIDTH-SIZE(30), SIZE(50)) title:@"提交" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius  = SIZE(25);
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgVIew addSubview:submitBtn];
    return bgVIew;
}

#pragma mark -- 提交新密码
- (void )submitBtnClick{
    WS(bself);
    XBJinRR_CustomerEditCell *cell0 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
     XBJinRR_CustomerEditCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
     XBJinRR_CustomerEditCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    MyLog(@"%@-%@-%@",cell0.inputTF.text,cell1.inputTF.text,cell2.inputTF.text);
    
    if (isEmptyStr(cell0.inputTF.text)) {
        [Dialog toastCenter:@"请输入原密码"];
        return;
    }
    if (isEmptyStr(cell1.inputTF.text)||isEmptyStr(cell2.inputTF.text)) {
        [Dialog toastCenter:@"请输入新密码"];
        return;
    }
    if (![cell1.inputTF.text isEqualToString:cell2.inputTF.text]) {
        [Dialog toastCenter:@"两次密码不一致"];
        return;
    }
    
    if (cell1.inputTF.text.length>16) {
        [Dialog toastCenter:@"密码长度不能超过16位"];
        return;
    }
    NSDictionary *params = @{
                             @"oldpwd":[NSString stringWithFormat:@"%@",cell0.inputTF.text],
                             @"newpwd":[NSString stringWithFormat:@"%@",cell1.inputTF.text],
                             @"surepwd":[NSString stringWithFormat:@"%@",cell2.inputTF.text]
                             };
    MyLog(@"修改密码参数 ---- %@",params);
    [XBJinRRNetworkApiManager changePwdWithParams:params Block:^(id data) {
        MyLog(@"返回的数据 ---- %@",data);
        if (rusultIsCorrect) {
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            [bself.navigationController popViewControllerAnimated:YES];
        }else{
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        }
    } fail:^(NSError *errorString) {
        
    }];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
