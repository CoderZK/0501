//
//  CostomButton.h
//  NiuNiuJieBa
//
//  Created by 陈舟为 on 2017/2/27.
//  Copyright © 2017年 DaveChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostomButton : UIButton

@property(nonatomic,copy)NSString *textLable;

@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,copy)NSString *imageUrl;

@property(nonatomic,assign)NSInteger count;

@property (nonatomic,strong)UILabel *titleLable,*countLab;

@property (nonatomic,strong)UIImageView *imgView;

@end
