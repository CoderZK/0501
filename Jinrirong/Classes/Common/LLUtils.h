//
//  LLUtils.h
//  StoreIntegral
//
//  Created by kevin on 2016/12/20.
//  Copyright © 2016年 Ecommerce. All rights reserved.
//

typedef enum {
    AlertViewTypeOnlyYes = 1,  //是
    AlertViewTypeYesAndNo,     //是 否
    AlertViewTypeConfirmAndCancel,//确定 取消
    AlertViewTypeOnlyConfirm   //确定
}AlertViewType;

#import <Foundation/Foundation.h>


@interface LLUtils : NSObject


+(NSString *)getPublictTken;

+(NSString *)getToken;

+ (NSString *_Nullable)strRelay:(id _Nullable )str;//自动填补空的字符

+ (NSString *_Nullable)strNilOrEmpty:(id _Nullable )str elseBack:(id _Nullable )back;//自动填补空的字符 为空返回的类型
/**
 将图片缩小到指定尺寸
 image  : 原图片
 size   : 缩小到的尺寸
 return : 缩小的图片
 */
+ (UIImage*_Nullable)OriginImage:(UIImage *_Nullable)image scaleToSize:(CGSize)size;

//显示警告框
//title    : 标题
//message  : 内容
//delegate : 代理
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag type:(AlertViewType)type;

/***********HUD**********************/
+ (void)showOnlyProgressHud;                      //仅仅只有进度条hud
+ (void)showTextAndProgressHud:(NSString *)status; //带进度和文本hud
+ (void)showTextAndProgressHud:(NSString *)status afterDelay:(NSTimeInterval)delay;
+ (void)showOnlyTextHub:(NSString *)text;  //只有文本hud
+ (void)showSuccessHudWithStatus:(NSString *)statusStr; //成功hud
+ (void)showErrorHudWithStatus:(NSString *)statusStr;   //失败hud
+ (void)showInfoHudWithStatus:(NSString *)statusStr;    //感叹号hud
+ (void)dismiss;
+ (void)showAlterView:(UIViewController *)controller title:(NSString *)title message:(NSString *)message yesBtnTitle:(NSString *)yesTitle noBtnTitle:(NSString *)noTitle  yesBlock:(void (^)(void))yesAction  noBlock:(void (^)(void))noAction;
//移除hud
//拨打电话
//phoneStr : 电话号码
+ (void)callPhoneWithPhone:(NSString *)phoneStr;

//将json对象转换成json字符串
//jsonObj : json对象
+ (NSString *)jsonStrWithJSONObject:(id)jsonObj;

//将json字符串转换成json对象
//jsonStr : json字符串
//return  : json对象
+ (id)jsonObjectWithJSONStr:(NSString *)jsonStr;

//去除字符串中unicode编码 / unicode字符转中文字符
//unicodeStr : 含有unicode字符的字符串
//return     : 转换后的字符串（不含unicode编码）
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

//回弹动画
//实现view由小放大再缩小，回弹效果的动画
//view : 要做动画的view
+ (void)showSpringBackAnimationView:(UIView *)view;

//消失动画
//alphaView   : alphaView 要做透明度变化到完全透明的View
//scaleView   : 要做缩放动画的View
//dismissBlock: alphaView从父视图移除时的回调block
+ (void)showDismissAnimationWithAlphaView:(UIView *)alphaView scaleView:(UIView *)scaleView didDismissBlock:(void(^)(void))dismissBlock;

//将时间戳转换成NSDate
//timeStamp  : 时间戳 NSString / NSNumber
//return     : 返回对应的日期 NSDate
+ (NSDate *)dateWithTimeStamp:(id)timeStamp;
//将时间戳转换成NSString
//timeStamp  : 时间戳 NSString / NSNumber
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"
//return     : 返回对应的日期字符串 NSString
+ (NSString *)dateStrWithTimeStamp:(id)timeStamp dateFormat:(NSString *)dateFormat;
//将日期转换成 制定格式的日期字符串
//date       : 待转换日期 NSDate
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"
//return     : 返回对应的日期字符串 NSString
+ (NSString *)dateStrWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;
//将日期字符串 按照相应的格式 转换成对应的 日期
//dateStr    : 待转换日期字符串 NSString
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"  注意：dateFormat参数传入的字符串格式必须和传入的dateStr的格式一致，否则会崩溃!
//return     : 返回对应的日期 NSDate
+ (NSDate *)dateWithDateStr:(NSString *)dateStr dateFormat:(NSString *)dateFormat;

//获取对应日期的时间戳
//date   : NSDate
//return : 时间戳
+ (long long)timestampsWithDate:(NSDate *)date;
//获取对应日期字符串的时间戳
//dateStr   : NSString
//format    :格式化的字符串
//return    : 时间戳
+ (long long)timestampsWithDateStr:(NSString *)dateStr dateFormat:(NSString *)format;


/**
 *  验证手机号 以13、15、17、18开头
 *
 *  @param mobileNum 手机号
 *
 *  @return Yes手机号格式正确
 */
+(BOOL)validateMobile:(NSString *)mobileNum;


/**
 *  验证密码6-20
 *
 *  @param passWord 密码字符串
 *
 *  @return Yes密码格式正确
 */
+(BOOL) validatePassword:(NSString *)passWord;


