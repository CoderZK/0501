
//
//  XBJinRR_AgentViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/25.
//  Copyright © 2018年 ahxb. All rights reserved.
//  一键代理

#import "ShareAndPromotionViewController.h"
#import "XBJinRR_ShareBottomView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SGActionView.h"
#import <UShareUI/UShareUI.h>

@interface ShareAndPromotionViewController ()
{
    NSString *shareUrl;
}
/**
 *  底部视图
 */
@property(nonatomic, strong) XBJinRR_ShareBottomView *bottomView;
@property(nonatomic, strong) UIImageView *bigImageView;
/**
 *  二维码图
 */
@property(nonatomic, strong)UIImageView *codeImageView;

/**
 *  获取到的专属海报信息
 */
@property(nonatomic, copy)NSDictionary *posterInfoDic;
@end

@implementation ShareAndPromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavWithTitle:@"分享推广" isShowBack:YES];

    shareUrl = @"";
    [self creatBottomView];
    [self creatMainUI];
    [self getUrldata];
}


#pragma mark -- 配置全局大图
- (void )creatMainUI{
    self.bigImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.bigImageView];
//    self.bigImageView.image = [UIImage imageNamed:@"share_img"];
    [self.bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(0);
    }];
    
    
    self.codeImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    self.codeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bigImageView addSubview:self.codeImageView];
