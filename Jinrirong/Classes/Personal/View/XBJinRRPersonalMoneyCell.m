//
//  XBJinRRPersonalMoneyCell.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/9.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPersonalMoneyCell.h"
#import "HMPopMenu.h"

@interface XBJinRRPersonalMoneyCell()
@property (nonatomic,strong) UILabel *allIncomeLabel;
@property (nonatomic,strong) UILabel *settledLabel;
@property (nonatomic,strong) UILabel *noSettledLabel;
@end

@implementation XBJinRRPersonalMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat w = SCREEN_WIDTH/3;
        
        UILabel *allIncomeLabel = [[UILabel alloc] init];
        allIncomeLabel.textColor = [UIColor blackColor];
        allIncomeLabel.numberOfLines = 2;
        
        allIncomeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:allIncomeLabel];
        [allIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.offset(0);
            make.bottom.offset(0);
            make.width.offset(w);
        }];
        self.allIncomeLabel = allIncomeLabel;
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor lightGrayColor];
        line1.frame = CGRectMake(w, 10, 1, 64-20);
        [self.contentView addSubview:line1];
        
        
        UILabel *settledLabel = [[UILabel alloc] init];
        settledLabel.textColor = [UIColor blackColor];
        settledLabel.numberOfLines = 2;
        
        settledLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:settledLabel];
        [settledLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(w);
            make.top.offset(0);
            make.bottom.offset(0);
            make.width.offset(w);
        }];
        self.settledLabel = settledLabel;
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = [UIColor lightGrayColor];
        line2.frame = CGRectMake(w*2, 10, 1, 64-20);
        [self.contentView addSubview:line2];
        
        UILabel *noSettledLabel = [[UILabel alloc] init];
        noSettledLabel.textColor = [UIColor blackColor];
        noSettledLabel.numberOfLines = 2;
        
        noSettledLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:noSettledLabel];
        [noSettledLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(w*2);
            make.top.offset(0);
            make.bottom.offset(0);
            make.width.offset(w);
        }];
        self.noSettledLabel = noSettledLabel;
        
        
        self.allIncomeLabel.userInteractionEnabled = YES;
        self.settledLabel.userInteractionEnabled = YES;
        self.noSettledLabel.userInteractionEnabled = YES;
        self.allIncomeLabel.tag = 0;
        self.settledLabel.tag = 1;
        self.noSettledLabel.tag = 2;
        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapperClcik:)];
        [self.allIncomeLabel addGestureRecognizer:tap0];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapperClcik:)];
        [self.settledLabel addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapperClcik:)];
        [self.noSettledLabel addGestureRecognizer:tap2];
        
    }
    return self;
}


- (void )tapperClcik:(UITapGestureRecognizer *)tapper{
    if (self.clickBlock) {
        self.clickBlock(tapper.view.tag);
    }
}



- (void)setPersonInfoModel:(XBJinRRPersonInfoModel *)personInfoModel
{
    _personInfoModel = personInfoModel;
    if (personInfoModel == nil) {
        NSString *str = @"￥00.00元\n总收入";
        NSMutableAttributedString * allIncomeString = [[NSMutableAttributedString alloc] initWithString:str];
        NSRange range1 = [str rangeOfString:@"总收入"];
        [allIncomeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(range1.location, 3)];
        [allIncomeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str.length-3)];
        self.allIncomeLabel.attributedText = allIncomeString;
        
        NSString *str2 = @"￥0.00元\n已结算";
        NSMutableAttributedString * settledString = [[NSMutableAttributedString alloc] initWithString:str2];
        NSRange range2 = [str2 rangeOfString:@"已结算"];
        [settledString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(range2.location, 3)];
        [settledString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str2.length-3)];
        self.settledLabel.attributedText = settledString;
        
        NSString *str3 = @"￥0.00元\n可结算";
        NSMutableAttributedString * noSettledString = [[NSMutableAttributedString alloc] initWithString:str3];
        NSRange range3 = [str3 rangeOfString:@"可结算"];
        [noSettledString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(range3.location, 3)];
        [noSettledString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str3.length-3)];
        self.noSettledLabel.attributedText = noSettledString;
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%@\n总收入", personInfoModel.Income];
    NSMutableAttributedString * allIncomeString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:@"总收入"];
    [allIncomeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(range1.location, 3)];
    [allIncomeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str.length-3)];
    self.allIncomeLabel.attributedText = allIncomeString;
//    self.allIncomeLabel.backgroundColor = [UIColor redColor];
    
//    UIImageView *imageMoney = [[UIImageView alloc] init];
//    imageMoney.image = [UIImage imageNamed:@"moneysay"];
//    imageMoney.frame = CGRectMake(0, 0, 20, 20);
//    imageMoney.userInteractionEnabled = YES;
//    imageMoney.center = CGPointMake(SCREEN_WIDTH/3 - 20,self.allIncomeLabel.frame.size.height/2);
//    [self.allIncomeLabel addSubview:imageMoney];
//    
//    UIButton *button = [[UIButton alloc] init];
//    [button addTarget:self action:@selector(buttonMoney) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 0, 20, 20);
////    button.backgroundColor = [UIColor redColor];
//    [imageMoney addSubview:button];

    
    NSString *str2 = [NSString stringWithFormat:@"%@\n已结算", personInfoModel.Account];
    NSMutableAttributedString * settledString = [[NSMutableAttributedString alloc] initWithString:str2];
    NSRange range2 = [str2 rangeOfString:@"已结算"];
    [settledString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(range2.location, 3)];
    [settledString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str2.length-3)];
    self.settledLabel.attributedText = settledString;
    
    NSString *str3 = [NSString stringWithFormat:@"%@\n可结算", personInfoModel.Balance];
    NSMutableAttributedString * noSettledString = [[NSMutableAttributedString alloc] initWithString:str3];
    NSRange range3 = [str3 rangeOfString:@"可结算"];
    [noSettledString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(range3.location, 3)];
    [noSettledString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, str3.length-3)];
    self.noSettledLabel.attributedText = noSettledString;
    
    
}
@end
