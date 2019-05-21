//
//  XBJinRRPersonalBaseInfoViewController.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"

@interface XBJinRRPersonalBaseInfoViewController : XBJinRRBaseViewController
/**
 *  修改信息成功
 */
@property(nonatomic, copy)void (^editBlock)(void);
@end
