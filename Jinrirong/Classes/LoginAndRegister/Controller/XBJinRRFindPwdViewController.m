//
//  XBJinRRFindPwdViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRFindPwdViewController.h"
#import "XBJinRR_InputTFCell.h"
#import "XBJinRR_GetCodeCell.h"
#import "XBJinRRCheckCodeView.h"
#import "XBJinRRCheckCodeModel.h"
#import "XBJinRR_ForgetPwdViewController.h"

@interface XBJinRRFindPwdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, assign)int timeCount;

@property (nonatomic,strong) XBJinRRCheckCodeView *checkCodeView;

@end

@implementation XBJinRRFindPwdViewController

-(NSTimer *)timer
{
    _timeCount = 60;
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
        //将定时器添加到runloop中
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
-(void)timeDown{
    
    XBJinRR_GetCodeCell *registerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [registerCell timeDown:_timeCount];
    _timeCount-- ;
    if (_timeCount < 0) {
        [_timer invalidate];
        _timer = nil;
        _timeCount = 10;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_timer setFireDate:[NSDate distantPast]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer setFireDate:[NSDate distantFuture]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"忘记密码"];
    [self setNavWithTitle:@"忘记密码" isShowBack:YES];
    [self initTableView];
    
    WS(bself);
    XBJinRRCheckCodeView *checkCodeView = [[XBJinRRCheckCodeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    checkCodeView.messageType = @"1";
    checkCodeView.picCodeSuccessBlock = ^{
        bself.timer;
    };
    self.checkCodeView = checkCodeView;
    
}

#pragma mark - - 创建表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];

    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRR_InputTFCell" bundle:nil] forCellReuseIdentifier:@"XBJinRR_InputTFCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRR_GetCodeCell" bundle:nil] forCellReuseIdentifier:@"XBJinRR_GetCodeCell"];
    
    
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
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        XBJinRR_InputTFCell *phoneTFCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_InputTFCell"];
        phoneTFCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return phoneTFCell;
    }else{
        WS(bself);
        XBJinRR_GetCodeCell *codeTFCell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRR_GetCodeCell"];
        codeTFCell.selectionStyle = UITableViewCellSelectionStyleNone;
        codeTFCell.getCodeBtnCliCkBlock = ^{
            [bself getCode];
            
        };
        return codeTFCell;
    }
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}


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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(80))];
    bgView.backgroundColor = [UIColor clearColor];
    UIButton *nextStepBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(30), SIZE(30), SCREEN_WIDTH-SIZE(60), SIZE(50)) title:@"下一步" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
    [nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:nextStepBtn];
    nextStepBtn.layer.masksToBounds = YES;
    nextStepBtn.layer.cornerRadius = SIZE(25);
    return bgView;
}

- (void )nextStepBtnClick{
    WS(bself);
    XBJinRR_GetCodeCell *registerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    XBJinRR_InputTFCell *codeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (isEmptyStr(registerCell.inputTF.text)||isEmptyStr(codeCell.codeInputTF.text)) {
        [Dialog toastCenter:@"手机号或验证码不能为空"];
        return;
    }
    NSDictionary *params = @{@"Mobile":registerCell.inputTF.text,@"Code":codeCell.codeInputTF.text};
    [XBJinRRNetworkApiManager checkCodeIsMatchWithPhoneByParams:params Block:^(id data) {
        if (rusultIsCorrect) {
            XBJinRR_ForgetPwdViewController *vc = [XBJinRR_ForgetPwdViewController new];
            vc.phoneNum = registerCell.inputTF.text;
            [bself.navigationController pushViewController:vc animated:YES];
        }else{
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        }
    } fail:^(NSError *errorString) {
        [Dialog toastCenter:@"网络错误"];
    }];
}





#pragma mark -- 获取验证码
- (void )getCode{
    XBJinRR_GetCodeCell *registerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([registerCell.inputTF.text isEqualToString:@""]) {
        [Dialog toastCenter:@"请输入手机号"];
        return;
    }
    WS(wSelf);
    [XBJinRRNetworkApiManager getCheckImgCodeWithBlock:^(id data) {
        XBJinRRCheckCodeModel *checkCodeModel = [XBJinRRCheckCodeModel mj_objectWithKeyValues:data[@"data"]];
        [wSelf.checkCodeView setPhone:registerCell.inputTF.text codePic:checkCodeModel.imgPath];
        [wSelf.checkCodeView show];

    } fail:^(NSError *errorString) {
        
    }];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
