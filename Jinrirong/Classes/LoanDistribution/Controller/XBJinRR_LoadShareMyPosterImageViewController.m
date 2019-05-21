//
//  XBJinRR_LoadShareMyPosterImageViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/5/30.
//  Copyright © 2018年 ahxb. All rights reserved.
//  我的专属海报

#import "XBJinRR_LoadShareMyPosterImageViewController.h"
#import "XBJinRR_ShareBottomView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SGActionView.h"

@interface XBJinRR_LoadShareMyPosterImageViewController ()
{
    UIImageView *bigImageView;//大图
    UIImageView *leftImageView;//左小图
    UIImageView *centerImageView;//中小图
    UIImageView *rightImageView;//右小图
    NSString *shareUrl;
}
/**
 *  获取到的专属海报信息
 */
@property(nonatomic, copy)NSDictionary *posterInfoDic;
/**
 *  底部视图
 */
@property(nonatomic, strong) XBJinRR_ShareBottomView *bottomView;
@end

@implementation XBJinRR_LoadShareMyPosterImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [LLUtils clearFileBlock:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavWithTitle:@"我的专属海报" isShowBack:YES];
    shareUrl = @"";
    [self creatBottomView];
    [self creatUI];
    [self getLoadShareMyPosterWithID];
}

#pragma mark -- 获取我的专属海报
- (void )getLoadShareMyPosterWithID{
    WS(bself);
    [self.view showLoadMessageAtCenter:@"海报生成中..."];
    [XBJinRRNetworkApiManager getLoadShareMyPosterWithID:self.ID Block:^(id data) {
        MyLog(@"%@",data);
        [bself.view hide];
        if (rusultIsCorrect) {
            /**
             "ID":"产品ID",
             "Itype":"产品类型  1平台网贷   2信用卡贷",
             "Name":"产品名称",
             "GoodsNo":"产品编码",
             "Openurl":"外链地址",
             "ZsUrl1":"专属海报一",
             "ZsUrl2":"专属海报二",
             "ZsUrl3":"专属海报三",
             "shareurl":"我的分享地址"
             */
            bself.posterInfoDic = data[@"data"];
        }
    } fail:^(NSError *errorString) {
        [bself.view hide];
    }];
}
-(void)setPosterInfoDic:(NSDictionary *)posterInfoDic{
    _posterInfoDic = posterInfoDic;
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:posterInfoDic[@"ZsUrl1"]]];
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:posterInfoDic[@"ZsUrl1"]]];
    [centerImageView sd_setImageWithURL:[NSURL URLWithString:posterInfoDic[@"ZsUrl2"]]];
    [rightImageView sd_setImageWithURL:[NSURL URLWithString:posterInfoDic[@"ZsUrl3"]]];

}




#pragma mark -- 创建界面
- (void )creatUI{
    bigImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bigImageView];
    leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:leftImageView];
    centerImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:centerImageView];
    rightImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:rightImageView];
    
    
    CGFloat width = (SCREEN_WIDTH -SIZE(100))/3.f;
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE(40));
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-SIZE(30));
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(width*1.2);
    }];
    [centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->leftImageView.mas_right).offset(SIZE(10));
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-SIZE(30));
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(width*1.2);
    }];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->centerImageView.mas_right).offset(SIZE(10));
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-SIZE(30));
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(width*1.2);
    }];
    
    
    [bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE(20)+NAV_HEIGHT);
        make.left.mas_equalTo(SIZE(40));
        make.right.mas_equalTo(SIZE(-40));
        make.bottom.mas_equalTo(self->rightImageView.mas_top).offset(-SIZE(20));
    }];
    leftImageView.tag = 0;
    centerImageView.tag = 1;
    rightImageView.tag = 2;
    leftImageView.userInteractionEnabled = YES;
    centerImageView.userInteractionEnabled = YES;
    rightImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedImage:)];
    [leftImageView addGestureRecognizer:tap0];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedImage:)];
    [centerImageView addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedImage:)];
    [rightImageView addGestureRecognizer:tap2];
}


- (void )selectedImage:(UITapGestureRecognizer *)tapper{
    NSString *imgUrl;
    switch (tapper.view.tag) {
        case 0:
        {
            imgUrl = self.posterInfoDic[@"ZsUrl1"];
        }
            break;
        case 1:
        {
            imgUrl = self.posterInfoDic[@"ZsUrl2"];
        }
            break;
        case 2:
        {
            imgUrl = self.posterInfoDic[@"ZsUrl3"];
        }
            break;
            
        default:
            break;
    }
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

#pragma mark -- 创建bottomView
- (void )creatBottomView{
    XBJinRR_ShareBottomView *bottomView = [[XBJinRR_ShareBottomView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    WS(bself);
    bottomView.clickOrderIndexCallBack = ^(NSInteger index) {
        switch (index) {
            case 0:
                //分享海报
                self->shareUrl = @"";
                [self creatShareView];
                break;
            case 1:
                //分享链接
                self->shareUrl = bself.posterInfoDic[@"shareurl"];
                [self creatShareView];
                break;
            case 2:
            {
                //保存海报
                [Dialog toastCenter:@"保存成功"];
                UIImage * image = [bself captureImageFromView:self->bigImageView.frame];
                ALAssetsLibrary * library = [ALAssetsLibrary new];
                NSData * data = UIImageJPEGRepresentation(image, 1.0);
                [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];

            }
                break;
            case 3:
            {
                //复制链接
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = self.posterInfoDic[@"shareurl"];
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
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [bigImageView.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}






#pragma mark -- 创建分享视图

- (void )creatShareView{
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
    
    UIImage * image = [self captureImageFromView:bigImageView.frame];
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