//    self.codeImageView.image = [UIImage imageNamed:@"share_img"];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-SIZE(70));
        make.bottom.offset(-SIZE(70));
        make.width.height.mas_equalTo(SIZE(100));
    }];
}
-(void)getUrldata
{
    WS(bself);
    [self.view showLoadMessageAtCenter:@"二维码生成中..."];
    [XBJinRRNetworkApiManager shareWithBlock:^(id data) {
        
        if (rusultIsCorrect) {
            //            NSString *contentStr = [data[@"data"][@"Contents"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *url = [data[@"data"][@"url2"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            bself.posterInfoDic = data[@"data"];
            [bself.bigImageView sd_setImageWithURL:[NSURL URLWithString:url]];
//            bself.codeImageView.image = [LLUtils qrImageForString:url imageSize:100 logoImageSize:80];
            [bself.view hide];
        }else{
            [bself.view hide];
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            [bself.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *errorString) {
        [bself.view hide];
    }];
}

//#pragma mark -- 获取我的专属海报
//- (void )getLoadShareMyPosterWithID{
//    [self.view showLoadMessageAtCenter:@"加载数据中..."];
//
//    WS(bself);
//    [XBJinRRNetworkApiManager getRongkePosterBlock:^(id data) {
//        MyLog(@"%@",data);
//        [bself.view hide];
//        if (rusultIsCorrect) {
//            /**
//             "ID":"产品ID",
//             "Itype":"产品类型  1平台网贷   2信用卡贷",
//             "Name":"产品名称",
//             "GoodsNo":"产品编码",
//             "Openurl":"外链地址",
//             "ZsUrl1":"专属海报一",
//             "ZsUrl2":"专属海报二",
//             "ZsUrl3":"专属海报三",
//             "shareurl":"我的分享地址"
//             */
//
//            bself.posterInfoDic = data[@"data"];
//        }else{
//
//        }
//    } fail:^(NSError *errorString) {
//        [bself.view hide];
//    }];
//}
//-(void)setPosterInfoDic:(NSDictionary *)posterInfoDic{
//    _posterInfoDic = posterInfoDic;
////    [bigImageView sd_setImageWithURL:[NSURL URLWithString:posterInfoDic[@"url2"]]];
//    [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:@""s]];
//}

#pragma mark -- 创建bottomView
- (void )creatBottomView{
    WS(bself);
    self.bottomView = [[XBJinRR_ShareBottomView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.bottomView.clickOrderIndexCallBack = ^(NSInteger index) {
        switch (index) {
            case 0:
                //分享海报
                self->shareUrl = @"";
                [bself creatShareView];
                break;
            case 1:
                //分享链接
                self->shareUrl = bself.posterInfoDic[@"shareurl"];
                [bself creatShareView];
                break;
            case 2:
            {
                //保存海报
                [Dialog toastCenter:@"保存成功"];
                UIImage * image = [bself captureImageFromView:bself.bigImageView.frame];
                ALAssetsLibrary * library = [ALAssetsLibrary new];
                NSData * data = UIImageJPEGRepresentation(image, 1.0);
                [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
                
            }
                break;
            case 3:
            {
                //复制链接
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = bself.posterInfoDic[@"shareurl"];
                if (pasteboard == nil) {
                    [Dialog toastCenter:@"复制失败"];
                }else
                {
                    [Dialog toastCenter:@"复制成功"];
                }
            }
                break;
                
            default:
                break;
        }
    };
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(SIZE(70));
        make.bottom.mas_equalTo([[UIApplication sharedApplication] statusBarFrame].size.height>20?-34:0);
    }];
}

//截图功能

-(UIImage *)captureImageFromView:(CGRect )frame{
    
    UIGraphicsBeginImageContextWithOptions(frame.size,NO, 0);
    
    [[UIColor clearColor] setFill];
    
    [[UIBezierPath bezierPathWithRect:frame] fill];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.bigImageView.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

-(void)shareToFriends
{
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [self shareTextToPlatformType:platformType];
        NSLog(@"%ld",platformType);
    }];
}

#pragma mark -- 创建分享视图

- (void )creatShareView{
    //    self.posterInfoDic[@"shareurl"]//分享地址
    WS(wself);
    [SGActionView showGridMenuWithTitle:@"分享到"
                             itemTitles:@[ @"微信好友", @"QQ", @"QQ空间", @"朋友圈"]
                                 images:@[ [UIImage imageNamed:@"share_weixn"],
                                           [UIImage imageNamed:@"share_qq"],
                                           [UIImage imageNamed:@"share_space"],
                                           [UIImage imageNamed:@"share_friends"]]
                         selectedHandle:^(NSInteger index) {
                             switch (index) {
                                 case 1:
                                     if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                                         [wself shareTextToPlatformType:UMSocialPlatformType_WechatSession];
                                     }
                                     break;
                                 case 2:
                                     if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                                         [wself shareTextToPlatformType:UMSocialPlatformType_QQ];
                                     }
                                     break;
                                 case 3:
                                     if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
                                         [wself shareTextToPlatformType:UMSocialPlatformType_Qzone];
                                     }
                                     break;
                                 case 4:
                                     if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                                         [wself shareTextToPlatformType:UMSocialPlatformType_WechatTimeLine];
                                     }
                                     break;
                                 case 5:
                                     if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
                                         [wself shareTextToPlatformType:UMSocialPlatformType_Sina];
                                     }
                                     break;
                                 default:
                                     break;
                             }
                         }];
    
    
    
    
    
    
    
}


