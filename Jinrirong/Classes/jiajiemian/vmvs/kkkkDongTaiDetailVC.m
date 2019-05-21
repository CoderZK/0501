//
//  kkkkDongTaiDetailVC.m
//  Jinrirong
//
//  Created by zk on 2019/5/9.
//  Copyright © 2019 ahxb. All rights reserved.
//

#import "kkkkDongTaiDetailVC.h"

@interface kkkkDongTaiDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UITextView *textV;

@end

@implementation kkkkDongTaiDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textV.layer.borderColor = RGB(200, 200, 200).CGColor;
    self.textV.layer.borderWidth = 1;
    
    self.titleLB.text = self.model.title;
    self.textV.text = self.model.content;
    
    NSString * sql =  [NSString stringWithFormat:@"update kkkk_mineDongTai set scan = %ld where ID = %@",self.model.scan + 1 ,self.model.ID];
    
    FMDatabase * db =[FMDBSingle shareFMDB].fd;
    if ([db open]) {
        BOOL delete = [db executeUpdate:sql ];
        if (delete) {
            
        };
    }else {
        
    }
    
    [db close];
    
    
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
