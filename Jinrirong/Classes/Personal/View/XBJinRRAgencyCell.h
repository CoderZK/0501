//
//  XBJinRRAgencyCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRAgencyCell : UITableViewCell
///**
// *  @params agencyArray 代理人数组
// *  @params agencyType  代理人级别
// */
//- (void )setAgencyArray:(NSArray *)agencyArray agencyType:(NSString *)agencyType;

/**
 *  代理人数组
 */
@property(nonatomic, copy)NSArray *agencysArray;

/**
 *  选择了哪个代理
 */
@property(nonatomic, copy)void (^clickItemBlock)(NSInteger index);
@end
