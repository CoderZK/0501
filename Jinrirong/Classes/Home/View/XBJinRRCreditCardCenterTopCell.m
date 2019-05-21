//
//  XBJinRRCreditCardCenterTopCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/1.
//  Copyright © 2018年 ahxb. All rights reserved.
//  信用卡中心  顶部cell

#import "XBJinRRCreditCardCenterTopCell.h"


@implementation XBJinRRCreditCardCenterTopCell
{
    UIView *leftBgView;
    UIView *rightTopBgView;
    UIView *rightBottomBgView;
    
    UILabel *leftTitleLabel;
    UILabel *leftDeslabel;
    UIImageView *leftImageView;
    
    UILabel *rightTopTitleLabel;
    UILabel *rightTopDeslabel;
    UIImageView *rightTopImageView;
    
    UILabel *rightBottomTitleLabel;
    UILabel *rightBottomDeslabel;
    UIImageView *rightBottomImageView;
    UIView *line0;
    UIView *line1;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    leftBgView  = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:leftBgView];
    rightTopBgView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:rightTopBgView];
    rightBottomBgView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:rightBottomBgView];
    
    CGFloat width = (SCREEN_WIDTH-1)/2.f;
    [leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.offset(0);
        make.width.mas_equalTo(width);
    }];
    //竖线
    line0 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:NORMAL_BGCOLOR];
    [self.contentView addSubview:line0];
    //横线
    line1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:NORMAL_BGCOLOR];
    [self.contentView addSubview:line1];
    
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->leftBgView.mas_right).offset(0);
        make.width.mas_equalTo(1);
        make.top.bottom.offset(0);
    }];
    CGFloat height = (SIZE(160)-1)/2.f;
    [rightTopBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.offset(0);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(self->line0.mas_right).offset(0);
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.left.mas_equalTo(self->line0.mas_right).offset(0);
        make.top.mas_equalTo(self->rightTopBgView.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
    [rightBottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(0);
        make.top.mas_equalTo(self->line1.mas_bottom).offset(1);
        make.left.mas_equalTo(self->line0.mas_right).offset(0);
    }];
    
    leftTitleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"leftTitleLabel" textColor:MainColor textAlignment:Left font:FONT(15)];
    [leftBgView addSubview:leftTitleLabel];
    leftDeslabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"leftDeslabel" textColor:RGB(185, 185, 185) textAlignment:Left font:FONT(12)];
    [leftBgView addSubview:leftDeslabel];
    leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"creditcard_pic"];
    [leftBgView addSubview:leftImageView];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(10));
        make.right.offset(SIZE(-30));
        make.bottom.offset(SIZE(-10));
        make.top.mas_equalTo(self->leftBgView.mas_centerY).offset(-5);
    }];
    [leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(SIZE(10));
        make.right.offset(-SIZE(30));
    }];
    [leftDeslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->leftTitleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(self->leftTitleLabel.mas_left).offset(0);
        make.right.mas_equalTo(self->leftTitleLabel.mas_right).offset(0);
        make.bottom.mas_equalTo(self->leftBgView.mas_centerY).offset(-6);
        make.height.mas_equalTo(self->leftTitleLabel.mas_height);
    }];
    
    
    
    
    rightTopTitleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"rightTopTitleLabel" textColor:RGB(255, 181, 16) textAlignment:Left font:FONT(15)];
    [rightTopBgView addSubview:rightTopTitleLabel];
    rightTopDeslabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"rightTopDeslabel" textColor:RGB(185, 185, 185) textAlignment:Left font:FONT(12)];
    [rightTopBgView addSubview:rightTopDeslabel];
    rightTopImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"creditcard_pic"];
    [rightTopBgView addSubview:rightTopImageView];
    rightTopImageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightTopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZE(15));
        make.right.offset(SIZE(-10));
        make.bottom.offset(SIZE(-15));
        make.width.mas_equalTo(self->rightTopBgView.mas_width).multipliedBy(0.3);
    }];
    [rightTopTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(SIZE(15));
        make.bottom.mas_equalTo(self->rightTopBgView.mas_centerY).offset(0);
        make.right.mas_equalTo(self->rightTopImageView.mas_left).offset(-5);
    }];
    [rightTopDeslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->rightTopTitleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(self->rightTopTitleLabel.mas_left).offset(0);
//        make.right.mas_equalTo(self->rightTopTitleLabel.mas_right).offset(0);
        make.bottom.mas_equalTo(self->rightTopBgView.mas_bottom).offset(SIZE(-15));
        make.width.mas_equalTo(self->rightTopTitleLabel.mas_width);
    }];
    
    
    rightBottomTitleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"rightBottomTitleLabel" textColor:RGB(255, 50, 50) textAlignment:Left font:FONT(15)];
    [rightBottomBgView addSubview:rightBottomTitleLabel];
    rightBottomDeslabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"rightBottomDeslabel" textColor:RGB(185, 185, 185) textAlignment:Left font:FONT(12)];
    [rightBottomBgView addSubview:rightBottomDeslabel];
    rightBottomImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"creditcard_pic"];
    [rightBottomBgView addSubview:rightBottomImageView];
    rightBottomBgView.contentMode = UIViewContentModeScaleAspectFit;
    [rightBottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZE(15));
        make.right.offset(SIZE(-10));
        make.bottom.offset(SIZE(-15));
        make.width.mas_equalTo(self->rightBottomBgView.mas_width).multipliedBy(0.3);
    }];
    [rightBottomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(SIZE(15));
        make.bottom.mas_equalTo(self->rightBottomBgView.mas_centerY).offset(0);
        make.right.mas_equalTo(self->rightBottomImageView.mas_left).offset(-5);
    }];
    [rightBottomDeslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->rightBottomTitleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(self->rightBottomTitleLabel.mas_left).offset(0);
        make.bottom.mas_equalTo(self->rightBottomBgView.mas_bottom).offset(SIZE(-15));
        make.width.mas_equalTo(self->rightBottomTitleLabel.mas_width);
    }];
    leftBgView.tag =0;
    rightTopBgView.tag =1;
    rightBottomBgView.tag =2;
    leftBgView.userInteractionEnabled = YES;
    rightTopBgView.userInteractionEnabled = YES;
    rightBottomBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [leftBgView addGestureRecognizer:tap0];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [rightTopBgView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [rightBottomBgView addGestureRecognizer:tap2];
}

