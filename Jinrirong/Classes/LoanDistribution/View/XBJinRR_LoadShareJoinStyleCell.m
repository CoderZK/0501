//
//  XBJinRR_LoadShareJoinStyleCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRR_LoadShareJoinStyleCell.h"

@interface XBJinRR_LoadShareJoinStyleCell()

@property(nonatomic, copy)NSArray *infoArray;
@end

@implementation XBJinRR_LoadShareJoinStyleCell

-(NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray = @[@{@"imageName":@"distributioin-invitation",@"titleStr":@"邀请好友注册"},@{@"imageName":@"distribution-loan",@"titleStr":@"好友完成借贷"},@{@"imageName":@"distribution-receive",@"titleStr":@"领取奖金"}];
    }
    return _infoArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}


- (void )creatUI{
    CGFloat width  = SCREEN_WIDTH/3.f;
    CGFloat height = SIZE(130);
    for (int i=0; i<self.infoArray.count; i++) {
        NSDictionary *infoDic = self.infoArray[i];
        UIView *vi = [self creatUIWithFrame:CGRectMake(width*i, 0, width, height) title:infoDic[@"titleStr"] imageName:infoDic[@"imageName"]];
        [self.contentView addSubview:vi];
    }
}



- (UIView *)creatUIWithFrame:(CGRect )frame title:(NSString *)title imageName:(NSString *)imageName{
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor whiteColor];
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    myImageView.frame = CGRectMake((frame.size.width-SIZE(50))*0.5, frame.size.height*0.6-SIZE(50), SIZE(50), SIZE(50));
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:myImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE(10), frame.size.height*0.6, frame.size.width-SIZE(20),frame.size.height*0.3)];
    titleLabel.text = title;
    titleLabel.font = FONT(14);
    titleLabel.textColor = RGB(120, 120, 120);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    return bgView;
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
