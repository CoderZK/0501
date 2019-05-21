//
//  XBJinRRTypeMenuBottomCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRTypeMenuBottomCell.h"

@implementation XBJinRRTypeMenuBottomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIButton *resetBtn = [[UIButton alloc] init];
        [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        resetBtn.backgroundColor = RGB(239, 239, 239);
        resetBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.5, 44);
        [resetBtn addTarget:self action:@selector(clickResetBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:resetBtn];
        
        UIButton *okBtn = [[UIButton alloc] init];
        [okBtn setTitle:@"确认" forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        okBtn.backgroundColor = MainColor;
        okBtn.frame = CGRectMake(SCREEN_WIDTH*0.5, 0, SCREEN_WIDTH*0.5, 44);
        [okBtn addTarget:self action:@selector(clickOkBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:okBtn];
    }
    return self;
}
- (void)clickResetBtn
{
    if ([self.myDelegate respondsToSelector:@selector(XBJinRRTypeMenuBottomCellClickResetBtn)]) {
        [self.myDelegate XBJinRRTypeMenuBottomCellClickResetBtn];
    }
}
- (void)clickOkBtn
{
    if ([self.myDelegate respondsToSelector:@selector(XBJinRRTypeMenuBottomCellClickOkBtn)]) {
        [self.myDelegate XBJinRRTypeMenuBottomCellClickOkBtn];
    }
}
@end
