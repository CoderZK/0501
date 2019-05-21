//
//  XBJinRR_LoadTopCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/25.
//  Copyright © 2018年 ahxb. All rights reserved.
//  贷款产品头部四个视图cell

#import "XBJinRR_LoadTopCell.h"
#import "XBJinRR_LoadTopView.h"

@interface XBJinRR_LoadTopCell()
/**
 *  全部新品推荐
 */
@property(nonatomic, strong)NSMutableArray *allRecommends;
@end


@implementation XBJinRR_LoadTopCell
-(NSMutableArray *)allRecommends{
    if (!_allRecommends) {
        _allRecommends = [NSMutableArray new];
    }
    return _allRecommends;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}


- (void )creatUI{
    XBJinRR_LoadTopView *topLeftView = [[XBJinRR_LoadTopView alloc] init];
    [self.contentView addSubview:topLeftView];
    
    XBJinRR_LoadTopView *toprightView = [[XBJinRR_LoadTopView alloc] init];
    [self.contentView addSubview:toprightView];
    
    XBJinRR_LoadTopView *bottomLeftView = [[XBJinRR_LoadTopView alloc] init];
    [self.contentView addSubview:bottomLeftView];
    
    XBJinRR_LoadTopView *bottomrightView = [[XBJinRR_LoadTopView alloc] init];
    [self.contentView addSubview:bottomrightView];
    
    CGFloat width = (SCREEN_WIDTH-0.5)*0.5;
    [topLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.height.mas_equalTo(SIZE(80));
        make.width.mas_equalTo(width);
    }];
    
    UIView *topLineView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(245, 245, 245)];
    [self.contentView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topLeftView.mas_right).offset(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(SIZE(10));
        make.height.mas_equalTo(SIZE(60));
        make.width.mas_equalTo(0.5);
    }];
    
    [toprightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topLineView.mas_right).offset(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(SIZE(80));
    }];
    
    UIView *centerYLineView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(245, 245, 245)];
    [self.contentView addSubview:centerYLineView];
    [centerYLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(topLeftView.mas_bottom).offset(0);
    }];
    
    [bottomLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.height.mas_equalTo(SIZE(80));
        make.width.mas_equalTo(width);
    }];
    
    UIView *bottomLineView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(245, 245, 245)];
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topLeftView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(SIZE(-10));
        make.height.mas_equalTo(SIZE(60));
        make.width.mas_equalTo(0.5);
    }];
    
    [bottomrightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topLineView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(SIZE(80));
    }];
    
    [self.allRecommends addObject:topLeftView];
    [self.allRecommends addObject:toprightView];
    [self.allRecommends addObject:bottomLeftView];
    [self.allRecommends addObject:bottomrightView];
    
    topLeftView.hidden = YES;
    toprightView.hidden = YES;
    bottomLeftView.hidden = YES;
    bottomrightView.hidden = YES;
    
    topLeftView.tag = 0;
    toprightView.tag = 1;
    bottomLeftView.tag = 2;
    bottomrightView.tag = 3;
    
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedIndexBtnClick:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedIndexBtnClick:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedIndexBtnClick:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedIndexBtnClick:)];
    [topLeftView addGestureRecognizer:tap0];
    [toprightView addGestureRecognizer:tap1];
    [bottomLeftView addGestureRecognizer:tap2];
    [bottomrightView addGestureRecognizer:tap3];
//    [self.contentView addGestureRecognizer:tap];
}

- (void )selectedIndexBtnClick:(UITapGestureRecognizer *)tapper{
    if (self.clickItemBlock) {
        self.clickItemBlock(tapper.view.tag);
    }
}

-(void)setRecommends:(NSArray<XBJinRR_RecommendsLoadModel *> *)recommends{
    _recommends = recommends;
    
    for (int i =0; i<_recommends.count; i++) {
        XBJinRR_LoadTopView *nowView = self.allRecommends[i];
        nowView.recommendModel = _recommends[i];
        nowView.hidden = NO;
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
