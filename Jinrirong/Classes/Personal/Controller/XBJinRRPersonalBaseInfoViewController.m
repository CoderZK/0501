//
//  XBJinRRPersonalBaseInfoViewController.m
//  Jinrirong
//
//  Created by ahxb on 2018/5/15.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBJinRRPersonalBaseInfoViewController.h"
#import "XBJinRRPersonalBaseInfoCell.h"
#import "XBJinRRPersonInfoModel.h"
#import "UIImage+Common.h"

@interface XBJinRRPersonalBaseInfoViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) XBJinRRPersonInfoModel *personInfoModel;
/**
 *  需要上传的头像链接
 */
@property(nonatomic, strong)NSString *headerImagePath;
@end

@implementation XBJinRRPersonalBaseInfoViewController

static NSString *XBJinRRPersonalBaseInfoIconCellID = @"XBJinRRPersonalBaseInfoIconCellID";
static NSString *XBJinRRPersonalBaseInfoTrueNameCellID = @"XBJinRRPersonalBaseInfoTrueNameCellID";
static NSString *XBJinRRPersonalBaseInfoCardNoCellID = @"XBJinRRPersonalBaseInfoCardNoCellID";
static NSString *XBJinRRPersonalBaseInfoPhoneCellID = @"XBJinRRPersonalBaseInfoPhoneCellID";
static NSString *XBJinRRPersonalBaseInfoTuijianmaCellID = @"XBJinRRPersonalBaseInfoTuijianmaCellID";
static NSString *XBJinRRPersonalBaseInfoTuijianrenCellID = @"XBJinRRPersonalBaseInfoTuijianrenCellID";
static NSString *XBJinRRPersonalBaseInfoShenfenCellID = @"XBJinRRPersonalBaseInfoShenfenCellID";
static NSString *XBJinRRPersonalBaseInfoIsCreditCellID = @"XBJinRRPersonalBaseInfoIsCreditCellID";
static NSString *XBJinRRPersonalBaseInfoUseTimeCellID = @"XBJinRRPersonalBaseInfoUseTimeCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitleStr:@"基本信息"];
    [self setNavWithTitle:@"基本信息" isShowBack:YES];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self createUI];
    [self addRefresh];
}
//刷新控件
-(void)addRefresh{
    WS(bself);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)loadData
{
    WS(bself);
    [XBJinRRNetworkApiManager getPersonInfoBlock:^(id data) {
        [bself.tableView.mj_header endRefreshing];
        XBJinRRPersonInfoModel *personInfoModel = [XBJinRRPersonInfoModel mj_objectWithKeyValues:data];
        bself.personInfoModel = personInfoModel;
        [bself.tableView reloadData];
    } fail:^(NSError *errorString) {
        [bself.tableView.mj_header endRefreshing];
    }];
}
- (void)createUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
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
    
    UIView *saveView = [[UIView alloc] init];
    saveView.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, 50);
    
    
    UIButton *saveBtn = [[UIButton alloc] init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:MainColor];
    saveBtn.layer.cornerRadius = 25;
    saveBtn.layer.masksToBounds = YES;
    saveBtn.frame = CGRectMake(20, 10, SCREEN_WIDTH-40, 50);
    [saveView addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(saveUserInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    tableView.tableFooterView = saveView;
    
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoIconCellID];
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoTrueNameCellID];
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoCardNoCellID];
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoPhoneCellID];
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoTuijianmaCellID];
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoTuijianrenCellID];
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoShenfenCellID];
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoIsCreditCellID];
    [tableView registerClass:[XBJinRRPersonalBaseInfoCell class] forCellReuseIdentifier:XBJinRRPersonalBaseInfoUseTimeCellID];
}
#pragma mark - UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SIZE(55);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.row == 0) {
        XBJinRRPersonalBaseInfoCell *iconCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoIconCellID];
        iconCell.nameLabel.text = @"头像";
        [iconCell.detailTF setHidden:YES];
        [iconCell.icon setHidden:NO];
        NSString *url = [self.personInfoModel.HeadImgVal stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [iconCell.icon sd_setImageWithURL:[NSURL URLWithString:url]];
        cell = iconCell;
    } else if (indexPath.row == 1) {
        XBJinRRPersonalBaseInfoCell *trueNameCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoTrueNameCellID];
        trueNameCell.nameLabel.text = @"真实姓名";
        [trueNameCell.detailTF setHidden:NO];
        [trueNameCell.icon setHidden:YES];
        trueNameCell.detailTF.text = self.personInfoModel.TrueName;
        cell = trueNameCell;
    } else if (indexPath.row == 2) {
        XBJinRRPersonalBaseInfoCell *cardNoCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoCardNoCellID];
        cardNoCell.nameLabel.text = @"身份证号";
        [cardNoCell.detailTF setHidden:NO];
        [cardNoCell.icon setHidden:YES];
        cardNoCell.detailTF.keyboardType = UIKeyboardTypeNumberPad;
        if (isEmptyStr(self.personInfoModel.CardNo)) {
            cardNoCell.detailTF.placeholder = @"请输入身份证号";
        }else{
            cardNoCell.detailTF.text = self.personInfoModel.CardNo;
        }
        
        cell = cardNoCell;
    } else if (indexPath.row == 3) {
        XBJinRRPersonalBaseInfoCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoPhoneCellID];
        phoneCell.nameLabel.text = @"手机号";
        [phoneCell.detailTF setHidden:NO];
        [phoneCell.icon setHidden:YES];
        phoneCell.detailTF.userInteractionEnabled = NO;
        phoneCell.detailTF.text = self.personInfoModel.Mobile;
        cell = phoneCell;
    } else if (indexPath.row == 4) {
        XBJinRRPersonalBaseInfoCell *tuijianmaCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoTuijianmaCellID];
        tuijianmaCell.nameLabel.text = @"推荐码";
        [tuijianmaCell.detailTF setHidden:NO];
        tuijianmaCell.detailTF.userInteractionEnabled = NO;
        [tuijianmaCell.icon setHidden:YES];
        tuijianmaCell.detailTF.text = self.personInfoModel.Tjcode;
        cell = tuijianmaCell;
    } else if (indexPath.row == 5) {
        XBJinRRPersonalBaseInfoCell *tuijianrenCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoTuijianrenCellID];
        tuijianrenCell.nameLabel.text = @"推荐人";
        if (isEmptyStr(self.personInfoModel.Referee)) {
            tuijianrenCell.detailTF.text = @"无";
        }else{
            tuijianrenCell.detailTF.text = self.personInfoModel.Referee;
        }
        tuijianrenCell.detailTF.userInteractionEnabled = NO;
        [tuijianrenCell.detailTF setHidden:NO];
        [tuijianrenCell.icon setHidden:YES];
        
        cell = tuijianrenCell;
    } else if (indexPath.row == 6) {
        XBJinRRPersonalBaseInfoCell *shenfenCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoShenfenCellID];
        shenfenCell.nameLabel.text = @"身份";
        shenfenCell.detailTF.userInteractionEnabled = NO;
        [shenfenCell.detailTF setHidden:NO];
        [shenfenCell.icon setHidden:YES];
        shenfenCell.detailTF.text = self.personInfoModel.Position;
        cell = shenfenCell;
    } else if (indexPath.row == 7) {
        XBJinRRPersonalBaseInfoCell *isCreditCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoIsCreditCellID];
        isCreditCell.nameLabel.text = @"有无信用卡";
        isCreditCell.detailTF.userInteractionEnabled = NO;
        [isCreditCell.detailTF setHidden:NO];
        [isCreditCell.icon setHidden:YES];
        isCreditCell.detailTF.text = self.personInfoModel.IsCredit;
        cell = isCreditCell;
    } else if (indexPath.row == 8) {
        XBJinRRPersonalBaseInfoCell *useTimeCell = [tableView dequeueReusableCellWithIdentifier:XBJinRRPersonalBaseInfoUseTimeCellID];
        useTimeCell.nameLabel.text = @"手机使用时长";
        useTimeCell.detailTF.userInteractionEnabled = NO;
        [useTimeCell.detailTF setHidden:NO];
        [useTimeCell.icon setHidden:YES];
        
        
        useTimeCell.detailTF.text = self.personInfoModel.UseTime;
        cell = useTimeCell;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(bself);
    if (indexPath.row==0) {
        LFActionSheet *sheet = [LFActionSheet lf_actionSheetViewWithTitle:@"更换头像" cancelTitle:@"取消" destructiveTitle:nil otherTitles:@[@"相机",@"相册"] otherImages:nil selectSheetBlock:^(LFActionSheet *actionSheet, NSInteger index) {
            switch (index) {
                case -1:
                    //取消
                    break;
                case 0:
                {
                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.delegate = self;
                    imagePicker.allowsEditing = YES;
                    //照相机
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    if([[[UIDevice
                          currentDevice] systemVersion] floatValue]>=8.0) {
                        
                        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
                    }
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
                    break;
                case 1:
                {
                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.delegate = self;
                    imagePicker.allowsEditing = YES;
                    //图库
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
                    break;
                    
                default:
                    break;
            }
            
        }];
        [sheet show];
    }
    
    
    if (indexPath.row == 6) {
        LFActionSheet *sheet = [LFActionSheet lf_actionSheetViewWithTitle:@"更换身份" cancelTitle:@"取消" destructiveTitle:nil otherTitles:@[@"学生族",@"上班族",@"自主创业",@"无业"] otherImages:nil selectSheetBlock:^(LFActionSheet *actionSheet, NSInteger index) {
            switch (index) {
                case -1:
                    //取消
                    break;
                case 0:
                    self.personInfoModel.Position = @"学生族";
                    break;
                case 1:
                    self.personInfoModel.Position = @"上班族";
                    break;
                case 2:
                    self.personInfoModel.Position = @"自主创业";
                    break;
                case 3:
                    self.personInfoModel.Position = @"无业";
                    break;
                    
                default:
                    break;
            }
            [bself.tableView reloadData];
        }];
        [sheet show];
    }
    if (indexPath.row == 7) {
        LFActionSheet *sheet = [LFActionSheet lf_actionSheetViewWithTitle:@"是否有信用卡" cancelTitle:@"取消" destructiveTitle:nil otherTitles:@[@"有",@"无"] otherImages:nil selectSheetBlock:^(LFActionSheet *actionSheet, NSInteger index) {
            switch (index) {
                case -1:
                    //取消
                    break;
                case 0:
                    self.personInfoModel.IsCredit = @"有";
                    break;
                case 1:
                    self.personInfoModel.IsCredit = @"无";
                    break;
                    
                default:
                    break;
            }
            [bself.tableView reloadData];
        }];
        [sheet show];
    }
    if (indexPath.row == 8) {
        LFActionSheet *sheet = [LFActionSheet lf_actionSheetViewWithTitle:@"手机使用时长" cancelTitle:@"取消" destructiveTitle:nil otherTitles:@[@"一年以下",@"一年以上",@"两年以上",@"三年以上"] otherImages:nil selectSheetBlock:^(LFActionSheet *actionSheet, NSInteger index) {
            switch (index) {
                case -1:
                    //取消
                    break;
                case 0:
                    //一年以下
                    self.personInfoModel.UseTime = @"一年以下";
                    break;
                case 1:
                    //一年以上
                    self.personInfoModel.UseTime = @"一年以上";
                    break;
                case 2:
                    //两年以上
                    self.personInfoModel.UseTime = @"两年以上";
                    break;
                case 3:
                    //三年以上
                    self.personInfoModel.UseTime = @"三年以上";
                    break;
                    
                default:
                    break;
            }
            [bself.tableView reloadData];
        }];
        [sheet show];
    }
    
    
    
}

#pragma mark - UIImagePickerViewController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    //防止头像旋转
    image = [image fixOrientation:image];
    //压缩图片-- 图片小于1000kb才能够上传
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > 1024 && maxQuality > 0.01f) {
        //将图片压缩成1M
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    
    [self changeHeaderImageViewWithImageData:data];
    image = [UIImage imageWithData:data];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 上传头像
- (void )changeHeaderImageViewWithImageData:(NSData *)imageData{
    WS(bself);
    [self.view showLoadMessageAtCenter:@"头像上传中..."];
    [XBJinRRNetworkApiManager postImage:imageData Block:^(id data, NSError *error) {
        [bself.view hide];
        if (!error) {
            bself.personInfoModel.HeadImgVal = [NSString stringWithFormat:@"%@",data[@"filepath"]];
            bself.headerImagePath = [NSString stringWithFormat:@"%@",data[@"path"]];
            [bself.tableView reloadData];
        }else{
            [Dialog toastCenter:@"网络错误"];
        }
    }];
}




#pragma mark -- 保存用户信息
- (void )saveUserInfoBtnClick{
    NSString *imageUrlPath = nil;
    if (isEmptyStr(self.headerImagePath)) {
        if ([self.personInfoModel.HeadImgVal containsString:@"Public"]) {
            imageUrlPath = @"";
        }else{
            if ([self.personInfoModel.HeadImgVal containsString:@"/Upload"]) {
                NSRange range = [self.personInfoModel.HeadImgVal rangeOfString:@"/Upload"];
                imageUrlPath = [self.personInfoModel.HeadImgVal substringFromIndex:range.location];
                MyLog(@"imageUrlPath ---  %@",imageUrlPath);
            } else {
                imageUrlPath = self.personInfoModel.HeadImgVal;
            }
        }
    }else{
        imageUrlPath = self.headerImagePath;
    }
    
    XBJinRRPersonalBaseInfoCell *trueNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    XBJinRRPersonalBaseInfoCell *cardNoCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    NSString * Position = @"";
    if ([self.personInfoModel.Position isEqualToString:@"学生族"]) {
        Position = @"1";
    }
    if ([self.personInfoModel.Position isEqualToString:@"上班族"]) {
        Position = @"2";
    }
    if ([self.personInfoModel.Position isEqualToString:@"自主创业"]) {
        Position = @"3";
    }
    if ([self.personInfoModel.Position isEqualToString:@"无业"]) {
        Position = @"4";
    }
    
   NSString *IsCredit = [self.personInfoModel.IsCredit isEqualToString:@"无"]?@"0":@"1";
    
    NSString * UseTime = nil;
    if ([self.personInfoModel.UseTime isEqualToString:@"一年以下"]) {
        UseTime = @"1";
    }
    if ([self.personInfoModel.UseTime isEqualToString:@"一年以上"]) {
        UseTime = @"2";
    }
    if ([self.personInfoModel.UseTime isEqualToString:@"两年以上"]) {
        UseTime = @"3";
    }
    if ([self.personInfoModel.UseTime isEqualToString:@"三年以上"]) {
        UseTime = @"4";
    }
    
    WS(bself);
    
    NSString * TrueName = [NSString stringWithFormat:@"%@",trueNameCell.detailTF.text];
    NSDictionary *infoDic = @{@"TrueName":TrueName,
                              @"HeadImg":imageUrlPath,
                              @"CardNo":[NSString stringWithFormat:@"%@",cardNoCell.detailTF.text],
                              @"Position":Position,
                              @"IsCredit":IsCredit,
                              @"UseTime":UseTime
                              };
    [XBJinRRNetworkApiManager updateUserInfoWithParams:infoDic Block:^(id data) {
        [Dialog toastCenter:[NSString stringWithFormat:@"%@",data[@"message"]]];
        if (rusultIsCorrect) {
            if (bself.editBlock) {
                bself.editBlock();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [bself.navigationController popViewControllerAnimated:YES];
            });
        }
    } fail:^(NSError *errorString) {
        
    }];
    
    
    
}



@end
