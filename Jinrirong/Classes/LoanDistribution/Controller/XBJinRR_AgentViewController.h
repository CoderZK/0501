//
//  XBJinRR_AgentViewController.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/25.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"

@interface XBJinRR_AgentViewController : XBJinRRBaseViewController

@property(nonatomic, copy)void (^changeSelectedIndx)(NSInteger index);

/**
 *  从哪个页面进入的融客店
 */
@property(nonatomic, strong)NSString *waymode;

@end
