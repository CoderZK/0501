//
//  UDefault.m
//  aiyuedong
//
//  Created by gravel on 15/10/8.
//  Copyright © 2015年 weishi. All rights reserved.
//

#import "UDefault.h"

@implementation UDefault

+(NSString*)getObject:(NSString*)str{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:str])
        return @"";
    return  [[NSUserDefaults standardUserDefaults] objectForKey:str];
}
+(void)setObject:(NSString*)object keys:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)removeObject:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

