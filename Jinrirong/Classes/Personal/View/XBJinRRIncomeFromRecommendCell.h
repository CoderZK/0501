//
//  XBJinRRIncomeFromRecommendCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRPromotdataModel.h"

@interface XBJinRRIncomeFromRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthcn;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *bonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *submitTimeLabel;
/**
 *  推广收入的model
 */
@property(nonatomic, strong)XBJinRRPromotdataModel *tModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCn;



@end
