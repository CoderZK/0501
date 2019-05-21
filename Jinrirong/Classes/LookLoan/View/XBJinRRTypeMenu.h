//
//  XBJinRRTypeMenu.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XBJinRRTypeMenuDelegate<NSObject>
- (void)XBJinRRTypeMenuClickBtnWithCid:(NSString *)cid nids:(NSString *)nids;
@end

@interface XBJinRRTypeMenu : UIView
@property (nonatomic,strong) NSArray *hasDataArray;
@property (nonatomic,strong) NSArray *needDataArray;

@property (nonatomic,weak) id<XBJinRRTypeMenuDelegate> myDelegate;

@end
