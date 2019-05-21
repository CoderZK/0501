//
//  XBProductController.m
//  Jinrirong
//
//  Created by 少少 on 2019/1/24.
//  Copyright © 2019年 ahxb. All rights reserved.
//

#import "XBProductController.h"
#import "XBProduceModel.h"
#import "XBProductCell.h"
#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface XBProductController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *twoNameLab;
@property (nonatomic, strong) UILabel *oneNameLab;
@property (nonatomic, strong) UILabel *threeNameLab;
@property (nonatomic, strong) UILabel *threemoneyLab;
@property (nonatomic, strong) UILabel *onemoneyLab;
@property (nonatomic, strong) UILabel *twomoneyLab;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *detailList;
@end

@implementation XBProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"产品排行榜";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    
    
    _detailList = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self ;
    _tableView.delegate = self ;
    _tableView.frame = CGRectMake(0, ScreenHeight - 300, ScreenWidth, 300);
    
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];;
    
    [XBJinRRNetworkApiManager productBlock:^(id data) {
        
        NSLog(@"product == %@",data);
        NSArray *dataArray = data[@"data"];
        
        for (NSDictionary *dic in dataArray) {
            
            XBProduceModel *detailModel = [[XBProduceModel alloc] initWithDictionary:dic];
            [self.detailList addObject:detailModel];
        }
        
        if (self.detailList.count > 3) {
            
//            NSLog(@"detailList === %@",bself.detailList);
            
            [self.tableView reloadData];
        }

        if (dataArray.count > 2) {

            NSDictionary *threeDic = dataArray[2];
            self.threeNameLab.text = threeDic[@"Name"];
            self.threemoneyLab.text = threeDic[@"total"];
        }

        if (dataArray.count > 1) {
            NSDictionary *twoDic = dataArray[1];
            self.twoNameLab.text = twoDic[@"Name"];

            self.twomoneyLab.text = twoDic[@"total"];
        }

        if (dataArray.count > 0) {
            NSDictionary *oneDic = dataArray[0];
            self.oneNameLab.text = oneDic[@"Name"];
            self.onemoneyLab.text = oneDic[@"total"];

        }
//
//        NSDictionary *me_money = data[@"me_money"];
//        NSString *totalAmount = me_money[@"totalAmount"];
//
//        if (!(totalAmount.length) || [totalAmount isEqual:[NSNull null]] || [totalAmount isEqualToString:@"<null>"]) {
//
//        } else {
//
//            self.commissionLab.text = [NSString stringWithFormat:@"本月佣金：%@元（20名以外）",totalAmount];
//        }
        
    } fail:^(NSError *errorString) {
        
    }];
    
    [self creatView];
}

