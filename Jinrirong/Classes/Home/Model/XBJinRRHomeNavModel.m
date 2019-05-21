//
//  XBJinRRHomeNavModel.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRHomeNavModel.h"
#import "XBJinRRHomeNavItemModel.h"

@implementation XBJinRRHomeNavModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"cateList" : @"XBJinRRHomeNavItemModel"
             };
}

@end
