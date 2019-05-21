//
//  XBJinRRNetworkApiManager.h
//  Jinrirong
//
//  Created by ahxb on 2018/5/3.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJinRRNetworkApiManager : NSObject

+ (void)commissionBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

+ (void)productBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

+ (void)centersWithType:(NSString *)type  MemberRecommendBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 首页banner
+ (void)getAdsWithAid:(NSString *)aid num:(NSString *)num block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 滚动字幕
+ (void)getNoticeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取 首页板块 列表
+ (void)getPlateWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark - 获取贷款类型
+ (void)getCateWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取智能推荐网贷，热门网贷列表
+ (void)getItemsWithIsrec:(NSString *)isrec rows:(NSString *)rows block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取 金额类型信息  列表
+ (void)getMoneyTypeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取 我有的贷款类型  列表
+ (void)getCateTypeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取 所需材料  列表
+ (void)getNeedTypeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取 网贷信息 列表
+ (void)getItemsWithPage:(NSInteger)page rows:(NSInteger)rows tid:(NSString *)tid cid:(NSString *)cid nids:(NSString *)nids  jkday:(NSString *)jkday block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取 资讯三个分类
+ (void)newsBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取 分类下的资讯
+ (void)getNewsWithPage:(NSInteger)page rows:(NSInteger)rows cid:(NSString *)cid block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 验证图形验证码接口
+ (void)getCheckImgCodeWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取手机验证码
+ (void)getPhoneCodeWithMobile:(NSString *)mobile type:(NSString *)type code:(NSString *)code block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 会员注册接口
+ (void)registerWithMobile:(NSString *)mobile code:(NSString *)code password:(NSString *)password rid:(NSString *)rid block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取时间戳
+ (void)requestTimestampWithPhone:(NSString *)phone Psw:(NSString *)psw block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 登录
//+ (void)loginWithMobile:(NSString *)mobile token:(NSString *)token block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;
+ (void)loginWithMobile:(NSString *)mobile token:(NSString *)token device_token:(NSString *)device_token block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取会员信息
+ (void)getPersonInfoBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 获取  单页信息（关于我们，注册协议等）   页面
+ (void)getPageWithID:(NSString *)ID block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;


#pragma mark - 获取 我的消息
+ (void)getMyMsgWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark - 分享推广
+ (void)shareWithBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;



#pragma mark - 退出登录
+ (void)logOutBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取网页
+ (void)getTitleContentWithID:(NSInteger)ID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 修改密码
+ (void)changePwdWithParams:(NSDictionary *)params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 修改密码页面验证手机号和验证码是否正确
+ (void)checkCodeIsMatchWithPhoneByParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 修改密码-重置密码
+ (void)resetPwdWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark  上传图片获取url
+ (void )postImage:(NSData *)imageData Block:(void (^)(id data,NSError * error))block;


#pragma mark -- 更新用户信息
+ (void)updateUserInfoWithParams:(NSDictionary *)params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;


#pragma mark - 获取借贷期限
+ (void)getMoneyJktimesBlock:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取贷款产品新品推荐模块数据
+ (void)getposterWithItype:(NSString *)Itype Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;



#pragma mark -- 获取贷款产品列表模块数据
+ (void)getposterWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;



#pragma mark -- 获取贷款分销客户列表（排行榜信息）
+ (void)getLoadShareCustomerWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取贷款分销我的专属海报
+ (void)getLoadShareMyPosterWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取贷款分销融客店推广图
+ (void)getRongkePosterBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取 网贷平台 详情
+ (void)getLoadOpenUrlDetailWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取信用卡中心页推荐卡和热门卡列表
+ (void)getcreditWithIsrec:(NSString *)isrec rows:(NSString *)rows Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取 信用卡中心页 银行列表
+ (void)getbankBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 获取 信用卡中心页 筛选条件数据
+ (void)getCreditCardsCetegoryListWithType:(NSString *)type Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取 信用卡中心页 信用卡列表
+ (void)getCreditCardListWithParams:(NSDictionary *)parmas Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取信用卡中心 卡贷信息详情
+ (void)getcreditCardDetailWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;


#pragma mark -- 获取 客户列表页 信息
+ (void)getclientWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取 我的钱包 信息
+ (void)getwalletWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;


#pragma mark -- 申请提现
+ (void)drawWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;


#pragma mark -- 推荐会员收入  （一级和二级合并）
+ (void)referincomeWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 推广收入网贷and信用卡列表
+ (void)getpromotdataWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;


#pragma mark -- 推荐的会员贷款、查征信时我的收入
+ (void)makeincomeWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;


#pragma mark -- 提交 征信查询的信息
+ (void)submitinfoWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 征信支付
+ (void)orderpayWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 价格列表
+ (void)pricelistBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 征信列表
+ (void)getcredibilityWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 征信列表单条详情
+ (void)getcredibilityDetailWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 再次查询征信
+ (void)regetCredibilityWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 会员中心四板块
+ (void)getbankuaisBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 获取 系统公告和常见问题 列表
+ (void)getnewslistWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 获取 系统公告 详情
+ (void)getnoticeWithID:(NSString *)aID isNews:(BOOL)isNews Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取 代理级别 信息
+ (void)getnoticeBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 购买代理
+ (void)payagentWithParams:(NSDictionary *)Params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;


#pragma mark -- 首页弹窗
+ (void)tanimgBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
    
#pragma mark -- 新手帮助 列表
+ (void)newerhelpsWithParams:(NSDictionary *)params Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 是否有未读消息
+ (void)isnoreadmsgBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 根据客户端和版本号与后台设置的匹配版本号，提示更新下载
+ (void)checkVersionBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 把消息标记为已读状态
+ (void)setreadsWithType:(NSString *)type Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 1.发送支付短信
+ (void)Center_Payment_NowPayWithOrderNo:(NSString *)OrderNo BankNo:(NSString *)BankNo CertNo:(NSString *)CertNo CertName:(NSString *)CertName CertPhone:(NSString *)CertPhone Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 2.支付短信认证
+ (void)Center_Payment_NowPayConfirmWithOrderNo:(NSString *)OrderNo Smscode:(NSString *)Smscode Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 1.发送支付短信
+ (void)Center_Payzenxin_NowPayWithOrderNo:(NSString *)OrderNo BankNo:(NSString *)BankNo CertNo:(NSString *)CertNo CertName:(NSString *)CertName CertPhone:(NSString *)CertPhone Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
#pragma mark -- 2.支付短信认证
+ (void)Center_Payzenxin_NowPayConfirmWithOrderNo:(NSString *)OrderNo Smscode:(NSString *)Smscode Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 获取微信号和微信二维码
+ (void)Core_public_getWechatBlock:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;


///center/member/modifyAdd
#pragma mark -- 修改会员登录IP、所在城市、和手机类型
+ (void)center_member_modifyAddWithip:(NSString *)ip city:(NSString *)city Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
+ (void)productStatisticsWithID:(NSString *)aID Block:(void(^)(id data))block fail:(void(^)(NSError *errorString))fail;
@end
