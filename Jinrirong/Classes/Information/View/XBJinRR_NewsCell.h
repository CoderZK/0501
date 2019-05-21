//
//  XBJinRR_NewsCell.h
//  Jinrirong
//
//  Created by 张艳江 on 2019/4/12.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJinRRNewsListModel.h"

@interface XBJinRR_NewsCell : UITableViewCell

@property (strong, nonatomic) XBJinRRNewsListModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel     *newsTitleLab;
@property (weak, nonatomic) IBOutlet UILabel     *newsTimeLab;
@property (weak, nonatomic) IBOutlet UILabel     *newsSeeLab;
@property (weak, nonatomic) IBOutlet UILabel     *newsTypeLab;

@end

