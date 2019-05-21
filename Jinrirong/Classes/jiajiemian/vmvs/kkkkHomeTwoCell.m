//
//  kkkkHomeTwoCell.m
//  Jinrirong
//
//  Created by zk on 2019/5/8.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import "kkkkHomeTwoCell.h"

@implementation kkkkHomeTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat ww = 50;
        CGFloat w2 = 70;
        CGFloat space = (ScreenW - 4*ww) / 5;
        CGFloat space2 = (ScreenW - 4*w2) / 5;
        NSArray * arr = @[@"动态",@"签到",@"工作计划",@"任务",@"项目",@"日报",@"会议",@"团队"];
        
        
        for (int i = 0; i<arr.count; i++) {
            
            UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(space + (i%4) * (ww + space), 15 + i/4 * (ww + 35), ww, ww)];
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"rrrr_%d",i]];
            [self addSubview:imageV];
            
            UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(space2 + (i%4) * (w2 + space2),15 + 5 + ww+ i/4 * (ww + 35 + 5) , w2, 20)];
            lb.font = [UIFont systemFontOfSize:13];
            lb.textAlignment = NSTextAlignmentCenter;
            lb.centerX = imageV.centerX;
            lb.text = arr[i];
            lb.textColor = RGB(100, 100, 100);
            [self addSubview:lb];
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(space2 + (i%4) * (w2 + space2),15 +i/4 * (ww + 35) , w2, w2)];
            button.tag = i;
            [button addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
        
    }
    return self;
}

- (void)clickAciton:(UIButton *)button {
    if (self.didIndexBlock != nil) {
        self.didIndexBlock(button.tag);
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
