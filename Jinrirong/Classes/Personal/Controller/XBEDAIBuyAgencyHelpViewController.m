//
//  XBEDAIBuyAgencyHelpViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/29.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBEDAIBuyAgencyHelpViewController.h"
#import "XBEDAINormalQuestionModel.h"
#import "XBEDAINormalQuestionSectionHeaderView.h"

@interface XBEDAIBuyAgencyHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *List;
@end

@implementation XBEDAIBuyAgencyHelpViewController
-(NSMutableArray *)List{
    if (!_List) {
        _List = [NSMutableArray new];
    }
    return _List;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavWithTitle:@"常见问题" isShowBack:YES];
    
    page = 0;
    [self initTableView];
    [self addRefresh];
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
//    cid     新闻类型 1常见问题  2系统公告
    NSDictionary *params = @{@"cid":@"1",@"page":@(page),@"rows":@"10"};
    [XBJinRRNetworkApiManager getnewslistWithParams:params Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
        if (rusultIsCorrect) {
            NSArray *arr0 = [XBEDAINormalQuestionModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            NSMutableArray *arr = [NSMutableArray new];
            for (int i = 0; i<arr0.count; i++) {
                XBEDAINormalQuestionModel *model = arr0[i];
                model.isSelected = NO;
                [arr addObject:model];
            }
            if (self->page>0) {
                [bself.List addObjectsFromArray:arr];
            }else{
                bself.List = arr.mutableCopy;
            }
            
        }else{
            if (self->page>0) {
                
            }else{
                bself.List = nil;
            }
        }
        [bself.tableView reloadData];
    } fail:^(NSError *errorString) {
        [bself.tableView.mj_header endRefreshing];
        [bself.tableView.mj_footer endRefreshing];
    }];
}


- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
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
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.List.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.List.count>0) {
        XBEDAINormalQuestionModel *model = self.List[section];
        return model.isSelected?1:0;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBEDAINormalQuestionModel *model = self.List[indexPath.section];
    NSMutableAttributedString *str=  [[NSMutableAttributedString alloc] initWithData:[[LLUtils filterHTMLOne:model.Contents] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    CGFloat height = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    return height*2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(44);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XBEDAINormalQuestionModel *model = self.List[indexPath.section];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = FONT(16);
    cell.textLabel.textColor = RGB(166, 166, 166);
    cell.textLabel.text = [LLUtils filterHTMLOne:model.Contents];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WS(bself);
    XBEDAINormalQuestionSectionHeaderView *sectionHeaderView = [[XBEDAINormalQuestionSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(40))];
    __block XBEDAINormalQuestionModel *model = self.List[section];
    sectionHeaderView.tempModel =  model;
    sectionHeaderView.clickTapBlock = ^(XBEDAINormalQuestionModel *tModel) {
        model = tModel;
        [bself.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    };
    return sectionHeaderView;
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
