//
//  XBJinRRNewsSectionView.h
//  Jinrirong
//
//  Created by 张艳江 on 2019/4/12.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XBJinRRNewsSectionViewDelegate <NSObject>

- (void)clickNewsSctionButtonWithTag:(NSInteger)tag;

@end

@interface XBJinRRNewsSectionView : UIView

@property (weak, nonatomic) IBOutlet UIButton *sectionBtn0;
@property (weak, nonatomic) IBOutlet UIButton *sectionBtn1;
@property (weak, nonatomic) IBOutlet UIButton *sectionBtn2;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView_x;

@property (weak, nonatomic) id<XBJinRRNewsSectionViewDelegate>delegate;

+ (instancetype)addSectionView;

@end

