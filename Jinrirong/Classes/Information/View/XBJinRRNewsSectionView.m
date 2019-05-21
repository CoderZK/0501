//
//  XBJinRRNewsSectionView.m
//  Jinrirong
//
//  Created by 张艳江 on 2019/4/12.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBJinRRNewsSectionView.h"

@implementation XBJinRRNewsSectionView

+ (instancetype)addSectionView{
    return [[[NSBundle mainBundle]loadNibNamed:@"XBJinRRNewsSectionView" owner:nil options:nil]lastObject];
}
- (IBAction)clickBtns:(UIButton *)sender {
    if (sender.tag == 0) {
        self.lineView.hidden = NO;
        self.lineView1.hidden = YES;
        self.lineView2.hidden = YES;
    }else if (sender.tag == 1){
        self.lineView.hidden = YES;
        self.lineView1.hidden = NO;
        self.lineView2.hidden = YES;
    }else{
        self.lineView.hidden = YES;
        self.lineView1.hidden = YES;
        self.lineView2.hidden = NO;
    }
    self.lineView_x.constant = sender.tag/SCREEN_WIDTH;
    if ([self.delegate respondsToSelector:@selector(clickNewsSctionButtonWithTag:)]) {
        [self.delegate clickNewsSctionButtonWithTag:sender.tag];
    }
}

@end
