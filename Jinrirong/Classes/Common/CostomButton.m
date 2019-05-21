//
//  CostomButton.m
//  NiuNiuJieBa
//
//  Created by 陈舟为 on 2017/2/27.
//  Copyright © 2017年 DaveChen. All rights reserved.
//

#import "CostomButton.h"

@interface CostomButton ()

@end

@implementation CostomButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =  [super initWithFrame:frame] ) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:FONTFIT(15)];
        _titleLable.textAlignment = 1;
        _titleLable.textColor = RGB(69, 69, 69);
        [self addSubview:_titleLable];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(-SIZE(5));
            make.height.mas_equalTo(SIZE(30));
        }];
        
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(SIZE(26));
            make.centerX.mas_equalTo(self->_titleLable.mas_centerX).offset(0);
            make.bottom.mas_equalTo(self->_titleLable.mas_top).offset(0);
            
//            make.left.offset(SIZEFIT(30));
//            make.right.offset(-SIZEFIT(30));
//            make.height.width.offset(SIZEFIT(20));
//            make.top.offset(10);
        }];

        
        _countLab = [[UILabel alloc] init];
        _countLab.layer.masksToBounds = YES;
        _countLab.textAlignment = 1;
        _countLab.textColor = [UIColor whiteColor];
        _countLab.font = [UIFont systemFontOfSize:9];
        [self addSubview:_countLab];
        [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_imgView.mas_right).offset(-5);
            make.bottom.equalTo(self->_imgView.mas_top).offset(55);
        }];
        _countLab.hidden = YES;
    }
    
    return self;
    
}

-(void)setTextLable:(NSString *)textLable{
    
    _textLable = textLable;
    
    _titleLable.text = textLable;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"logo_icon"]];
}

-(void)setImageName:(NSString *)imageName{
    
    _imageName = imageName;
    _imgView.image = [UIImage imageNamed:imageName];
}

-(void)setCount:(NSInteger)count{
        
    _count = count;
    _countLab.hidden =count?NO:YES;
    _countLab.text = [NSString stringWithFormat:@"%ld",count];
    _countLab.backgroundColor = RedColor;
    
//   CGSize size =   [LLUtils getStringSize:[NSString stringWithFormat:@"%ld",count] font:9 width:100];
    
    CGFloat width = count>9?13+4*[self nsinterLength:count]:13;
    
//    if (size.width <= 13) {
//        width = 13;
//    }else{
//        width = size.width +5;
//    }
    
    
  _countLab.layer.cornerRadius  = 13/2.;
    
    [_countLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_imgView.mas_right).offset(-5);
        make.bottom.equalTo(self->_imgView.mas_top).offset(8);
        make.height.offset(13);
        make.width.offset(width);
    }];
}

- (NSInteger)nsinterLength:(NSInteger)x {
    NSInteger sum=0,j=1;
    while( x >= 1 ) {
        x=x/10;
        sum++;
        j=j*10;
    }
    return sum;
}


@end
