//
//  XBJinRRTypeMenu.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRTypeMenu.h"
#import "XBJinRRMyHasTypeCell.h"
#import "XBJinRRTypeMenuBottomCell.h"

@interface XBJinRRTypeMenu()<UITableViewDelegate, UITableViewDataSource,XBJinRRTypeMenuBottomCellDelegate,XBJinRRMyHasTypeCellDelegate>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) NSString *cid;
@property (nonatomic,strong) NSMutableArray *nidsArray;

@property (nonatomic,strong) XBJinRRMyHasTypeCell *myHasTypeCell;
@property (nonatomic,strong) XBJinRRMyHasTypeCell *myNeedTypeCell;

@end

@implementation XBJinRRTypeMenu

static NSString *myHasCellID = @"myHasCellID";
static NSString *myHasTypeCellID = @"myHasTypeCellID";
static NSString *myNeedCellID = @"myNeedCellID";
static NSString *myNeedTypeCellID = @"myNeedTypeCellID";
static NSString *XBJinRRTypeMenuBottomCellID = @"XBJinRRTypeMenuBottomCellID";

- (NSMutableArray *)nidsArray
{
    if (_nidsArray == nil) {
        _nidsArray = [NSMutableArray array];
    }
    return _nidsArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self addSubview:tableView];
        
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:myHasCellID];
        [tableView registerClass:[XBJinRRMyHasTypeCell class] forCellReuseIdentifier:myHasTypeCellID];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:myNeedCellID];
        [tableView registerClass:[XBJinRRMyHasTypeCell class] forCellReuseIdentifier:myNeedTypeCellID];
        [tableView registerClass:[XBJinRRTypeMenuBottomCell class] forCellReuseIdentifier:XBJinRRTypeMenuBottomCellID];
        
        self.tableView = tableView;
    }
    return self;
}


- (void)setNeedDataArray:(NSArray *)needDataArray
{
    _needDataArray = needDataArray;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
    [self.tableView reloadData];
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.row == 0) {
        height = 44;
    } else if (indexPath.row == 1) {
        height = 10+(((self.hasDataArray.count-1) / 4)+1)*(40+10);
    }
//    else if (indexPath.row == 2) {
//        height = 44;
//    } else if (indexPath.row == 3) {
//        height = 10+(((self.needDataArray.count-1) / 4)+1)*(40+10);
//    }
    else {
        height = 44;
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (indexPath.row == 0) {
        UITableViewCell *myHasCell = [tableView dequeueReusableCellWithIdentifier:myHasCellID];
        myHasCell.selectionStyle = UITableViewCellSelectionStyleNone;
        myHasCell.textLabel.font = [UIFont systemFontOfSize:14];
        myHasCell.textLabel.textColor = [UIColor blackColor];
        myHasCell.textLabel.text = @"我有";
        cell = myHasCell;
    } else if (indexPath.row == 1) {
        XBJinRRMyHasTypeCell *myHasTypeCell = [tableView dequeueReusableCellWithIdentifier:myHasTypeCellID];
        myHasTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        myHasTypeCell.isSelectOne = YES;
        myHasTypeCell.hasDataArray = self.hasDataArray;
        myHasTypeCell.myDelegate = self;
        cell = myHasTypeCell;
        self.myHasTypeCell = myHasTypeCell;
    }
//    else if (indexPath.row == 2) {
//        UITableViewCell *myNeedCell = [tableView dequeueReusableCellWithIdentifier:myNeedCellID];
//        myNeedCell.textLabel.font = [UIFont systemFontOfSize:14];
//        myNeedCell.textLabel.textColor = [UIColor blackColor];
//        myNeedCell.textLabel.text = @"我需要";
//        cell = myNeedCell;
//    } else if (indexPath.row == 3) {
//        XBJinRRMyHasTypeCell *myNeedTypeCell = [tableView dequeueReusableCellWithIdentifier:myNeedTypeCellID];
//        myNeedTypeCell.isSelectOne = NO;
//        myNeedTypeCell.hasDataArray = self.needDataArray;
//        myNeedTypeCell.myDelegate = self;
//        cell = myNeedTypeCell;
//        self.myNeedTypeCell = myNeedTypeCell;
//    }
    else {
        XBJinRRTypeMenuBottomCell *menuBottomCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRTypeMenuBottomCellID];
        menuBottomCell.selectionStyle = UITableViewCellSelectionStyleNone;
        menuBottomCell.myDelegate = self;
        cell = menuBottomCell;
    }
    return cell;
}
#pragma mark - XBJinRRMyHasTypeCellDelegate
- (void)XBJinRRMyHasTypeCell:(XBJinRRMyHasTypeCell *)hasTypeCell ClickBtnWithID:(NSString *)ID isSelect:(BOOL)isSelect
{
    if (hasTypeCell.isSelectOne == YES) {
        self.cid = ID;
    } else {
        if (isSelect) {
            BOOL has = NO;
            for (NSString *nid in self.nidsArray) {
                if ([nid isEqualToString:ID]) {
                    has = YES;
                    break;
                }
            }
            if (has == NO) {
                [self.nidsArray addObject:ID];
            }
        } else {
            for (int i = 0; i < self.nidsArray.count; i++) {
                NSString *nid = self.nidsArray[i];
                if ([nid isEqualToString:ID]) {
                    [self.nidsArray removeObjectAtIndex:i];
                }
            }
        }
        
    }
}
#pragma mark - XBJinRRTypeMenuBottomCellDelegate
- (void)XBJinRRTypeMenuBottomCellClickOkBtn
{
    NSString *nids = @"0";
    if (self.nidsArray.count > 0) {
        nids = [self.nidsArray componentsJoinedByString:@","];
    }
    
    if ([self.myDelegate respondsToSelector:@selector(XBJinRRTypeMenuClickBtnWithCid:nids:)]) {
        [self.myDelegate XBJinRRTypeMenuClickBtnWithCid:self.cid nids:nids];
    }
}
- (void)XBJinRRTypeMenuBottomCellClickResetBtn
{
    self.cid = @"0";
    [self.nidsArray removeAllObjects];
    [self.myHasTypeCell resetBtn];
    [self.myNeedTypeCell resetBtn];
}
@end