/**
 *
 *  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于等于maxLength 小于maxLenght
 2. 密码中必须同时包含数字和字母
 */
+(BOOL)validatePassword:(NSString *)pass minLength:(int)minLength maxLength:(int)maxLength;

//UIImage ===> NSData
+ (NSData *)dataWithImage:(UIImage *)image;

//获取n个月之前的日期字符串
//monthIndex : 月份索引 eg . 1 ==> 1月之前
//format     : 格式化日期的格式字符串
//return     : 返回之前的日期
+ (NSString *)previousMonthWithProviceMonthIndex:(NSInteger)monthIndex dateFormat:(NSString *)format;

//判断字符串中是否全部是数字
//string : 要判断你的字符串
//return : YES : 纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string;

//将日期的时分秒置为0
//date   : 需要时分秒置为0的日期
//return : 时分秒置为0的日期
+ (NSDate *)setHourMinSecToZero:(NSDate *)date;

//过滤手机号的86,+86,+86·
+ (NSString *)filterPhoneNum86:(NSString *)phone;

//获取url字符串中某一参数值对应的参数值
//paraName : 要扣取的参数名
//url      : url字符串
//return   : 返回对应参数名的参数值
+ (NSString *)getParaValueWithParaName:(NSString *)paraName url:(NSString *)url;

/**
 获取url的所有参数
 url : 要获取参数的url字符串
 return : 获得的参数字典
 */
+ (NSDictionary *)getUrlParametersWithUrl:(NSString *)url;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

/**
 url编码
 */
+ (NSString *)encodeUrlWithUrlStr:(NSString *)urlStr;
/**
 url解码
 */
+ (NSString *)decodeUrl:(NSString *)str;
/**
 url编码
 encodeURL方法不会对下列字符编码 ASCII字母 数字 ~!@#$&*()=:/,;?+'
 encodeURIComponent方法不会对下列字符编码 ASCII字母 数字 ~!*()'
 所以encodeURIComponent比encodeURI编码的范围更大。
 实际例子来说，encodeURIComponent会把 http:// 编码成 http%3A%2F%2F 而encodeURL却不会。
 */
+ (NSString *)encodeURIComponent:(NSString *)paraStr;

/**
 Create and return a 1x1 point size image with the given color.
 
 @param color  The color.
 */
+ (nullable UIImage *)imageWithColor:(nonnull UIColor *)color;

/**
 Create and return a pure color image with the given color and size.
 
 @param color  The color.
 @param size   New image's type.
 */
+ (nullable UIImage *)imageWithColor:(nonnull UIColor *)color size:(CGSize)size;

/*
 过滤字符串中的html标签 方案一
 */
+ (nullable NSString *)filterHTMLOne:(nullable NSString *)html;

/*
 过滤字符串中的html标签 方案二
 */
+(nullable NSString *)filterHTMLSecond:(nonnull NSString *)html;
/*
 过滤字符串中的html标签 针对于版本更新
 */
+(nullable NSString *)filterHTMLByVersionDes:(nonnull NSString *)html;
/*
 *  让html文本适应屏幕
 */
+(nullable NSString *)reSizeImageWithHTML:(NSString *)html;
/**
根据日期获得星期几
*/
+ (nullable NSString*)weekdayStringFromDate:(nonnull NSDate*)inputDate;

/**
 用某个字符串分割字符串
 originStr  : 原字符串
 decollator : 分割符
 length     : 分割长度
 */
+ (nullable NSString *)separateStr:(nonnull NSString *)originStr decollator:(nonnull NSString *)decollator separateLength:(int)separateLength;

/**
 手机号安全处理，加*处理
 */
+ (nullable NSString *)phoneSecureHandle:(nonnull NSString *)phone;


+ (UIColor *_Nullable)colorWithHex:(NSString *_Nullable)color;

/**
 旋转按钮的剪头
 */
+ (void)rotateBtnArrow:(UIButton *)btn;

+ (void)rotateImgViewArrow:(UIImageView *)imgView isSelected:(BOOL)isSelected;

/**
 显示回弹动画，比如从下划到屏幕内再回弹一点
 */
+ (void)showSpring:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;




+ (CGSize )getStringSize:(NSString *)string font:(CGFloat )font width:(CGFloat)width;

/**
 获取缓存大小
 */
+( float )filePath;


/**
 清楚缓存
 */
+ (void)clearFileBlock:(void (^)(void))success;


/**
 调整lable行间距
 */
//
+ (NSAttributedString *)setLineSpacing:(CGFloat)spacing string:(NSString *)text;


//获取自定义行间距文字lable高度
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(CGFloat)fontSize  lineSpacing:(CGFloat )lineSpace withWidth:(CGFloat)width;

//二维码的生成
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;
/**
 输出任意颜色大小的图片
 */
+ (UIImage *)buttonImageFromColor:(UIColor *)color WithSize:(CGSize)size;

/**
 *  获取上个月月份
 */
+ (NSString *)getLastMonthDateStr;


/**
 *  计算富文本高度
 *  @params aAttributedString 富文本
 */
+ (CGFloat )getAttributedStringHeight:(NSMutableAttributedString *)aAttributedString;
    /**
     *  生成图片
     *
     *  @param color  图片颜色
     *  @param height 图片高度
     *
     *  @return 生成的图片
     */
+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
@end
