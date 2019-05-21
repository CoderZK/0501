//
//  XBJinRRNewSalaryDesCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRNewSalaryDesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelA1;
@property (weak, nonatomic) IBOutlet UILabel *labelA2;

@property (weak, nonatomic) IBOutlet UILabel *labelA3;
@property (weak, nonatomic) IBOutlet UILabel *labelB1;
@property (weak, nonatomic) IBOutlet UILabel *labelB2;
@property (weak, nonatomic) IBOutlet UILabel *labelB3;
@property (weak, nonatomic) IBOutlet UILabel *labelB4;

@property (weak, nonatomic) IBOutlet UILabel *labelC1;
@property (weak, nonatomic) IBOutlet UILabel *labelC2;
@property (weak, nonatomic) IBOutlet UILabel *labelC3;
@property (weak, nonatomic) IBOutlet UILabel *labelC4;

@property (weak, nonatomic) IBOutlet UILabel *baseSalaryLabel;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UILabel *stepSalary;

/**
 *  工资介绍模块
 */
@property(nonatomic, strong)NSMutableDictionary *infoDic;

@end
