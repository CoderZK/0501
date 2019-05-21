//
//  XBJinRRMoneyMenu.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMoneyMenu.h"
#import "XBJinRRMoneyTypeModel.h"

@interface XBJinRRMoneyMenu()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation XBJinRRMoneyMenu

static NSString *moneyCellID = @"moneyCellID";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self addSubview:tableView];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:moneyCellID];
        self.tableView = tableView;
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}
#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moneyCellID];
    XBJinRRMoneyTypeModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.Name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.myDelegate respondsToSelector:@selector(XBJinRRMoneyMenuClickWithID:)]) {
        XBJinRRMoneyTypeModel *model = self.dataArray[indexPath.row];
        [self.myDelegate XBJinRRMoneyMenuClickWithID:model.ID];
    }
}
@end
