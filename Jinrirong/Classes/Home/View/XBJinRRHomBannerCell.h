//
//  XBJinRRHomBannerCell.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRHomBannerCell : UITableViewCell
@property (nonatomic, strong) NSArray *bannerImages;
/** 点击图片回调 */
@property (nonatomic, copy) void (^tapImageVBlock)(NSInteger currentIndex);
@end
