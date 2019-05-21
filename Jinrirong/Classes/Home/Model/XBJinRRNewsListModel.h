//
//  XBJinRRNewsListModel.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRNewsListModel : NSObject
/**
 *  "标题"
 */
@property(nonatomic, copy)NSString *Title;
/**
 *  "内容"          常见问题展示
 */
@property(nonatomic, copy)NSString *Contents;
/**
 *  "添加时间"
 */
@property(nonatomic, copy)NSString *AddTime;



/**
 *  ID
 */
@property(nonatomic, copy)NSString *ID;

@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *CoverImage;
@property (copy, nonatomic) NSString *IsVip;
@property (copy, nonatomic) NSString *YDL;

@end
