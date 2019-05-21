//
//  DatePickerView.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/2.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView ()

@property(nonatomic,weak)UIDatePicker *datePicker;

@property(nonatomic,copy)NSString *pickerDateStr;

@end

@implementation DatePickerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.type = MMPopupTypeSheet;
        
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT / 4 + [MyAdapter laDapter:50]));
            
        }];
        
        self.backgroundColor = [UIColor whiteColor];
    
        
        UIButton *cancelBtn = [[UIButton alloc] init];
        
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:cancelBtn];
        
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.offset(0);
            
            make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH/4, [MyAdapter laDapter:40]));
            
        }];
        
        UIButton *sureBtn = [[UIButton alloc] init];
        
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sureBtn];
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(0);
            
            make.right.offset(0);
            
            make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH/4, [MyAdapter laDapter:40]));
            
        }];
        
        //创建UIDatePicker
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        
        //设置区域
        picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //设置时间显示模式
        picker.datePickerMode = UIDatePickerModeDate;
        
        NSString *str = @"1900-01";
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        
        [dateFormatter1 setDateFormat:@"yyyy/MM"];
        
        NSDate *newDate = [dateFormatter1 dateFromString:str];
        
        picker.minimumDate = newDate;
        
        picker.maximumDate = [NSDate date];
        
        [picker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:picker];
        
        self.datePicker = picker;
        
        [picker mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.offset(0);
            
            make.bottom.offset(-[MyAdapter laDapter:10]);
            
            make.top.equalTo(cancelBtn.mas_bottom).offset([MyAdapter laDapter:10]);
            
        }];
        
        [self dateChange:self.datePicker];
        
        
    }
    
    return self;
}

-(void)dateChange:(UIDatePicker *)picker{
    
    // 创建时格式化
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat=@"yyyy-MM";
    
    //把NSDate类型转换为字符串类型
    NSString *str=[formatter stringFromDate:picker.date];//picker.date属性就是当前UIDatePicker显示的时间
    
    self.pickerDateStr = str;
    
}

-(void)cancelAction{
    
    [self hide];
    
}

-(void)sureAction{
    
    if (self.DatePickerBlock) {
        
        _DatePickerBlock(self.pickerDateStr);
        
    }
    
    [self hide];
}

@end
