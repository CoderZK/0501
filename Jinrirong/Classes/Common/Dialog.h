

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"

@interface Dialog : NSObject<MBProgressHUDDelegate> {
	MBProgressHUD *HUD;
    
	long long expectedLength;
	long long currentLength;
}

+ (Dialog *)Instance;



/**
 *  传递一个右侧弹框的值 -- 针对于此项目，其他项目删除此属性
 */
@property(nonatomic, strong)NSDictionary *YouTanDic;



//提示对话框
+ (void)alert:(NSString *)message;
+ (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message;

//类似于Android一个显示框效果
+ (void)toast:(UIViewController *)controller withMessage:(NSString *) message;
+ (void)toast:(NSString *)message;
+ (void)toastCenter:(NSString *)message;
+ (void)hidetoastCenter;
//显示在屏幕中间
+ (void)toastCenter:(NSString *)message;
//带进度条
+ (void)progressToast:(NSString *)message;

//带遮罩效果的进度条
- (void)gradient:(UIViewController *)controller seletor:(SEL)method;

//显示遮罩
- (void)showProgress:(UIViewController *)controller;

//关闭遮罩
- (void)hideProgress;

//带说明的进度条
- (void)progressWithLabel:(UIViewController *)controller seletor:(SEL)method;

//显示带说明的进度条
- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText;
- (void)showCenterProgressWithLabel:(NSString *)labelText;


- (void)dismissHUD;



@end
