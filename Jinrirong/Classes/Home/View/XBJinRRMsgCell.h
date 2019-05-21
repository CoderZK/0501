//
//  XBJinRRMsgCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRMsgCell : UITableViewCell
@property (nonatomic,strong) NSArray *noticeArray;
///**
// *  点击了那一条
// */
//@property(nonatomic, copy)void (^clickNewsIndexBlock)(NSInteger index);
/**
 *  点击查看更多新闻
 */
@property(nonatomic, copy)void (^clickMoreNewsBlock)(void);
@end