#pragma mark - share type
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    
    UIImage * image = [self captureImageFromView:self.bigImageView.frame];
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //    //设置文本
    //    messageObject.text = @"";
    
    if (isEmptyStr(shareUrl)) {
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        [shareObject setShareImage:image];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else{
        //链接分享
        //        messageObject.text = shareUrl;
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"融e代向您推荐" descr:@"融e代管理系统，专业的信息管理" thumImage:[UIImage imageNamed:@"logo_icon"]];
        //设置网页地址
        shareObject.webpageUrl = shareUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
        [self alertWithError:error];
    }];
    
    
    
    
    
    
    
    
    
}
- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
        [Dialog toastCenter:result];
    }
    else{
        if ((int)error.code == 2009) {
            result = [NSString stringWithFormat:@"取消分享"];
            [Dialog toastCenter:result];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
            [Dialog toastCenter:result];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
























/*


//
//  ShareAndPromotionViewController.m
//  flApp
//
//  Created by wx on 2018/1/20.
//  Copyright © 2018年 -SZ. All rights reserved.
//

#import "ShareAndPromotionViewController.h"
#import <UShareUI/UShareUI.h>
#import "LDImageAndTitleView.h"
#import "LLUtils.h"


//static NSString* const UMS_Text = @"快来使用美丽优选,买的多返的多";


//static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//static NSString* const UMS_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//
//static NSString* const UMS_WebLink = @"https://bbs.umeng.com/";
//
//static NSString *UMS_SHARE_TBL_CELL = @"UMS_SHARE_TBL_CELL";

@interface ShareAndPromotionViewController ()<UMSocialShareMenuViewDelegate>
{
    UIImageView *bgView;
}
@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) UIImageView *qrV;
@property (nonatomic,strong) UIImageView *bgView;

@property(nonatomic,strong)UILabel * yaoqingmaLabel;

@property (nonatomic,strong) NSArray *shareArray;

@property (nonatomic,strong) UIScrollView *mainScrollView;

@end

@implementation ShareAndPromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shareArray = @[@{@"icon":@"icon_share1",@"title":@"微信好友"},@{@"icon":@"icon_share2",@"title":@"QQ"},@{@"icon":@"icon_share3",@"title":@"QQ空间"},@{@"icon":@"icon_share4",@"title":@"朋友圈"},@{@"icon":@"weibo",@"title":@"微博"}];
    
    
//    [self setNavTitleStr:@"分享推广"];
    [self setNavWithTitle:@"分享推广" isShowBack:YES];
    
//    [self initData];
    
//    [self setNav];
    
    [self createView];
    
    [self getUrldata];
}

-(void)getUrldata
{
    WS(bself);
    [XBJinRRNetworkApiManager shareWithBlock:^(id data) {
        
        if (rusultIsCorrect) {
//            NSString *contentStr = [data[@"data"][@"Contents"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *url = [data[@"data"][@"shareurl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            self.qrV.image = [LLUtils qrImageForString:url imageSize:100 logoImageSize:80];
        }else{
            [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
            [bself.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *errorString) {
        
    }];
    
//    [[APIManager sharedManager] get2DUrlWithCallBack:^(id data) {
//        if ([data[@"result"] integerValue] == 1) {
//            NSDictionary *dict = data[@"data"];
//            _url = dict[@"Url"];
////            [_bgView sd_setImageWithURL:[NSURL URLWithString:dict[@"Pic"]] placeholderImage:nil];
//            _qrV.image = [LLUtils qrImageForString:_url imageSize:SIZEFIT(150) logoImageSize:SIZEFIT(150)];
//        }
//    } fail:^(NSString *errorString) {
//
//    }];
    
//    [[APIManager sharedManager] getGetUserBaseInfoCallBack:^(id data) {
//        UserInfoModel * userInfo =  [UserInfoModel mj_objectWithKeyValues:data];
//        _yaoqingmaLabel.text = [LLUtils strRelay:userInfo.Code];
//
//    } fail:^(NSString *errorString) {
//    }];
    
}

-(void)initData
{
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
//                                               @(UMSocialPlatformType_WechatTimeLine),
//                                               @(UMSocialPlatformType_WechatFavorite),
//                                               @(UMSocialPlatformType_QQ),
//                                               @(UMSocialPlatformType_Tim),
//                                               @(UMSocialPlatformType_Qzone),
//                                               @(UMSocialPlatformType_Sina),
//                                               @(UMSocialPlatformType_TencentWb),
//                                               @(UMSocialPlatformType_AlipaySession),
//                                               @(UMSocialPlatformType_DingDing),
//                                               @(UMSocialPlatformType_Renren),
//                                               @(UMSocialPlatformType_Douban),
//                                               @(UMSocialPlatformType_Sms),
//                                               @(UMSocialPlatformType_Email),
//                                               @(UMSocialPlatformType_Facebook),
//                                               @(UMSocialPlatformType_FaceBookMessenger),
//                                               @(UMSocialPlatformType_Twitter),
//                                               @(UMSocialPlatformType_LaiWangSession),
//                                               @(UMSocialPlatformType_LaiWangTimeLine),
//                                               @(UMSocialPlatformType_YixinSession),
//                                               @(UMSocialPlatformType_YixinTimeLine),
//                                               @(UMSocialPlatformType_YixinFavorite),
//                                               @(UMSocialPlatformType_Instagram),
//                                               @(UMSocialPlatformType_Line),
//                                               @(UMSocialPlatformType_Whatsapp),
//                                               @(UMSocialPlatformType_Linkedin),
//                                               @(UMSocialPlatformType_Flickr),
//                                               @(UMSocialPlatformType_KakaoTalk),
//                                               @(UMSocialPlatformType_Pinterest),
//                                               @(UMSocialPlatformType_Tumblr),
//                                               @(UMSocialPlatformType_YouDaoNote),
//                                               @(UMSocialPlatformType_EverNote),
//                                               @(UMSocialPlatformType_GooglePlus),
//                                               @(UMSocialPlatformType_Pocket),
//                                               @(UMSocialPlatformType_DropBox),
//                                               @(UMSocialPlatformType_VKontakte),
//                                               @(UMSocialPlatformType_UserDefine_Begin+1),
//                                               ]];
//
//    //设置分享面板的显示和隐藏的代理回调
//    [UMSocialUIManager setShareMenuViewDelegate:self];
}

-(void)setNav
{
//    [self addCustomNavigation];
//    [self addCustomNavigationTitle:@"我的二维码"];
}

-(void)goBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.view insertSubview:_bgView atIndex:0];
}

-(void)createView
{
//    self.automaticallyAdjustsScrollViewInsets = NO;
//
    UIImageView *bgV = [UIImageView new];
    bgV.backgroundColor = [UIColor yellowColor];
//    bgV.image = [UIImage imageNamed:@"shopping_bg"];
    [self.view addSubview:bgV];
    _bgView = bgV;
    
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.left.bottom.right.offset(0);
        make.top.offset(NAV_HEIGHT);
    }];
    
    UIImageView *topV = [UIImageView new];
//    topV.image = [UIImage imageNamed:@"top_shopping"];
    [bgV addSubview:topV];
    
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(NAV_HEIGHT+SIZEFIT(10));
        make.width.equalTo(@(300));
        make.height.offset(SIZEFIT(220));
    }];
//
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
//    mainScrollView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    mainScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAV_HEIGHT);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
//    UIView *mainView = [[UIView alloc] init];
//    [self.view addSubview:mainView];
//    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self.view).offset(0);
//        make.top.equalTo(self.view.mas_top).offset(NAV_HEIGHT);
//        make.width.offset(SCREEN_WIDTH);
//        make.height.offset(SCREEN_HEIGHT);
//    }];
    
    
    UILabel *step1Label = [[UILabel alloc] init];
    step1Label.font = [UIFont systemFontOfSize:15];
    step1Label.textColor = [UIColor grayColor];
    step1Label.text = @"1.让朋友用手机扫描下面的二维码即可安装：";
    [mainScrollView addSubview:step1Label];
    [step1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainScrollView.mas_top).offset(15);
        make.left.equalTo(mainScrollView.mas_left).offset(10);
    }];
    
    bgView = [[UIImageView alloc] init];
    bgView.contentMode = UIViewContentModeScaleAspectFit;
    bgView.image = [UIImage imageNamed:@"share_img"];
    [mainScrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(step1Label.mas_bottom).offset(15);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
//        make.left.right.offset(0);
        make.width.offset(SCREEN_WIDTH-SIZE(30));
        make.height.offset((SCREEN_WIDTH-SIZE(30))*1.3);
    }];
    
    UIImageView *qrV = [UIImageView new];
    qrV.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:qrV];
    _qrV = qrV;
    [qrV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->bgView.mas_centerX).offset(-80);
//        make.centerY.equalTo(self->bgView.mas_centerY).offset(140);
        make.bottom.equalTo(self->bgView.mas_bottom).offset(-20);
    }];
    
    UILabel *step2Label = [[UILabel alloc] init];
    step2Label.font = [UIFont systemFontOfSize:15];
    step2Label.textColor = [UIColor grayColor];
    step2Label.text = @"2.你也可以通过以下方式分享给朋友：";
    [mainScrollView addSubview:step2Label];
    [step2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->bgView.mas_bottom).offset(25);
        make.left.equalTo(mainScrollView.mas_left).offset(10);
    }];
    
    
//
    [qrV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
//        make.top.equalTo(topV.mas_bottom).offset(SIZEFIT(20));
        make.centerY.offset(0);
        make.width.height.equalTo(@(SIZEFIT(150)));
    }];
//
    
    UIView *shareBg = [[UIView alloc] init];
    shareBg.backgroundColor = [UIColor whiteColor];
    shareBg.frame = CGRectMake(0, SCREEN_HEIGHT-150, SCREEN_WIDTH, 150);
    [mainScrollView addSubview:shareBg];
    [shareBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(step2Label.mas_bottom).offset(15);
        make.centerX.equalTo(mainScrollView.mas_centerX).offset(0);
        make.width.offset(SCREEN_WIDTH);
        make.height.offset(150);
    }];
    
    
    
    
    WS(wself);
    for (int i = 0; i < self.shareArray.count; i++) {
        LDImageAndTitleView *button = [[LDImageAndTitleView alloc] init];
        button.tag = i;
        NSDictionary *dict = self.shareArray[i];
        button.titleLB.text = dict[@"title"];
        button.titleLB.textColor = [UIColor blackColor];
        button.imageView.image = [UIImage imageNamed:dict[@"icon"]];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.imageView.frame = CGRectMake(0, 0, 25, 25);
        CGFloat w = SCREEN_WIDTH / 3;
        CGFloat h = 150 / 2;
        CGFloat y = (i / 3) * h;
        CGFloat x = (i%3) * w;
        
        button.frame = CGRectMake(x, y, w, h);
        [shareBg addSubview:button];
        
        button.viewClickCallBack = ^(UIImageView *imageView, UILabel *titleLB, LDImageAndTitleView *titleView) {
            
            
            if (titleView.tag == 0) {
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_WechatSession];
                }
            } else if (titleView.tag == 1) {
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_QQ];
                }
                
            } else if (titleView.tag == 2) {
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_Qzone];
                }
                
            } else if (titleView.tag == 3) {
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_WechatTimeLine];
                }
                
            } else if (titleView.tag == 4) {
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_Sina];
                }
            } else {
                [wself saveToAlbum];
            }
            
        };
    }
    
//    UILabel * lb = [[UILabel alloc]init];
//    lb.textColor = [UIColor whiteColor];
//    lb.text = @"我的专属邀请码";
//    lb.font = [MyAdapter lfontADapter:16];
//    [self.view addSubview:lb];
//    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(qrV.mas_bottom).offset(SIZEFIT(20));
//        make.centerX.offset(0);
//    }];
    
//    _yaoqingmaLabel = [[UILabel alloc]init];
//    _yaoqingmaLabel.textColor = [UIColor whiteColor];
//    _yaoqingmaLabel.font = [MyAdapter lfontADapter:20];
//    [self.view addSubview:_yaoqingmaLabel];
//    [_yaoqingmaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lb.mas_bottom).offset(SIZEFIT(10));
//        make.centerX.offset(0);
//    }];
    
//    UIButton * copy_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [copy_btn setBackgroundColor:[UIColor whiteColor]];
//    copy_btn.titleLabel.font = [MyAdapter lfontADapter:16];
//    [copy_btn addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
//    [copy_btn doBorderCornerRadius:[MyAdapter laDapter:13]];
//    [copy_btn setTitle:@"复制" forState:UIControlStateNormal];
//    [copy_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:copy_btn];
//    [copy_btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_yaoqingmaLabel);
//        make.right.offset([MyAdapter laDapter:-60]);
//        make.height.offset([MyAdapter laDapter:26]);
//        make.width.offset([MyAdapter laDapter:70]);
//    }];
    
//    UIButton *btnSave = [UIButton new];
//    btnSave.highlighted = NO;
//    [btnSave setImage:[UIImage imageNamed:@"btn_imgbao"] forState:UIControlStateNormal];
//    [btnSave addTarget:self action:@selector(saveToAlbum) forControlEvents:UIControlEventTouchUpInside];
//    btnSave.backgroundColor = [UIColor clearColor];
//
//    [self.view addSubview:btnSave];
//    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_yaoqingmaLabel.mas_bottom).offset(SIZEFIT(20));
//        make.left.offset(SIZEFIT(55));
//        make.width.mas_equalTo(SIZEFIT(120));
//        make.height.offset(SIZEFIT(40));
//    }];
//
//    UIButton *btnShare = [UIButton new];
//    [btnShare setImage:[UIImage imageNamed:@"btn_imgshare"] forState:UIControlStateNormal];
//    [btnShare addTarget:self action:@selector(shareToFriends) forControlEvents:UIControlEventTouchUpInside];
//    btnShare.backgroundColor = [UIColor clearColor];
//
//    [self.view addSubview:btnShare];
//    [btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_yaoqingmaLabel.mas_bottom).offset(SIZEFIT(20));
//        make.right.offset(SIZEFIT(-55));
//        make.width.mas_equalTo(SIZEFIT(120));
//        make.height.offset(SIZEFIT(40));
//    }];
    
    [mainScrollView layoutIfNeeded];
    [mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH-SIZE(30))*1.3+300)];
}

-(void)copyAction
{
    if (_yaoqingmaLabel.text&&_yaoqingmaLabel.text.length>0) {
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        [pab setString:_yaoqingmaLabel.text];
        if (pab == nil) {
//            [Dialog toastCenter:@"复制失败,请重新尝试"];
        }else{
//            [Dialog toastCenter:@"复制成功，可以发给朋友们了"];
        }
    }else{
//        [Dialog toastCenter:@"获取专属邀请码失败，请稍后重试"];
    }
    

}

-(void)saveToAlbum
{
//    UIImage * image = [self captureImageFromView:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    
//    ALAssetsLibrary * library = [ALAssetsLibrary new];
//    
//    NSData * data = UIImageJPEGRepresentation(image, 1.0);
//    
//    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//        if (!error) {
//             [Dialog toastCenter:@"保存成功！"];
//        }
//    }];
    
}

//截图功能

-(UIImage *)captureImageFromView:(CGRect )frame{
    
    UIGraphicsBeginImageContextWithOptions(frame.size,NO, 0);

    [[UIColor clearColor] setFill];

    [[UIBezierPath bezierPathWithRect:frame] fill];

    CGContextRef ctx = UIGraphicsGetCurrentContext();

//    [_bgView.layer renderInContext:ctx];

    [bgView.layer renderInContext:ctx];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;

}


-(void)shareToFriends
{
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [self shareTextToPlatformType:platformType];
        NSLog(@"%ld",platformType);
    }];
}

#pragma mark - share type
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    if (_qrV.image == nil) {
        return;
    }
    
    UIImage * image = [self captureImageFromView:bgView.frame];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"";
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    
    [shareObject setShareImage:image];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    WS(bself);
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
        [bself alertWithError:error];
    }];
    
 //
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = UMS_Text;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {

        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
//
}
 
- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
        [Dialog toastCenter:result];
    }
    else{
        if ((int)error.code == 2009) {
            result = [NSString stringWithFormat:@"取消分享"];
            [Dialog toastCenter:result];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
            [Dialog toastCenter:result];
        }
    }
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

*/
