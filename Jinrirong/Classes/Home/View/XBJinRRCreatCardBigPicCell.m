//
//  XBJinRRCreatCardBigPicCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/1.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRCreatCardBigPicCell.h"
#import "XBJinRRCreatBigPicView.h"


@interface XBJinRRCreatCardBigPicCell()
/**
 *  盛放所有小方块的数组
 */
@property(nonatomic, strong)NSMutableArray *views;
@end

@implementation XBJinRRCreatCardBigPicCell
-(NSMutableArray *)views{
    if (!_views) {
        _views = [NSMutableArray new];
    }
    return _views;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    //一个小方块 高度SIZE(150)
    CGFloat width = SCREEN_WIDTH/3.f;
    for (int i=0; i<50; i++) {
        XBJinRRCreatBigPicView *view = [[XBJinRRCreatBigPicView alloc] initWithFrame:CGRectMake(i%3*width, i/3*SIZE(150), width, SIZE(150))];
        view.hidden = YES;
        view.tag = i;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapperClick:)];
        [view addGestureRecognizer:tap];
        [self.views addObject:view];
    }
}

-(void )tapperClick:(UITapGestureRecognizer *)tapper{
    XBJinRRBankCardModel *model = _cardArray[tapper.view.tag];
    if (self.clcickBlock) {
        self.clcickBlock(model);
    }
}


-(void)setCardArray:(NSArray *)cardArray{
    _cardArray = cardArray;
    for (int i=0; i<_cardArray.count; i++) {
        XBJinRRCreatBigPicView *view = self.views[i];
        XBJinRRBankCardModel *model = _cardArray[i];
        view.hidden = NO;
        view.bankModel = model;
        [self.contentView addSubview:view];
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
