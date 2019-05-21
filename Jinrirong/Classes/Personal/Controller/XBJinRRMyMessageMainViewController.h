//
//  XBJinRRMyMessageMainViewController.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"

@interface XBJinRRMyMessageMainViewController : XBJinRRBaseViewController
/**
 *  消息标记已读回调刷新
 */
@property(nonatomic, copy)void (^refreshBlock)(void);
@end
