//
//  XBJinRRCreatCardBigPicCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/1.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRBankCardModel.h"

@interface XBJinRRCreatCardBigPicCell : UITableViewCell
/**
 *  将要显示的卡数组
 */
@property(nonatomic, copy)NSArray *cardArray;
/**
 *  点击了哪个信用卡
 */
@property(nonatomic, copy)void(^clcickBlock)(XBJinRRBankCardModel *tModel);

@end
