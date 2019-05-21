//
//  XBJinRRNewUserHelpViewController.m
//  Jinrirong
//
//  Created by 刘布斯 on 2018/6/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRNewUserHelpViewController.h"
#import "XBJinRRNewUserHelpModel.h"
#import "XBJinRRNewUserHelpSectionHeaderView.h"

@interface XBJinRRNewUserHelpViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSString *searchname;
    NSString *cateid;
}
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UISearchBar *searchBar;
@property(nonatomic, strong)NSMutableArray *sourceArray;
@end

@implementation XBJinRRNewUserHelpViewController
-(NSMutableArray *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray new];
    }
    return _sourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:@"新手帮助" isShowBack:YES];
    self.view.backgroundColor = WhiteColor;
    self.page = 0;
    searchname = @"";
    cateid = @"0";
    [self creatTopHeaderUI];
    [self initTableView];
    [self addRefresh];
}
#pragma mark -- 请求网络数据

-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page=0;
        [bself loadMainDataSource];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadMainDataSource];
    }];
}
- (void )loadMainDataSource{
    WS(bself);
    NSDictionary *params = @{@"cateid":cateid,@"words":searchname,@"page":@(self.page),@"rows":@"10"};
    [XBJinRRNetworkApiManager newerhelpsWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        if (rusultIsCorrect) {
            if (bself.page>0) {
                    
                NSArray *arr0 = [XBJinRRNewUserHelpModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                NSMutableArray *arr = [NSMutableArray new];
                for (int i = 0; i<arr0.count; i++) {
                    XBJinRRNewUserHelpModel *model = arr0[i];
                    model.isSelected = NO;
                    [arr addObject:model];
                }
                [bself.sourceArray addObjectsFromArray:arr];
            }else{
                NSArray *arr = [XBJinRRNewUserHelpModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                bself.sourceArray = arr.mutableCopy;
            }
            
        }else{
            if (bself.page>0) {
                
            }else{
                bself.sourceArray = nil;
            }
        }
        [bself.tableView reloadData];
    } fail:^(NSError *errorString) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark -- 创建头部搜索框
- (void )creatTopHeaderUI{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,NAV_HEIGHT, SCREEN_WIDTH, SIZE(50))];
    self.searchBar.placeholder = @"请输入关键字搜索";
    self.searchBar.delegate = self;
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.layer.cornerRadius = SIZE(15);
    self.searchBar.tintColor = RGB(238, 238, 238);
//    UIView *firstSubView = self.searchBar.subviews.firstObject;
//    firstSubView.backgroundColor = [UIColor whiteColor];
    UIImage *img = [LLUtils GetImageWithColor:[UIColor whiteColor] andHeight:SIZE(50)];
    //设置背景图片
    [_searchBar setBackgroundImage:img];
    //设置背景色
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    //设置文本框背景
    [_searchBar setSearchFieldBackgroundImage:[LLUtils GetImageWithColor:RGB(248, 248, 248) andHeight:SIZE(35)] forState:UIControlStateNormal];
    [self.view addSubview:self.searchBar];
}





#pragma mark -- 创建表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.sourceArray.count>0) {
        return self.sourceArray.count+1;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.sourceArray.count>0) {
        if (section==0) {
            return 0;
        }
        XBJinRRNewUserHelpModel *model = self.sourceArray[section-1];
        return model.isSelected?1:0;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 0;
    }
    XBJinRRNewUserHelpModel *model = self.sourceArray[indexPath.section-1];
     NSMutableAttributedString *str=  [[NSMutableAttributedString alloc] initWithData:[[LLUtils filterHTMLOne:model.Contents] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    CGFloat height = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    return height*2.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return SIZE(190);
    }
    return SIZE(40);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WS(bself);
    
    if (section==0) {
        UIView *bgView= [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(160)) backgroundColor:WhiteColor];
        NSArray *titles = @[@"融客店",@"注册登录",@"工资结算",@"推荐有钱"];
        NSArray *imgs = @[@"help_icon1",@"help_icon2",@"help_icon3",@"help_icon4"];
        CGFloat w = SCREEN_WIDTH/3.f;
        for (int i=0; i<4; i++) {
            [bgView addSubview:[self creatTapViewWithImageName:imgs[i] title:titles[i] tag:i frame:CGRectMake(w*(i%3), SIZE(80)*(i/3), w, SIZE(80))]];
        }
        
        return bgView;;
    }
    
    XBJinRRNewUserHelpSectionHeaderView *sectionHeaderView = [[XBJinRRNewUserHelpSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(40))];
    
    __block XBJinRRNewUserHelpModel *model = self.sourceArray[section-1];
    sectionHeaderView.tempModel =  model;
    sectionHeaderView.clickTapBlock = ^(XBJinRRNewUserHelpModel *tModel) {
        model = tModel;
        [bself.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    };
    return sectionHeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [UITableViewCell new];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XBJinRRNewUserHelpModel *model = self.sourceArray[indexPath.section-1];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = FONT(16);
    cell.textLabel.textColor = RGB(166, 166, 166);
    cell.textLabel.text = [LLUtils filterHTMLOne:model.Contents];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - - 创建按钮
- (UIView *)creatTapViewWithImageName:(NSString *)imageName title:(NSString *)title tag:(NSInteger )tag frame:(CGRect )frame{
    UIView *bgView = [ViewCreate createLineFrame:frame backgroundColor:WhiteColor];
    UIImageView *iconImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:imageName];
    [bgView addSubview:iconImageView];
    UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:title textColor:RGB(66, 66, 66) textAlignment:Center font:FONT(16)];
    [bgView addSubview:titleLabel];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZE(10));
        make.centerX.offset(0);
        make.width.height.mas_equalTo(SIZE(40));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(SIZE(5));
        make.left.offset(SIZE(5));
        make.bottom.right.offset(-SIZE(10));
    }];
    bgView.tag = tag;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickViewtap:)];
    [bgView addGestureRecognizer:tap];
    return bgView;
}
- (void)clickViewtap:(UITapGestureRecognizer *)tapper{
    switch (tapper.view.tag) {
        case 0:
            cateid = @"4";
            break;
        case 1:
            cateid = @"5";
            break;
        case 2:
            cateid = @"6";
            break;
        case 3:
            cateid = @"7";
            break;
            
        default:
            break;
    }
    searchname = isEmptyStr(self.searchBar.text)?@"":self.searchBar.text;
    [self.tableView.mj_header beginRefreshing];
}





#pragma mark - 实现键盘上Search按钮的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"您点击了键盘上的Search按钮");
    searchname=searchBar.text;
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 实现监听开始输入的方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    NSLog(@"开始输入搜索内容");
    return YES;
}
#pragma mark - 实现监听输入完毕的方法
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    NSLog(@"输入完毕");
    //    [self retuestMainDataWithName:searchBar.text];
    return YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
