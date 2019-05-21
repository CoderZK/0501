//
//  XBCommModel.h
//  Jinrirong
//
//  Created by 少少 on 2019/1/25.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBCommModel : NSObject
@property (nonatomic, strong) NSString *HeadImg;
@property (nonatomic, strong) NSString *Mobile;
@property (nonatomic, strong) NSString *UserID;
@property (nonatomic, strong) NSString *Username;
//@property (nonatomic, strong) NSString *Username;
@property (nonatomic, strong) NSString *totalAmount;


- (id)initWithDictionary:(NSDictionary*)dic;
@end
