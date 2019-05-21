//
//  XBProduceModel.m
//  Jinrirong
//
//  Created by 少少 on 2019/1/25.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBProduceModel.h"



#define ISNULL(__pointer)         (__pointer == nil || [[NSNull null] isEqual:__pointer])

@implementation XBProduceModel
- (id)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        
        self.Logurl = !ISNULL([dic objectForKey:@"Logurl"]) ? [dic objectForKey:@"Logurl"] : @"";
        self.Name = !ISNULL([dic objectForKey:@"Name"]) ? [dic objectForKey:@"Name"] : @"";
        self.total = !ISNULL([dic objectForKey:@"total"]) ? [dic objectForKey:@"total"] : @"";
        
    }
    return self;
}
@end
