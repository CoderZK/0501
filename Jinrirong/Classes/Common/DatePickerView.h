//
//  DatePickerView.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/2.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "MMAlertView.h"

typedef void(^DatePickerBlock)(NSString *dateString);

@interface DatePickerView : MMAlertView

@property(nonatomic,copy)DatePickerBlock DatePickerBlock;

@end
