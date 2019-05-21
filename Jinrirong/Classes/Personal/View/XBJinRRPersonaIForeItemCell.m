//
//  XBJinRRPersonaIForeItemCell.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPersonaIForeItemCell.h"
#import "XBJinRRBankuaisModel.h"

@implementation XBJinRRPersonaIForeItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBtn:)];
    [self.bgImaegView0 addGestureRecognizer:tap0];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBtn:)];
    [self.bgImageView1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBtn:)];
    [self.bgImageView2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBtn:)];
    [self.bgImageView3 addGestureRecognizer:tap3];
    
    self.bgImaegView0.userInteractionEnabled = YES;
    self.bgImageView1.userInteractionEnabled = YES;
    self.bgImageView2.userInteractionEnabled = YES;
    self.bgImageView3.userInteractionEnabled = YES;
}



- (void )clickBtn:(UITapGestureRecognizer *)tapper{
    if (self.clickBlock) {
        self.clickBlock(tapper.view.tag);
    }
}

-(void)setSourceArray:(NSArray *)sourceArray{
    _sourceArray = sourceArray;
    
    
    if (_sourceArray.count>0) {
        XBJinRRBankuaisModel *model = _sourceArray[0];
        self.nameLabel0.text = model.Name;
        self.desLabel0.text = model.Intro;
//        self.iconImageView0
        [self.bgImaegView0 sd_setImageWithURL:[NSURL URLWithString:model.Backurl]];
    }
    if (_sourceArray.count>1) {
        XBJinRRBankuaisModel *model = _sourceArray[1];
        self.nameLabel1.text = model.Name;
        self.desLabel1.text = model.Intro;
        //        self.iconImageView0
        [self.bgImageView1 sd_setImageWithURL:[NSURL URLWithString:model.Backurl]];
    }
    if (_sourceArray.count>2) {
        XBJinRRBankuaisModel *model = _sourceArray[2];
        self.nameLabel2.text = model.Name;
        self.desLabel2.text = model.Intro;
        //        self.iconImageView0
        [self.bgImageView2 sd_setImageWithURL:[NSURL URLWithString:model.Backurl]];
    }
    if (_sourceArray.count>3) {
        XBJinRRBankuaisModel *model = _sourceArray[3];
        self.nameLabel3.text = model.Name;
        self.desLabel3.text = model.Intro;
        //        self.iconImageView0
        [self.bgImageView3 sd_setImageWithURL:[NSURL URLWithString:model.Backurl]];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
