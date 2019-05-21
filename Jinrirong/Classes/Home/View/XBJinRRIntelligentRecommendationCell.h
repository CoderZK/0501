//
//  XBJinRRIntelligentRecommendationCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRHomeRecommandModel.h"

@interface XBJinRRIntelligentRecommendationCell : UITableViewCell
@property (nonatomic,strong) NSArray *recommendArray;

/**
 *  选择了那种贷款产品block
 */
@property(nonatomic, copy)void (^selectedModelBlock)(XBJinRRHomeRecommandModel *recommendModel);
@end
