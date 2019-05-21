//
//  XBJinRR_GetCodeCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/24.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_GetCodeCell.h"

@interface XBJinRR_GetCodeCell()
@end


@implementation XBJinRR_GetCodeCell


- (IBAction)getCodeBtnClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }else{
        if (self.getCodeBtnCliCkBlock) {
            self.getCodeBtnCliCkBlock();
        }
    }
}

- (void)timeDown:(NSInteger)timeNum
{
    _getCodeBtn.selected = YES;
//    _getCodeBtn.backgroundColor = [UIColor whiteColor];
    
    NSString *string = [NSString stringWithFormat:@"%lds",timeNum];
    [_getCodeBtn setTitle:string forState:UIControlStateNormal];
    [_getCodeBtn setTitle:string forState:UIControlStateSelected];
    if (timeNum <= 0) {
        _getCodeBtn.selected = NO;
        [_getCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_getCodeBtn setTitle:@"重新获取" forState:UIControlStateSelected];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
