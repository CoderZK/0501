//
//  XBCommModel.m
//  Jinrirong
//
//  Created by 少少 on 2019/1/25.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBCommModel.h"


#define ISNULL(__pointer)         (__pointer == nil || [[NSNull null] isEqual:__pointer])

@implementation XBCommModel
- (id)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        self.Mobile = !ISNULL([dic objectForKey:@"Mobile"]) ? [dic objectForKey:@"Mobile"] : @"";
        self.UserID = !ISNULL([dic objectForKey:@"UserID"]) ? [dic objectForKey:@"UserID"] : @"";
        self.Username = !ISNULL([dic objectForKey:@"Username"]) ? [dic objectForKey:@"Username"] : @"";
        self.totalAmount = !ISNULL([dic objectForKey:@"totalAmount"]) ? [dic objectForKey:@"totalAmount"] : @"";
        self.HeadImg = !ISNULL([dic objectForKey:@"HeadImg"]) ? [dic objectForKey:@"HeadImg"] : @"";
        //        self.Username = !ISNULL([dic objectForKey:@"Username"]) ? [dic objectForKey:@"Username"] : @"";
        
    }
    return self;
}
@end
