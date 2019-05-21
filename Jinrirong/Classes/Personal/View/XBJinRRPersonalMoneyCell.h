//
//  XBJinRRPersonalMoneyCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRPersonInfoModel.h"

@interface XBJinRRPersonalMoneyCell : UITableViewCell
@property (nonatomic,strong) XBJinRRPersonInfoModel *personInfoModel;
/**
 *  点击了哪个按钮
 */
@property(nonatomic, copy)void (^clickBlock)(NSInteger index);
@end
