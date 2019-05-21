//
//  XBJinRRCreditCardCenterTopCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/1.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRCreditCardModel.h"

@interface XBJinRRCreditCardCenterTopCell : UITableViewCell


/**
 *  顶部cell信用卡数组
 */
@property(nonatomic, copy)NSArray *infoArray;
/**
 *  点击了哪个信用卡
 */
@property(nonatomic, copy)void(^clcickBlock)(XBJinRRCreditCardModel *tModel);

@end
