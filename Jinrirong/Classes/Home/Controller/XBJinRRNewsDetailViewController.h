//
//  XBJinRRNewsDetailViewController.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"
#import "XBJinRRNewsListModel.h"

@interface XBJinRRNewsDetailViewController : XBJinRRBaseViewController
/**
 *  公告内容
 */
@property(nonatomic, strong) XBJinRRNewsListModel *tModel;

@property (assign, nonatomic) BOOL isNews;

@end
