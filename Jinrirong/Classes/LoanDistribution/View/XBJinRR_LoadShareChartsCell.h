//
//  XBJinRR_LoadShareChartsCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRR_LoadShareChartsCell : UITableViewCell
/**
 * @params chart       - 名次
 * @params phoneNumber - 手机号
 * @params loadMoney   - 放款金额（万元）
 * @params isHiddenLineAndShowLayer - 是否隐藏间隔线和切名次圆弧
 * @params chartLabelColor - 名次背景色
 */
- (void )setChart:(NSString *)chart phoneNumber:(NSString *)phoneNumber loadMoney:(NSString *)loadMoney isHiddenLineAndShowLayer:(BOOL )isHiddenLineAndShowLayer chartLabelColor:(UIColor *)chartLabelColor;

@end
