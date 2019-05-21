//
//  XBJinRR_GetCodeCell.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/24.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJinRR_GetCodeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

/**
 *  点击了获取验证码按钮
 */
@property(nonatomic, copy) void(^getCodeBtnCliCkBlock)(void);

- (void)timeDown:(NSInteger)timeNum;

@end
