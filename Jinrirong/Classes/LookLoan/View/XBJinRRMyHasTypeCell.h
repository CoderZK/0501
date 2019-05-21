//
//  XBJinRRMyHasTypeCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XBJinRRMyHasTypeCell;

@protocol XBJinRRMyHasTypeCellDelegate<NSObject>
- (void)XBJinRRMyHasTypeCell:(XBJinRRMyHasTypeCell *)hasTypeCell ClickBtnWithID:(NSString *)ID isSelect:(BOOL)isSelect;
@end

@interface XBJinRRMyHasTypeCell : UITableViewCell
@property (nonatomic,strong) NSArray *hasDataArray;
@property (nonatomic,weak) id<XBJinRRMyHasTypeCellDelegate> myDelegate;
@property (nonatomic,assign) BOOL isSelectOne;

/**
 *  一个不让选择
 */
@property (nonatomic,assign) BOOL isNotSelect;

- (void)resetBtn;

@end
