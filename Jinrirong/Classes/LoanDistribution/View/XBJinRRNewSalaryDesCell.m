//
//  XBJinRRNewSalaryDesCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRNewSalaryDesCell.h"

@implementation XBJinRRNewSalaryDesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.thirdBgView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setInfoDic:(NSMutableDictionary *)infoDic{
    _infoDic = infoDic;
    NSArray *arr = _infoDic[@"StepIntro"];
    

    
    self.labelC3.text = [NSString stringWithFormat:@"%@",_infoDic[@"threeMoney"]];

    self.labelC4.text = [NSString stringWithFormat:@"%@", arr.count > 0 ? (isEmptyStr(arr[0])?@"":arr[0]) : @""];
    
    self.labelB3.text = [NSString stringWithFormat:@"%@",_infoDic[@"twoMoney"]];

    self.labelB4.text = [NSString stringWithFormat:@"%@", arr.count > 1 ? (isEmptyStr(arr[1])?@"":arr[1]) : @""];
    
    
    self.labelA2.text = [NSString stringWithFormat:@"%@",_infoDic[@"oneMoney"]];


    self.labelA3.text = [NSString stringWithFormat:@"%@", arr.count > 2 ? (isEmptyStr(arr[2])?@"":arr[2]) : @""];
    
//    self.baseSalaryLabel.text = [NSString stringWithFormat:@"%@",isEmptyStr(_infoDic[@"BaseFee"])?@"":_infoDic[@"BaseFee"]];
//    self.stepSalary.text = [NSString stringWithFormat:@"%@",isEmptyStr(_infoDic[@"StepFee"])?@"":_infoDic[@"StepFee"]];
}



@end
