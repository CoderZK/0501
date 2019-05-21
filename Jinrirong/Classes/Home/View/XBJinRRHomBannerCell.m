//
//  XBJinRRHomBannerCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/7.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRHomBannerCell.h"
#import "SDCycleScrollView.h"
#import "XBJinRRHomeBannerModel.h"

@interface XBJinRRHomBannerCell()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@end

@implementation XBJinRRHomBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
- (void)setBannerImages:(NSArray *)bannerImages
{
    _bannerImages = bannerImages;
    NSMutableArray *imageUrlArr = [NSMutableArray array];
    for (int a=0; a<self.bannerImages.count; a++) {
        XBJinRRHomeBannerModel *model =self.bannerImages[a];
        NSString *picUrl = [model.Pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [imageUrlArr addObject:picUrl];
    }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleScrollView.imageURLStringsGroup = imageUrlArr;
    [self.contentView addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.cycleScrollView removeFromSuperview];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.tapImageVBlock) {
        self.tapImageVBlock(index);
    }
}
@end
