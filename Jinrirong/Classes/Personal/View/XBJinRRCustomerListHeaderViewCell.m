//
//  XBJinRRCustomerListHeaderViewCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCustomerListHeaderViewCell.h"

@implementation XBJinRRCustomerListHeaderViewCell

- (IBAction)makeSureBtnClick:(UIButton *)sender {
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

//-(instancetype)init{
//    if (self=[super init]) {
//
//    }
//    return self;
//}
- (void )tapClick:(UITapGestureRecognizer *)tapper{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeBgView.layer.masksToBounds = YES;
    self.timeBgView.layer.cornerRadius  = 5.f;
    
    self.makeSureBtn.layer.masksToBounds = YES;
    self.makeSureBtn.layer.cornerRadius  = 5.f;
    
    self.timeBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.timeBgView addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
