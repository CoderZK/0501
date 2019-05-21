//
//  XBJinRR_ShareBottomView.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_ShareBottomView.h"
#import "CostomButton.h"

@implementation XBJinRR_ShareBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    NSArray *img = @[@"distribution_commission_share",@"distribution_commission_link",@"distribution_commission_keep",@"distribution_commission_copy"];
    NSArray *title = @[@"分享海报",@"分享链接",@"保存海报",@"复制链接"];
    CGFloat width = SCREEN_WIDTH/ 4.f;
    for (int i = 0; i < title.count; i ++) {
        CostomButton *btn = [[CostomButton alloc] initWithFrame:CGRectMake(i * width, 0, width, SIZE(70))];
        btn.tag = i;
        btn.imageName = img[i];
        btn.textLable = title[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void )btnClick:(UIButton *)sender{
    if (self.clickOrderIndexCallBack) {
        self.clickOrderIndexCallBack(sender.tag);
    }
}

@end
