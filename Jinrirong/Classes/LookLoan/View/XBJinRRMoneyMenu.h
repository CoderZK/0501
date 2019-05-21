//
//  XBJinRRMoneyMenu.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XBJinRRMoneyMenuDelegate<NSObject>
- (void)XBJinRRMoneyMenuClickWithID:(NSString *)ID;
@end

@interface XBJinRRMoneyMenu : UIView
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,weak) id<XBJinRRMoneyMenuDelegate> myDelegate;
@end
