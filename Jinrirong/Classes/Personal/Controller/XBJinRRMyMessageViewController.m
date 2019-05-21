//
//  XBJinRRMyMessageViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMyMessageViewController.h"
#import "XBJinRRMyMessageCell.h"
#import "XBJinRRMyMessageHeader.h"
#import "XBJinRRMyMsgItemModel.h"

@interface XBJinRRMyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation XBJinRRMyMessageViewController

static NSString *XBJinRRMyMessageCellID = @"XBJinRRMyMessageCellID";
static NSString *XBJinRRMyMessageHeaderID = @"XBJinRRMyMessageHeaderID";

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"我的消息"];
    [self setNavWithTitle:@"我的消息" isShowBack:YES];
    [self createUI];
}
- (void)createUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-(NAV_HEIGHT)) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[XBJinRRMyMessageCell class] forCellReuseIdentifier:XBJinRRMyMessageCellID];
    [tableView registerClass:[XBJinRRMyMessageHeader class] forHeaderFooterViewReuseIdentifier:XBJinRRMyMessageHeaderID];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
#pragma mark - UITableView代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XBJinRRMyMessageHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XBJinRRMyMessageHeaderID];
    XBJinRRMyMsgItemModel *msgItemModel = self.dataArray[section];
    header.dateLabel.text = [NSString stringWithFormat:@" %@ ",msgItemModel.SendTime];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 64;
    XBJinRRMyMsgItemModel *msgItemModel = self.dataArray[indexPath.section];
    NSString *Title = msgItemModel.Title;
    NSString *Contents = msgItemModel.Contents;
    CGFloat Titleheight = [LLUtils getSpaceLabelHeight:Title withFont:15 lineSpacing:0 withWidth:SCREEN_WIDTH-60];
     CGFloat Contentsheight = [LLUtils getSpaceLabelHeight:Contents withFont:13 lineSpacing:0 withWidth:SCREEN_WIDTH-60];
    return Titleheight+Contentsheight+25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBJinRRMyMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRMyMessageCellID];
    messageCell.msgItemModel = self.dataArray[indexPath.section];
    messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return messageCell;
}
@end
