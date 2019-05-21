//
//  XBJinRRNavCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRHomeNavItemModel.h"

@interface XBJinRRNavCell : UITableViewCell
@property (nonatomic,strong) NSArray *navArray;
/**
 *  选择了那种方式贷款
 */
@property(nonatomic, copy)void (^selectedModelBlock)(XBJinRRHomeNavItemModel *selectedModel);
@end
