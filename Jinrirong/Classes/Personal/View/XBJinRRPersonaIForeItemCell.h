//
//  XBJinRRPersonaIForeItemCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRRPersonaIForeItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel0;
@property (weak, nonatomic) IBOutlet UILabel *desLabel0;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView0;

@property (weak, nonatomic) IBOutlet UIImageView *bgImaegView0;



@property (weak, nonatomic) IBOutlet UILabel *nameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *desLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView1;





@property (weak, nonatomic) IBOutlet UIImageView *iconImageView2;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *desLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView2;


@property (weak, nonatomic) IBOutlet UIImageView *iconImageView3;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel3;
@property (weak, nonatomic) IBOutlet UILabel *desLabel3;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView3;



/**
 *  点击了哪个item
 */
@property(nonatomic, copy)void (^clickBlock)(NSInteger index);
/**
 *  图片及背景数组
 */
@property(nonatomic, copy)NSArray *sourceArray;
@end
