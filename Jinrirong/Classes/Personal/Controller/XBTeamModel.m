//
//  XBTeamModel.m
//  Jinrirong
//
//  Created by 少少 on 2019/1/22.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBTeamModel.h"
#define ISNULL(__pointer)         (__pointer == nil || [[NSNull null] isEqual:__pointer])

@implementation XBTeamModel
- (id)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        self.Mobile = !ISNULL([dic objectForKey:@"Mobile"]) ? [dic objectForKey:@"Mobile"] : @"";
        self.RegTime = !ISNULL([dic objectForKey:@"RegTime"]) ? [dic objectForKey:@"RegTime"] : @"";
        self.ID = !ISNULL([dic objectForKey:@"ID"]) ? [dic objectForKey:@"ID"] : @"";
        self.Mtype = !ISNULL([dic objectForKey:@"Mtype"]) ? [dic objectForKey:@"Mtype"] : @"";
        self.HeadImg = !ISNULL([dic objectForKey:@"HeadImg"]) ? [dic objectForKey:@"HeadImg"] : @"";
//        self.Username = !ISNULL([dic objectForKey:@"Username"]) ? [dic objectForKey:@"Username"] : @"";
        
    }
    return self;
}
@end
