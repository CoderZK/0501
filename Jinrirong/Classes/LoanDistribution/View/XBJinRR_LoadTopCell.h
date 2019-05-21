//
//  XBJinRR_LoadTopCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/25.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRR_RecommendsLoadModel.h"

@interface XBJinRR_LoadTopCell : UITableViewCell


/**
 *  点击了哪个推荐产品
 */
@property(nonatomic, copy)void (^clickItemBlock)(NSInteger index);

/**
 *  新品推荐model数组
 */
@property(nonatomic, strong)NSArray<XBJinRR_RecommendsLoadModel *> *recommends;
@end
