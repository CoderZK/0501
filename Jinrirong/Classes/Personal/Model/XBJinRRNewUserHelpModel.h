//
//  XBJinRRNewUserHelpModel.h
//  Jinrirong
//
//  Created by 刘布斯 on 2018/6/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRNewUserHelpModel : NSObject
/**
 * "文章主键id"
 */
@property(nonatomic, strong)NSString *ID;
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
