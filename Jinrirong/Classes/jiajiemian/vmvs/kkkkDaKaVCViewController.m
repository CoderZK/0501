//
//  kkkkDaKaVCViewController.m
//  Jinrirong
//
//  Created by zk on 2019/5/10.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import "kkkkDaKaVCViewController.h"
#import "kkkkDaKaListVC.h"
@interface kkkkDaKaVCViewController ()
@property (weak, nonatomic) IBOutlet UIButton *BT;
@property (weak, nonatomic) IBOutlet UITextField *TF;

@end

@implementation kkkkDaKaVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"签到";
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    
    [button setTitle:@"签到记录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.BT.layer.cornerRadius = 60;
    self.BT.clipsToBounds = YES;
    
    
    
}

- (void)add {
    
    kkkkDaKaListVC * vc =[[kkkkDaKaListVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)qianDaoAction:(id)sender {
   
    if (self.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入签到说明"];
        return;
    }
    
    NSDate *currentDate = [NSDate date]; // GMT
    NSLog(@"currentDate :%@",currentDate);
    //timeIntervalSince1970 到1970-1-1的秒数，也叫时间戳（NSTimeInterval）
    NSTimeInterval interval1970 = [currentDate timeIntervalSince1970];
    NSString * timeStr = [NSString stringWithDateStrwithyymmdd:@(interval1970)];
    NSString * timeTwoStr = [timeStr substringToIndex:10];
    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    BOOL isOpen = [db open];
    NSString * sql = [NSString stringWithFormat:@"insert into kkkk_daKa (des,time,timeTwo,userId) values ('%@','%@','%@','%@')",self.TF.text,timeStr,timeTwoStr,[UDefault getObject:@"phone"]];
    NSString * sql2 = [NSString stringWithFormat:@"select *from kkkk_daKa where timeTwo='%@' and userId='%@'",timeTwoStr,[UDefault getObject:@"phone"]];
    NSString * sql3 = [NSString stringWithFormat:@"update kkkk_daKa set time='%@',des='%@' where timeTwo=%@",timeStr,self.TF.text,timeTwoStr];
    if (isOpen) {
        
        FMResultSet * result = [db executeQuery:sql2];
        if ([result next]) {
            BOOL isOK = [db executeUpdate:sql3];
            if (isOK) {
                [SVProgressHUD showSuccessWithStatus:@"更新签到成功"];
            }else {
                [SVProgressHUD showErrorWithStatus:@"更新签到失败"];
            }
        }else {
         BOOL isOK = [db executeUpdate:sql];
            if (isOK) {
                [SVProgressHUD showSuccessWithStatus:@"签到成功"];
            }else {
                [SVProgressHUD showErrorWithStatus:@"签到失败"];
            }
            
        }
        
        
    }
    
    [db close];
    
    
    
}


@end
