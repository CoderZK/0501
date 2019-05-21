//
//  XBJinRR_LookLoanLabelCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/31.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRR_LookLoanLabelCell : UITableViewCell
/**
 *  @params titles 标签名称的数组
 *  @params applyPeopleCount 申请人数多少人
 *  @params isShowBottomView 是否展示底部图片和申请人数
 */
- (void )setlabelTitles:(NSArray *)titles applyPeopleCount:(NSString *)applyPeopleCount isShowBottomView:(BOOL )isShowBottomView;

@end
