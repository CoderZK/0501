//
//  XBJinRRAgencyCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRAgencyCell.h"
#import "RadioButton.h"

@interface XBJinRRAgencyCell()
{
    UIButton *radioBtn1;
    RadioButton *radioBtn2;
    RadioButton *radioBtn3;
}
@property (nonatomic,strong) UIButton *lastBtn;
@property (nonatomic,strong) NSMutableArray *buttonArray;
@end

@implementation XBJinRRAgencyCell

-(NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray new];
    }
    return _buttonArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *agencyLabel = [[UILabel alloc] init];
        agencyLabel.font = [UIFont systemFontOfSize:14];
        agencyLabel.textColor = [UIColor blackColor];
        agencyLabel.text = @"代理级别";
        [self.contentView addSubview:agencyLabel];
        [agencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        
        radioBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 60, 44)];
        radioBtn1.tag = 1;
        [radioBtn1 addTarget:self action:@selector(clickRadioBtn:) forControlEvents:UIControlEventTouchUpInside];
        [radioBtn1 setTitle:@"" forState:UIControlStateNormal];
        [radioBtn1 setTitleColor:MainColor forState:UIControlStateNormal];
        radioBtn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [radioBtn1 setImage:[UIImage imageNamed:@"per_agent_selected"] forState:UIControlStateNormal];
        [self.contentView addSubview:radioBtn1];
//        [radioBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-80);
//            make.centerY.equalTo(self.mas_centerY).offset(0);
//        }];
        self.lastBtn = radioBtn1;
        
        radioBtn2 = [[RadioButton alloc] init];
        radioBtn2.tag = 2;
        [radioBtn2 addTarget:self action:@selector(clickRadioBtn:) forControlEvents:UIControlEventTouchUpInside];
        [radioBtn2 setTitle:@"" forState:UIControlStateNormal];
        [radioBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        radioBtn2.titleLabel.font = [UIFont systemFontOfSize:14];
        [radioBtn2 setImage:[UIImage imageNamed:@"per_agent_noselected"] forState:UIControlStateNormal];
        [self.contentView addSubview:radioBtn2];
        [radioBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->radioBtn1.mas_right).offset(15);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        
        radioBtn3 = [[RadioButton alloc] init];
        radioBtn3.tag = 3;
        [radioBtn3 addTarget:self action:@selector(clickRadioBtn:) forControlEvents:UIControlEventTouchUpInside];
        [radioBtn3 setTitle:@"" forState:UIControlStateNormal];
        radioBtn3.titleLabel.font = [UIFont systemFontOfSize:14];
        [radioBtn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [radioBtn3 setImage:[UIImage imageNamed:@"per_agent_noselected"] forState:UIControlStateNormal];
        [self.contentView addSubview:radioBtn3];
        [radioBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->radioBtn2.mas_right).offset(15);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        
        [self.buttonArray addObject:radioBtn1];
        [self.buttonArray addObject:radioBtn2];
        [self.buttonArray addObject:radioBtn3];
        radioBtn1.hidden = YES;
        radioBtn2.hidden = YES;
        radioBtn3.hidden = YES;
    }
    return self;
}


///**
// *  @params agencyArray 代理人数组
// *  @params agencyType  代理人级别
// */
//- (void )setAgencyArray:(NSArray *)agencyArray agencyType:(NSString *)agencyType{
//    
////    会员代理级别  1普通会员  2渠道代理  3团队经理  4城市经理
//    for (int i=0; i<agencyArray.count; i++) {
//        NSDictionary *dic = agencyArray[i];
//        RadioButton *button = self.buttonArray[i];
//        [button setTitle:dic[@"Name"] forState:UIControlStateNormal];
//    }
//}


- (void)setAgencysArray:(NSArray *)agencysArray{
    _agencysArray = agencysArray;
    
    if (_agencysArray.count == 2) {
        [radioBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-80);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
    } else if (_agencysArray.count == 1){
        [radioBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
    } else {
        [radioBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-160);
            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
    }
    
    
    
    for (int i=0; i<_agencysArray.count; i++) {
        NSDictionary *dic = _agencysArray[i];
        RadioButton *button = self.buttonArray[i];
        button.hidden = NO;
        [button setTitle:dic[@"Name"] forState:UIControlStateNormal];
    }
}



- (void)clickRadioBtn:(UIButton *)sender
{
    if (sender != self.lastBtn) {
        [sender setTitleColor:MainColor forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"per_agent_selected"] forState:UIControlStateNormal];
        
        [self.lastBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.lastBtn setImage:[UIImage imageNamed:@"per_agent_noselected"] forState:UIControlStateNormal];
        
        self.lastBtn = sender;
    }
    
    if (self.clickItemBlock) {
        self.clickItemBlock(sender.tag-1);
    }
    
}

@end
