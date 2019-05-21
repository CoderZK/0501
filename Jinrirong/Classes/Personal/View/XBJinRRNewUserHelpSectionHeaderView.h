//
//  XBJinRRNewUserHelpSectionHeaderView.h
//  Jinrirong
//
//  Created by 刘布斯 on 2018/6/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRNewUserHelpModel.h"

@interface XBJinRRNewUserHelpSectionHeaderView : UIView

@property(nonatomic, strong)XBJinRRNewUserHelpModel *tempModel;
@property(nonatomic, copy)void (^clickTapBlock)(XBJinRRNewUserHelpModel *tModel);

@end
