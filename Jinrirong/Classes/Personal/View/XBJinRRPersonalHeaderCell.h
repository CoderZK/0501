//
//  XBJinRRPersonalHeaderCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRPersonInfoModel.h"

@protocol XBJinRRPersonalHeaderCellDelegate<NSObject>
- (void)XBJinRRPersonalHeaderCellClickLogin;
- (void)XBJinRRPersonalHeaderCellClickMsg;
@end

@interface XBJinRRPersonalHeaderCell : UITableViewCell
@property (nonatomic,weak) id<XBJinRRPersonalHeaderCellDelegate> myDelegate;
@property (nonatomic,strong) XBJinRRPersonInfoModel *personInfoModel;
/**
 *  是否有未读消息
 */
@property(nonatomic, copy)NSString *isNoReadMsg;
@end
