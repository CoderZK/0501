//
//  XBJinRRTypeMenuBottomCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XBJinRRTypeMenuBottomCellDelegate<NSObject>
- (void)XBJinRRTypeMenuBottomCellClickResetBtn;
- (void)XBJinRRTypeMenuBottomCellClickOkBtn;
@end

@interface XBJinRRTypeMenuBottomCell : UITableViewCell
@property (nonatomic,weak) id<XBJinRRTypeMenuBottomCellDelegate> myDelegate;
@end
