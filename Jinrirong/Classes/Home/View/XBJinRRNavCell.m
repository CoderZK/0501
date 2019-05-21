//
//  XBJinRRNavCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/8.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRNavCell.h"

#import "JXButton.h"

@interface XBJinRRNavCell()
@property (nonatomic,strong) UIView *bg;
@end

@implementation XBJinRRNavCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *bg = [[UIView alloc] init];
        [self.contentView addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
        self.bg = bg;
    }
    return self;
}
- (void)setNavArray:(NSArray *)navArray
{
    _navArray = navArray;
    CGFloat w = SCREEN_WIDTH/4;
    CGFloat h = 120*0.5;
    for (int i = 0; i < navArray.count; i++) {
        XBJinRRHomeNavItemModel *model = _navArray[i];
        JXButton *btn = [[JXButton alloc] init];
        [btn setTitle:model.Name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        NSString *url = [model.Imageurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [btn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
        CGFloat y = (i / 4)*h;
        CGFloat x = (i % 4)*w;
        btn.frame = CGRectMake(x, y+10, w, h);
        btn.tag = i;
        [btn addTarget:self action:@selector(selectedModel:) forControlEvents:UIControlEventTouchUpInside];

        [self.bg addSubview:btn];
    }
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    for (UIView *v in self.bg.subviews) {
        [v removeFromSuperview];
    }
}


- (void )selectedModel:(UIButton *)sender{
    if (self.selectedModelBlock) {
        self.selectedModelBlock(self.navArray[sender.tag]);
    }
}


//-(void)initButton:(UIButton*)btn{
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
//}
@end
