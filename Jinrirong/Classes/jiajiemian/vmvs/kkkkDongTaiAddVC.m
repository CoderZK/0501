//
//  kkkkDongTaiAddVC.m
//  Jinrirong
//
//  Created by zk on 2019/5/9.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import "kkkkDongTaiAddVC.h"
#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"
@interface kkkkDongTaiAddVC ()
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UITextView *TV;

@end

@implementation kkkkDongTaiAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TV.layer.borderColor = RGB(200, 200, 200).CGColor;
    self.TV.layer.borderWidth = 1;
    self.navigationItem.title = @"添加动态";
}
- (IBAction)add:(id)sender {
    if (self.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }
    if (self.TV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    NSString *token = [UDefault getObject:TOKEN];
    if (token == nil || [token isEqualToString:@""]) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    BOOL isOpen = [db open];
//    NSString * sql = [[NSString stringWithFormat:@"insert into kkkk_mineDongTai (title,content,scan,like,userId) values ('%@','%@','%d','%d','%@')",self.TF.text,self.TV.text,0,0,@"1111"]];
    
    NSString * sql = [NSString stringWithFormat:@"insert into kkkk_mineDongTai (title,content,scan,like,userId) values ('%@','%@','%d','%d','%@')",self.TF.text,self.TV.text,0,0,[UDefault getObject:@"phone"]];
    
    if (isOpen) {
        BOOL insert = [db executeUpdate:sql];
        if (insert) {
            [SVProgressHUD showSuccessWithStatus:@"动态添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            [db close];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
