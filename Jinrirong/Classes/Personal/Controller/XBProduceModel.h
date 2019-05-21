//
//  XBProduceModel.h
//  Jinrirong
//
//  Created by 少少 on 2019/1/25.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBProduceModel : NSObject
@property (nonatomic, strong) NSString *Logurl;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *total;


- (id)initWithDictionary:(NSDictionary*)dic;
@end
