//
//  XBEDAINormalQuestionSectionHeaderView.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/29.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBEDAINormalQuestionModel.h"

@interface XBEDAINormalQuestionSectionHeaderView : UIView
@property(nonatomic, strong)XBEDAINormalQuestionModel *tempModel;
@property(nonatomic, copy)void (^clickTapBlock)(XBEDAINormalQuestionModel *tModel);
@end
