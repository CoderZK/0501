//
//  kkkkModel.h
//  Jinrirong
//
//  Created by zk on 2019/5/9.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface kkkkModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *des;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *timeTwo;


@property(nonatomic,assign)NSInteger scan;
@property(nonatomic,assign)NSInteger like;
@property(nonatomic,assign)NSInteger status;

@end

NS_ASSUME_NONNULL_END
