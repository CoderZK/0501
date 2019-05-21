//
//  XBEDAINormalQuestionModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/29.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBEDAINormalQuestionModel : NSObject
/**
 * AddTime
 */
@property(nonatomic, strong)NSString *AddTime;
/**
 * "标题"
 */
@property(nonatomic, strong)NSString *Title;
/**
 * "内容"
 */
@property(nonatomic, strong)NSString *Contents;
/**
 * 是否选中section头部
 */
@property(nonatomic, assign)BOOL isSelected;
@end
