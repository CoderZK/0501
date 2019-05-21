//
//  XBJinRRWebViewController.h
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/19.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRBaseViewController.h"

/**
 * 1.关于我们  2.产品介绍   3.购买需知  4.版本介绍   5.《使用条款隐私协议》 7.《用户协议》
 */
typedef NS_ENUM(NSInteger,WebType){
    WebTypeAboutUs         = 1,
    WebTypeAppDesc         = 2,
    WebTypeBuyPatient      = 3,
    WebTypeVersionDes      = 4,
    WebTypePrivacyProtocol = 7,
    WebTypeRegistProtocol  = 5,
    

    WebTypeOther = 11
};

@interface XBJinRRWebViewController : XBJinRRBaseViewController

@property(nonatomic,assign)WebType webType;
@property(nonatomic,copy)NSString * titleString;
@property(nonatomic,copy)NSString * htmlString;

- (void)setUrl:(NSString *)url webType:(WebType)webType;
@end
