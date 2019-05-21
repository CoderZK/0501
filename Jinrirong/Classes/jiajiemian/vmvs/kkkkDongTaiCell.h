//
//  kkkkDongTaiCell.h
//  Jinrirong
//
//  Created by zk on 2019/5/9.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface kkkkDongTaiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *scanLB;
@property (weak, nonatomic) IBOutlet UILabel *likeLB;
@property (weak, nonatomic) IBOutlet UIButton *scanBt;
@property (weak, nonatomic) IBOutlet UIButton *likeBt;

@end

NS_ASSUME_NONNULL_END
