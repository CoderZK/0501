//
//  XBJinRRMenuCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRMenuCell : UITableViewCell
/**
 *  选择了那个模块
 */
@property(nonatomic, copy)void (^selectedIndexBlock)(NSInteger index);
@end