- (void )tapClick:(UITapGestureRecognizer *)tapper{
    XBJinRRCreditCardModel *model = _infoArray[tapper.view.tag];
    if (self.clcickBlock) {
        self.clcickBlock(model);
    }
}


- (void)setInfoArray:(NSArray *)infoArray{
    _infoArray = infoArray;
    
    if (infoArray.count>=3) {
        XBJinRRCreditCardModel *model0 = infoArray[0];
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:model0.Logurl]];
        leftTitleLabel.text = model0.Name;
        leftDeslabel.text = model0.Intro;
        
        XBJinRRCreditCardModel *model1 = infoArray[1];
        [rightTopImageView sd_setImageWithURL:[NSURL URLWithString:model1.Logurl]];
        rightTopTitleLabel.text = model1.Name;
        rightTopDeslabel.text = model1.Intro;
        
        XBJinRRCreditCardModel *model2 = infoArray[2];
        [rightBottomImageView sd_setImageWithURL:[NSURL URLWithString:model2.Logurl]];
        rightBottomTitleLabel.text = model2.Name;
        rightBottomDeslabel.text = model2.Intro;
        
        return;
    }
    if (infoArray.count==2) {
        XBJinRRCreditCardModel *model0 = infoArray[0];
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:model0.Logurl]];
        leftTitleLabel.text = model0.Name;
        leftDeslabel.text = model0.Intro;
        
        XBJinRRCreditCardModel *model1 = infoArray[1];
        [rightTopImageView sd_setImageWithURL:[NSURL URLWithString:model1.Logurl]];
        rightTopTitleLabel.text = model1.Name;
        rightTopDeslabel.text = model1.Intro;
        
        rightBottomBgView.hidden = YES;
        line1.hidden = YES;
        CGFloat width = (SCREEN_WIDTH-1)/2.f;
        [leftBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.offset(0);
            make.width.mas_equalTo(width);
        }];
        [line0 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->leftBgView.mas_right).offset(0);
            make.width.mas_equalTo(1);
            make.top.bottom.offset(0);
        }];
        [rightTopBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.offset(0);
            make.left.mas_equalTo(self->line0.mas_right).offset(0);
        }];
        [leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SIZE(10));
            make.right.offset(SIZE(-30));
            make.bottom.offset(SIZE(-10));
            make.top.mas_equalTo(self->leftBgView.mas_centerY).offset(5);
        }];
        [leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(SIZE(10));
            make.right.offset(-SIZE(30));
        }];
        [leftDeslabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->leftTitleLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self->leftTitleLabel.mas_left).offset(0);
            make.right.mas_equalTo(self->leftTitleLabel.mas_right).offset(0);
            make.bottom.mas_equalTo(self->leftBgView.mas_centerY).offset(0);
            make.height.mas_equalTo(self->leftTitleLabel.mas_height);
        }];
        
        
        [rightTopImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SIZE(10));
            make.right.offset(SIZE(-30));
            make.bottom.offset(SIZE(-10));
            make.top.mas_equalTo(self->rightTopBgView.mas_centerY).offset(5);
        }];
        [rightTopTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(SIZE(10));
            make.right.offset(-SIZE(30));
        }];
        [rightTopDeslabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->rightTopTitleLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self->rightTopTitleLabel.mas_left).offset(0);
            make.right.mas_equalTo(self->rightTopTitleLabel.mas_right).offset(0);
            make.bottom.mas_equalTo(self->rightTopBgView.mas_centerY).offset(0);
            make.height.mas_equalTo(self->rightTopTitleLabel.mas_height);
        }];
        
        return;
    }
    if (infoArray.count==1) {
        XBJinRRCreditCardModel *model0 = infoArray[0];
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:model0.Logurl]];
        leftTitleLabel.text = model0.Name;
        leftDeslabel.text = model0.Intro;
        
        XBJinRRCreditCardModel *model1 = infoArray[1];
        [rightTopImageView sd_setImageWithURL:[NSURL URLWithString:model1.Logurl]];
        rightTopTitleLabel.text = model1.Name;
        rightTopDeslabel.text = model1.Intro;
        rightTopBgView.hidden = YES;
        rightBottomBgView.hidden = YES;
        line0.hidden = YES;
        line1.hidden = YES;
        [leftBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.right.offset(0);
        }];
        CGFloat width = SCREEN_WIDTH/2.f;
        [leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(SIZE(10));
            make.left.offset(SIZE(10));
            make.bottom.offset(SIZE(-10));
            make.width.mas_equalTo(width*0.3);
        }];
        [leftTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(SIZE(10));
            make.right.offset(-SIZE(10));
            make.left.mas_equalTo(self->leftImageView.mas_right).offset(5);
            make.bottom.mas_equalTo(self->leftImageView.mas_centerY).offset(0);
        }];
        [leftDeslabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->leftTitleLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self->leftTitleLabel.mas_left).offset(0);
            make.right.mas_equalTo(self->leftTitleLabel.mas_right).offset(0);
            make.bottom.mas_equalTo(self->leftBgView.mas_bottom).offset(SIZE(-10));
        }];
        return;
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
