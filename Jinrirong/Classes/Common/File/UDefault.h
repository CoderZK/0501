//
//  UDefault.h
//  aiyuedong
//
//  Created by gravel on 15/10/8.
//  Copyright © 2015年 weishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDefault : NSObject

+(NSString*)getObject:(NSString*)str;
+(void)setObject:(NSString*)object keys:(NSString*)key;


+(void)removeObject:(NSString *)key;
@end
