//
//  XBJinRRMyHasTypeCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRMyHasTypeCell.h"
#import "XBJinRRMoneyTypeModel.h"

@interface XBJinRRMyHasTypeCell()
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) UIButton *lastButton;
@end

@implementation XBJinRRMyHasTypeCell

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
- (void)setHasDataArray:(NSArray *)hasDataArray
{
    _hasDataArray = hasDataArray;
    CGFloat w = (SCREEN_WIDTH-5*10)/4;
    CGFloat h = 40;
    
    if ([hasDataArray[0] isKindOfClass:[XBJinRRMoneyTypeModel class]]) {
        for (int i = 0; i < hasDataArray.count; i++) {
            XBJinRRMoneyTypeModel *model = hasDataArray[i];
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = i;
            CGFloat x = 10+(i % 4)*(w+10);
            CGFloat y = 10+(i / 4)*(h+10);
            btn.frame = CGRectMake(x, y, w, h);
            [btn setTitle:model.Name forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:MainColor forState:UIControlStateSelected];
            btn.titleLabel.font = FONT(12);
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            btn.layer.borderWidth = 0.5;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            [self.btns addObject:btn];
        }
    }else{
        for (int i = 0; i < hasDataArray.count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = i;
            CGFloat x = 10+(i % 4)*(w+10);
            CGFloat y = 10+(i / 4)*(h+10);
            btn.frame = CGRectMake(x, y, w, h);
            [btn setTitle:hasDataArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:MainColor forState:UIControlStateSelected];
            btn.titleLabel.font = FONT(12);
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            btn.layer.borderWidth = 0.5;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            [self.btns addObject:btn];
        }
    }
    
    
}

- (void)resetBtn
{
    self.lastButton = nil;
    for (UIButton *btn in self.btns) {
        [btn setSelected:NO];
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

- (void)clickBtn:(UIButton *)btn
{
    if (self.isNotSelect) {
        return;
    }
    
    if (self.isSelectOne) {
        if (self.lastButton == nil) {
            self.lastButton = btn;
            if (btn.isSelected) {
                [btn setSelected:NO];
                btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
                XBJinRRMoneyTypeModel *model = self.hasDataArray[btn.tag];
                if ([self.myDelegate respondsToSelector:@selector(XBJinRRMyHasTypeCell:ClickBtnWithID:isSelect:)]) {
                    [self.myDelegate XBJinRRMyHasTypeCell:self ClickBtnWithID:model.ID isSelect:NO];
                }
            } else {
                [btn setSelected:YES];
                btn.layer.borderColor = MainColor.CGColor;
                XBJinRRMoneyTypeModel *model = self.hasDataArray[btn.tag];
                if ([self.myDelegate respondsToSelector:@selector(XBJinRRMyHasTypeCell:ClickBtnWithID:isSelect:)]) {
                    [self.myDelegate XBJinRRMyHasTypeCell:self ClickBtnWithID:model.ID isSelect:YES];
                }
            }
        } else {
            if (btn.isSelected) {
                [btn setSelected:NO];
                btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
                XBJinRRMoneyTypeModel *model = self.hasDataArray[btn.tag];
                if ([self.myDelegate respondsToSelector:@selector(XBJinRRMyHasTypeCell:ClickBtnWithID:isSelect:)]) {
                    [self.myDelegate XBJinRRMyHasTypeCell:self ClickBtnWithID:model.ID isSelect:NO];
                }
            } else {
                [btn setSelected:YES];
                btn.layer.borderColor = MainColor.CGColor;
                XBJinRRMoneyTypeModel *model = self.hasDataArray[btn.tag];
                if ([self.myDelegate respondsToSelector:@selector(XBJinRRMyHasTypeCell:ClickBtnWithID:isSelect:)]) {
                    [self.myDelegate XBJinRRMyHasTypeCell:self ClickBtnWithID:model.ID isSelect:YES];
                }
            }
            if (self.lastButton != btn) {
                [self.lastButton setSelected:NO];
                self.lastButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
                self.lastButton = btn;
                XBJinRRMoneyTypeModel *model = self.hasDataArray[btn.tag];
                if ([self.myDelegate respondsToSelector:@selector(XBJinRRMyHasTypeCell:ClickBtnWithID:isSelect:)]) {
                    [self.myDelegate XBJinRRMyHasTypeCell:self ClickBtnWithID:model.ID isSelect:NO];
                }
            }
        }
    } else {
        if (btn.isSelected) {
            [btn setSelected:NO];
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            XBJinRRMoneyTypeModel *model = self.hasDataArray[btn.tag];
            if ([self.myDelegate respondsToSelector:@selector(XBJinRRMyHasTypeCell:ClickBtnWithID:isSelect:)]) {
                [self.myDelegate XBJinRRMyHasTypeCell:self ClickBtnWithID:model.ID isSelect:NO];
            }
        } else {
            [btn setSelected:YES];
            btn.layer.borderColor = MainColor.CGColor;
            XBJinRRMoneyTypeModel *model = self.hasDataArray[btn.tag];
            if ([self.myDelegate respondsToSelector:@selector(XBJinRRMyHasTypeCell:ClickBtnWithID:isSelect:)]) {
                [self.myDelegate XBJinRRMyHasTypeCell:self ClickBtnWithID:model.ID isSelect:YES];
            }
        }
    }
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIButton *btn in self.btns) {
        [btn removeFromSuperview];
    }
}
@end