- (void)creatView{
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"bgicon"];
    imageV.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 300 - 64);
    [self.view addSubview:imageV];
    
    UIImageView *imageRanking = [[UIImageView alloc] init];
    imageRanking.image = [UIImage imageNamed:@"rankingImage"];
    imageRanking.frame = CGRectMake((ScreenWidth - 180) / 2, 40, 180 , 47);
    [imageV addSubview:imageRanking];
    
    UIImageView *leftImage = [[UIImageView alloc] init];
    leftImage.image = [UIImage imageNamed:@"linkicon"];
    leftImage.frame = CGRectMake((3 * ScreenWidth + 50) / 4  , 20, 65, 65);
    [imageV addSubview:leftImage];
    
    UIImageView *twoImage = [[UIImageView alloc] init];
    twoImage.frame = CGRectMake(20, ScreenHeight - 300 - 64 - 140, 202 * ((ScreenWidth - 40)/693), 140);//202 267
    twoImage.image = [UIImage imageNamed:@"twoimage"];
    [imageV addSubview:twoImage];
    
    
    UIImageView *twoNOicon = [[UIImageView alloc] init];
    twoNOicon.image = [UIImage imageNamed:@"ljt-icon-1"];
    twoNOicon.frame = CGRectMake(0, 0, 64, 77);
    twoNOicon.center = CGPointMake(twoImage.frame.size.width/2, -20);
    [twoImage addSubview:twoNOicon];
    
    UILabel *twoNameLab = [[UILabel alloc] init];
    twoNameLab.text = @"暂无";
    twoNameLab.textColor = [UIColor whiteColor];
    twoNameLab.frame = CGRectMake(0, 0, 100, 20);
    twoNameLab.center = CGPointMake(twoImage.frame.size.width/2, (twoImage.frame.size.height/2) - 20);
    twoNameLab.font = [UIFont boldSystemFontOfSize:18];
    twoNameLab.textAlignment = NSTextAlignmentCenter;
    [twoImage addSubview:twoNameLab];
    self.twoNameLab = twoNameLab;
    
    UILabel *twomoneyLab = [[UILabel alloc] init];
    twomoneyLab.text = @"";
    twomoneyLab.textColor = [UIColor whiteColor];
    twomoneyLab.frame = CGRectMake(0, 0, 100, 30);
    twomoneyLab.font = [UIFont boldSystemFontOfSize:20];
    twomoneyLab.textAlignment = NSTextAlignmentCenter;
    twomoneyLab.center = CGPointMake(twoImage.frame.size.width/2,(twoImage.frame.size.height/2) + 10);
    [twoImage addSubview:twomoneyLab];
    self.twomoneyLab = twomoneyLab;
    
    CGFloat oneimageX = CGRectGetMaxX(twoImage.frame);
    UIImageView *oneImage = [[UIImageView alloc] init];
    oneImage.image = [UIImage imageNamed:@"oneimage"];//289 332
    oneImage.frame = CGRectMake(oneimageX, ScreenHeight - 300 - 64 - 192, 289 * ((ScreenWidth - 40)/693), 192);
    [imageV addSubview:oneImage];
    
    UIImageView *oneNOicon = [[UIImageView alloc] init];
    oneNOicon.image = [UIImage imageNamed:@"ljt-icon-2"];
    oneNOicon.frame = CGRectMake(0, 0, 72, 89);
    oneNOicon.center = CGPointMake(oneImage.frame.size.width/2, -20);
    [oneImage addSubview:oneNOicon];
    
    UILabel *oneNameLab = [[UILabel alloc] init];
    oneNameLab.text = @"暂无";
    oneNameLab.textColor = [UIColor whiteColor];
    oneNameLab.frame = CGRectMake(0, 0, 100, 20);
    oneNameLab.center = CGPointMake(oneImage.frame.size.width/2, (twoImage.frame.size.height/2) - 20);
    oneNameLab.font = [UIFont boldSystemFontOfSize:18];
    oneNameLab.textAlignment = NSTextAlignmentCenter;
    [oneImage addSubview:oneNameLab];
    self.oneNameLab = oneNameLab;
    
    UILabel *onemoneyLab = [[UILabel alloc] init];
    onemoneyLab.text = @"";
    onemoneyLab.textColor = [UIColor whiteColor];
    onemoneyLab.frame = CGRectMake(0, 0, 100, 30);
    onemoneyLab.font = [UIFont boldSystemFontOfSize:20];
    onemoneyLab.textAlignment = NSTextAlignmentCenter;
    onemoneyLab.center = CGPointMake(oneImage.frame.size.width/2, (twoImage.frame.size.height/2) + 10);
    [oneImage addSubview:onemoneyLab];
    self.onemoneyLab = onemoneyLab;
    
    CGFloat threeimageX = CGRectGetMaxX(oneImage.frame);
    UIImageView *threeImage = [[UIImageView alloc] init];
    threeImage.frame = CGRectMake(threeimageX, ScreenHeight - 300 - 64 - 125, 202 * ((ScreenWidth - 40)/693), 125);//202 267
    threeImage.image = [UIImage imageNamed:@"threeimage"];
    [imageV addSubview:threeImage];
    
    UIImageView *othreeNOicon = [[UIImageView alloc] init];
    othreeNOicon.image = [UIImage imageNamed:@"ljt-icon-3"];
    othreeNOicon.frame = CGRectMake(0, 0, 61, 73);
    othreeNOicon.center = CGPointMake(threeImage.frame.size.width/2, -20);
    [threeImage addSubview:othreeNOicon];
    
    UILabel *threeNameLab = [[UILabel alloc] init];
    threeNameLab.text = @"暂无";
    threeNameLab.textColor = [UIColor whiteColor];
    threeNameLab.frame = CGRectMake(0, 0, 100, 20);
    threeNameLab.center = CGPointMake(threeImage.frame.size.width/2, (twoImage.frame.size.height/2) - 20);
    threeNameLab.font = [UIFont boldSystemFontOfSize:18];
    threeNameLab.textAlignment = NSTextAlignmentCenter;
    [threeImage addSubview:threeNameLab];
    self.threeNameLab = threeNameLab;
    
    UILabel *threemoneyLab = [[UILabel alloc] init];
    threemoneyLab.text = @"";
    threemoneyLab.textColor = [UIColor whiteColor];
    threemoneyLab.frame = CGRectMake(0, 0, 100, 30);
    threemoneyLab.font = [UIFont boldSystemFontOfSize:20];
    threemoneyLab.textAlignment = NSTextAlignmentCenter;
    threemoneyLab.center = CGPointMake(threeImage.frame.size.width/2, (twoImage.frame.size.height/2) + 10);
    [threeImage addSubview:threemoneyLab];
    self.threemoneyLab = threemoneyLab;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XBProductCell *detailCell = [XBProductCell cellWithTableView:tableView];
    
    detailCell.productModel = [_detailList objectAtIndex:indexPath.row + 3];
    detailCell.commisIndex = (indexPath.row + 4);
    return detailCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    //    HistoryPlayDetailViewController *histpryPalyDetai = [[HistoryPlayDetailViewController alloc] initWithNibName:NSStringFromClass([HistoryPlayDetailViewController class]) bundle:nil];
    //    histpryPalyDetai.historyDetailModel = [_detailList objectAtIndex:indexPath.row];
    //    histpryPalyDetai.dataSource = _detailList;
    //    histpryPalyDetai.currentIndex = indexPath.row;
    //    histpryPalyDetai.isPlay = YES;
    //    [self.navigationController pushViewController:histpryPalyDetai animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (_detailList.count - 3);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

@end