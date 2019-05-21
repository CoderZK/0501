//
//  XBJinRRcreditcarddetaileViewController.m
//  Jinrirong
//
//  Created by 刘飞 on 2018/6/4.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRcreditcarddetaileViewController.h"
#import "XBJinRR_NormalHeaderView.h"
#import "XBJinRRCreditCradDetailProtocolCell.h"
#import "XBJinRRCreditCardDetailFkzzCell.h"
#import "UIImage+XBJinRRImgSize.h"

#import "XBJinRRLoginViewController.h"
#import "XBJinRRBaseNavigationViewController.h"

@interface XBJinRRcreditcarddetaileViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  数据源字典
 */
@property(nonatomic, copy)NSDictionary *infoDic;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *posterImageView;
@end

@implementation XBJinRRcreditcarddetaileViewController

-(UIImageView *)posterImageView{
    if (!_posterImageView) {
        _posterImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
//        _posterImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _posterImageView;
}

-(NSDictionary *)infoDic{
    if (!_infoDic) {
        _infoDic = [NSDictionary new];
    }
    return _infoDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"信用卡中心"];
    [self setNavWithTitle:@"信用卡中心" isShowBack:YES];
    [self initTableView];
    [self addRefresh];
}

//刷新控件
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself requestData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)requestData
{
    WS(bself);
    [XBJinRRNetworkApiManager getcreditCardDetailWithID:self.ID Block:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        if (rusultIsCorrect) {
            bself.infoDic = data[@"data"];
            
            [bself.tableView reloadData];
        }
    } fail:^(NSError *errorString) {
        [bself.tableView.mj_header endRefreshing];
    }];
}


#pragma mark -- 表格
- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRCreditCradDetailProtocolCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRCreditCradDetailProtocolCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XBJinRRCreditCardDetailFkzzCell" bundle:nil] forCellReuseIdentifier:@"XBJinRRCreditCardDetailFkzzCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.infoDic.allValues.count>0) {
        return 3;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    else if (section==1) {
        NSArray *arr = self.infoDic[@"Quanyconts"];
        return arr.count;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 0;
    }
    else if (indexPath.section == 1) {
        return 30;
    }else{
        if (indexPath.row==0) {
           return SIZE(120);
        }else{
            return SIZE(60);
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [UITableViewCell new];
    }
    else if (indexPath.section==1) {
        NSArray *arr = self.infoDic[@"Quanyconts"];
        XBJinRRCreditCradDetailProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCreditCradDetailProtocolCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailLabel.text = [NSString stringWithFormat:@"%@",arr[indexPath.row]];
        return cell;
    }
    else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.numberOfLines = 0;
            
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 10;
            NSMutableAttributedString *attri0 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"年 费：%@",self.infoDic[@"yarfeename"]] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(66, 66, 66),NSParagraphStyleAttributeName:paragraphStyle}];
            NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle1.lineSpacing = 10;
            NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@)\n",self.infoDic[@"Yeardesc"]] attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle1}];
            [attri0 appendAttributedString:attri1];
            
            NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle2.lineSpacing = 10;
            NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"积 分：%@",self.infoDic[@"Jifen1"]] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(66, 66, 66),NSParagraphStyleAttributeName:paragraphStyle2}];
            NSMutableParagraphStyle *paragraphStyle3 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle3.lineSpacing = 10;
            NSMutableAttributedString *attri3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@)\n",self.infoDic[@"Jifen2"]] attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle3}];
            [attri2 appendAttributedString:attri3];
            
            NSMutableParagraphStyle *paragraphStyle4 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle4.lineSpacing = 10;
            NSMutableAttributedString *attri4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"免息期：%@",self.infoDic[@"Freetime"]] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(66, 66, 66),NSParagraphStyleAttributeName:paragraphStyle4}];
            NSMutableParagraphStyle *paragraphStyle5 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle5.lineSpacing = 10;
            NSMutableAttributedString *attri5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@)\n",self.infoDic[@"Freedesc"]] attributes:@{NSFontAttributeName:FONT(15),NSForegroundColorAttributeName:RGB(120, 120, 120),NSParagraphStyleAttributeName:paragraphStyle5}];
            [attri4 appendAttributedString:attri5];
            
            
            NSMutableParagraphStyle *paragraphStyle6 = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle6.lineSpacing = 10;
            NSMutableAttributedString *attri6 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"等 级：%@",isEmptyStr(self.infoDic[@"Levelname"])?@"":self.infoDic[@"Levelname"]] attributes:@{NSFontAttributeName:FONT(17),NSForegroundColorAttributeName:RGB(66, 66, 66),NSParagraphStyleAttributeName:paragraphStyle6}];
            
            [attri0 appendAttributedString:attri2];
            [attri0 appendAttributedString:attri4];
            [attri0 appendAttributedString:attri6];
            
            cell.textLabel.attributedText = attri0;
            
            return cell;
        }else{
            XBJinRRCreditCardDetailFkzzCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJinRRCreditCardDetailFkzzCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:self.infoDic[@"Fakaurl"]]];
            return cell;
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -- sectionHeaderView|sectionFooterView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        NSString *url = self.infoDic[@"MainPic"];
        //获取图片尺寸时先检查是否有缓存(有就不用再获取了)
        CGFloat imgH = 0;
