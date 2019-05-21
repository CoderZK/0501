//
//  XBTeamModel.h
//  Jinrirong
//
//  Created by 少少 on 2019/1/22.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTeamModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *Mobile;
@property (nonatomic, strong) NSString *RegTime;
@property (nonatomic, strong) NSString *Mtype;
//@property (nonatomic, strong) NSString *Username;
@property (nonatomic, strong) NSString *HeadImg;


- (id)initWithDictionary:(NSDictionary*)dic;
@end