//        if (![[NSUserDefaults standardUserDefaults] objectForKey:url]) {
            //这里拿到每个图片的尺寸，然后计算出每个cell的高度
            CGSize imageSize = [UIImage getImageSizeWithURL:url];
            
            if (imageSize.height > 0) {
                //这里就把图片根据 固定的需求宽度  计算 出图片的自适应高度
                imgH = imageSize.height * (SCREEN_WIDTH) / imageSize.width;
            }
            //将最终的自适应的高度 本地化处理
            [[NSUserDefaults standardUserDefaults] setObject:@(imgH) forKey:url];
//        }else{
//            imgH = [UIImage getImageSizeWithURL:url].height;
//        }
        return imgH;//>400?400:180;
    }
    return SIZE(50);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        NSString *url = self.infoDic[@"MainPic"];
        //获取图片尺寸时先检查是否有缓存(有就不用再获取了)
        CGFloat imgH = 0;
//        if (![[NSUserDefaults standardUserDefaults] objectForKey:url]) {
            //这里拿到每个图片的尺寸，然后计算出每个cell的高度
            CGSize imageSize = [UIImage getImageSizeWithURL:url];
            
            if (imageSize.height > 0) {
                //这里就把图片根据 固定的需求宽度  计算 出图片的自适应高度
                imgH = imageSize.height * (SCREEN_WIDTH) / imageSize.width;
            }
            //将最终的自适应的高度 本地化处理
            [[NSUserDefaults standardUserDefaults] setObject:@(imgH) forKey:url];
//        }else{
//            imgH = [UIImage getImageSizeWithURL:url].height;
//        }
        [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        self.posterImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imgH);//>400?400:180);
        return self.posterImageView;
    }
    
    
    XBJinRR_NormalHeaderView *headerView = [[XBJinRR_NormalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(50))];
    headerView.titleStr  = [NSString stringWithFormat:@"%@",section==0?@"权益":@"基本信息"];
    headerView.isHiddenLine = YES;
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return SIZE(100);
    }
    else if(section==0){
        return 0.001;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(100)) backgroundColor:ClearColor];
        UIButton *makeSureBtn = [ViewCreate createButtonFrame:CGRectMake(SIZE(30),SIZE(30), SCREEN_WIDTH-SIZE(60),SIZE(50)) title:@"身份验证" titleColor:WhiteColor font:FONT(17) backgroundColor:MainColor touchUpInsideEvent:nil];
        [makeSureBtn addTarget:self action:@selector(makeSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:makeSureBtn];
        makeSureBtn.layer.masksToBounds = YES;
        makeSureBtn.layer.cornerRadius = SIZE(25);
        return bgView;
    }
    return [UIView new];
}
//身份分享按钮被点击
- (void )makeSureBtnClick:(UIButton *)sender{
    

    NSString *token = [UDefault getObject:TOKEN];
    if (token == nil || [token isEqualToString:@""]) {
        XBJinRRLoginViewController *vc = [[XBJinRRLoginViewController alloc] init];
        XBJinRRBaseNavigationViewController *nav = [[XBJinRRBaseNavigationViewController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    [XBJinRRNetworkApiManager productStatisticsWithID:self.ID Block:^(id data) {
        
    } fail:^(NSError *errorString) {
        
    }];
    
    XBJinRRWebViewController *vc = [XBJinRRWebViewController new];
    [vc setUrl:[NSString stringWithFormat:@"%@",self.infoDic[@"Openurl"]] webType:WebTypeOther];
    vc.titleString = @"身份验证";
    [self.navigationController pushViewController:vc animated:YES];
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
