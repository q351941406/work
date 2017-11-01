//
//  ViewController.m
//  work
//
//  Created by pc on 2017/8/10.
//  Copyright © 2017年 pc. All rights reserved.
//



#define HeaderH 240
#import "ViewController.h"
#import "ViewUtils.h"
#import "CFGradientLabel.h"
#import "DPScrollNumberLabel.h"
#import "FHTopImgBottomLabel.h"
#import "FHHomeCell.h"
#import "GameColorVC.h"
#import "HomeModel.h"
#import "YDDevice.h"
#import <HKNewsBannerView/HKNewsBannerView.h>
#import <AXWebViewController/AXWebViewController.h>
#import "NSString+Extension.h"
#import "LLWaveView.h"
#import "RedPackgeView.h"
#import "FHUser.h"
#import "LoginViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "DuiHuanViewController.h"
#import "ConfigModel.h"
#import "ZhiWuTBVC.h"
#import <AFNetworking/AFNetworking.h>
#import "GzwThemeTool.h"
#import <SAMKeychain/SAMKeychain.h>
#import "GZWTool.h"
#import <MeiQiaSDK/MeiQiaSDK.h>
#import "MQChatViewManager.h"
#import "YALContextMenuTableView.h"
#import "ContextMenuCell.h"
#import "YALNavigationBar.h"
#import "Harpy.h"
#import "AppDelegate.h"
#import "iRate.h"
#import "SVWebViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AFNetworking/AFNetworking.h>
static NSString *const menuCellIdentifier = @"rotationCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,HKNewsBannerViewDelegate,RedPackgeViewDegelate,UIAlertViewDelegate,YALContextMenuTableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) UIView *contronView;
@property (nonatomic,weak) HKNewsBannerView *newsView;
@property (nonatomic,strong) UIButton *gameBtn;
@property (nonatomic,strong) UIButton *talkBtn;
@property (nonatomic,strong) DPScrollNumberLabel *numLabel; //金额
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSMutableArray *ads;
@property (nonatomic,strong) NSMutableArray *datas;
//@property(nonatomic, strong) GADInterstitial *interstitial;
@property (assign, nonatomic) NSInteger timeCount;
@property (assign, nonatomic) BOOL isMove;
@property (assign, nonatomic) BOOL isGoAppstore;
@property(nonatomic, strong) UIActivityIndicatorView *a;

@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;
@end

@implementation ViewController




#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
//     AFHTTPSessionManager *mar=[AFHTTPSessionManager manager];
//    [mar.requestSerializer setValue:@"en-us" forHTTPHeaderField:@"Accept-Language"];
//    mar.requestSerializer = [AFJSONRequestSerializer serializer];
//    mar.responseSerializer = [AFJSONResponseSerializer serializer];
////    mar.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-javascript", nil];
//    [mar.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-javascript", nil]];
////    mar.responseSerializer.acceptableContentTypes = [mar.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    [mar POST:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"");
//    }];
    
    [self upDate];
    
    [self initUI];
//    [self.navigationController setValue:[[YALNavigationBar alloc]init] forKeyPath:@"navigationBar"];

//    if (![SAMKeychain passwordForService:@"UUID" account:@"UUID"]) {
//        RedPackgeView *redView = [[RedPackgeView alloc] initWithTitle:@"新用户送5999金币" count:5999 isGame:NO];
//        redView.degelate = self;
//        [redView show];
//    }
    
//    //询问是否通过审核了
//    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"censoringPretend"];
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        if (error){
//
//        }else{
//            BmobObject *obj = array.lastObject;
//            if ([[obj objectForKey:@"pass"] boolValue]) {// 通过审核
//                [self loadData];
//                [self.navigationController.view addSubview:self.gameBtn];
//                UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"duihuan"] style:0 target:self action:@selector(rightClick)];
//                self.navigationItem.rightBarButtonItem = right;
//                [self setupRate];
//            }else {// 在审核中
//                [self loadFalseData];
//            }
//            AppDelegate *a = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            a.pass = [[obj objectForKey:@"pass"] boolValue];
//        }
//
//    }];
    
    
    
   
    //询问是否通过审核了
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"censoringPretend"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error){
            
        }else{
            [array enumerateObjectsUsingBlock:^(BmobObject  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([[obj objectForKey:@"name"] isEqualToString:@"马甲4"]) {
                    if ([[obj objectForKey:@"pass"] boolValue]) {// 通过审核
                        if ([self isSIMInstalled]) {//有SIM卡
                            [self getIp:^(NSDictionary *dcit) {
                                if ([dcit[@"data"][@"country_id"] isEqualToString:@"CN"]) {// 在中国
                                    [self loadData];
                                    [self.navigationController.view addSubview:self.gameBtn];
                                    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"duihuan"] style:0 target:self action:@selector(rightClick)];
                                    self.navigationItem.rightBarButtonItem = right;
                                    [self setupRate];
                                }else {// 在国外
                                    [self loadFalseData];
                                }
                            }];
                        }else {// 无SIM卡
                            [self loadFalseData];
                        }
                    }else {// 在审核中
                        [self loadFalseData];
                    }
                    AppDelegate *a = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    a.pass = [[obj objectForKey:@"pass"] boolValue];
                }
            }];
        }
    }];

    
    
    [self.view addSubview:self.talkBtn];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (![FHDufulatUtil sharedInstance].config.examine) {
        self.gameBtn.hidden = YES;
    }
//    self.navigationController.navigationBar.translucent = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![FHDufulatUtil sharedInstance].config.examine) {
        self.gameBtn.hidden = NO;
    }
    [_newsView startRolling];
//    self.navigationController.navigationBarHidden = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    _numLabel.hidden = YES;
    _a.hidden = NO;
    shakerAnimation(self.talkBtn, 1, 20);
}
-(void)upDate
{
    [[Harpy sharedInstance] setPresentingViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    //    [[Harpy sharedInstance] setDelegate:self];
        [[Harpy sharedInstance] setCountryCode:@"cn"];
    [[Harpy sharedInstance] setAppName:@"赚钱钱"];
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeForce];
    [[Harpy sharedInstance] setDebugEnabled:true];
    [[Harpy sharedInstance] checkVersion];
}
-(void)loadFalseData
{
    NSArray *title = @[
                       @"火爆招募电脑手机小时工",
                       @"邯郸顺丰兼职分拣员",
                       @"兼职奥数老师招聘",
                       @"代招兼职送餐员",
                       @"大型超市招聘兼职促销员",
                       @"诚聘销售精英业务员",
                       ];
    
    NSArray *left = @[
                      @"靠谱工作",
                      @"靠谱工作",
                      @"靠谱工作",
                      @"靠谱工作",
                      @"靠谱工作",
                      @"靠谱工作",
                      ];
    
    NSArray *right = @[
                       @"240",
                       @"400",
                       @"200",
                       @"220",
                       @"20",
                       @"380",
                       ];
    
    NSArray *url = @[
                     @"http://wap.ssjzw.com/hd/job/2011853935.html",
                     @"http://wap.ssjzw.com/hd/job/2011911540.html",
                     @"http://wap.ssjzw.com/hd/job/2011909091.html",
                     @"http://wap.ssjzw.com/hd/job/2011909090.html",
                     @"http://wap.ssjzw.com/hd/job/2011908944.html",
                     @"http://wap.ssjzw.com/hd/job/2011908943.html",
                     ];
    [title enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HomeModel *model = [[HomeModel alloc]init];
        model.title = title[idx];
        model.subtitle = left[idx];
        model.count = [right[idx] integerValue];
        model.URL = url[idx];
        [self.datas addObject:model];
    }];
    [self.tableView reloadData];
}
-(void)loadData
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"tasks"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error){
            //进行错误处理
            [SYProgressHUD showToBottomText:error.description];
        }else{
            if (array) {
                [self.datas removeAllObjects];
                NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(BmobObject *p1, BmobObject *p2){
                    return [[p1 objectForKey:@"sort"] compare:[p2 objectForKey:@"sort"]];
                }];
                for (BmobObject *kkk in sortedArray) {
                    NSDictionary *obj = [kkk mj_keyValues];
                    HomeModel *model = [HomeModel mj_objectWithKeyValues:[obj objectForKey:@"dataDic"]];
                    model.ID = [obj objectForKey:@"objectId"];
                    [self.datas addObject:model];
                }
                
                [self.tableView reloadData];
                
//                [self initGameBtn];
            }
        }
    }];
}
-(void)initUI
{
    
    self.title = @"赚钱大厅";
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"我的ID" style:0 target:self action:@selector(leftClick)];
    
    [self.view addSubview:self.tableView];
    
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -HeaderH, self.view.width, HeaderH)];
    [self.tableView addSubview:headerView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.width , 44)];
    topView.backgroundColor = [GzwThemeTool theme];
    [headerView addSubview:topView];
    
    UIView *contonView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.view.width - 30, 120)];
    contonView.backgroundColor = [UIColor greenColor];
    contonView.layer.shadowColor =  [UIColor blackColor].CGColor;
    contonView.layer.shadowOffset =  CGSizeMake(0,1);
    contonView.layer.shadowOpacity = 0.2;
    [headerView addSubview:contonView];
    _contronView = contonView;
    
    LLWaveView *waveView = [[LLWaveView alloc] initWithFrame:CGRectMake(0, 0, contonView.width, contonView.height)];
    [contonView addSubview:waveView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, contonView.width, 20)];
    label.text = @"可用金币";
    label.font = [UIFont fontWithName:@"Heiti SC" size:20];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [contonView addSubview:label];

    _numLabel = [[DPScrollNumberLabel alloc] initWithNumber:@(0) fontSize:48 textColor:KRGB(204, 177, 106, 1)];
    _numLabel.layer.shadowColor =  [UIColor blackColor].CGColor;
    _numLabel.layer.shadowOffset =  CGSizeMake(2,4);
    _numLabel.layer.shadowOpacity = 0.2;
    [_numLabel sizeToFit];
    [contonView addSubview:_numLabel];
    _numLabel.center = CGPointMake(contonView.width * 0.5, contonView.height * 0.62);
    _numLabel.hidden = YES;
    
    UIActivityIndicatorView *a = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    a.center = CGPointMake(_numLabel.center.x, _numLabel.center.y);//只能设置中心，不能设置大小
    [a startAnimating];
    [contonView addSubview:a];
    _a = a;

    
    
    NSArray *titles = @[@"新手福利",@"高薪专区",@"极速提现",@"淘宝优惠券"];

    CGFloat W = (self.view.width - 30 - titles.count * 10) / titles.count;
    for (int i = 0; i < titles.count; i++) {
        FHTopImgBottomLabel *btn = [FHTopImgBottomLabel buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(15 + ((W + 10) * i), contonView.bottom + 8, W, W+10);
        btn.tintColor = FlatRed;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_b",i]] forState:0];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitle:titles[i] forState:0];
        btn.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:12];
        btn.tag = i;
        if (i == titles.count - 1) {
            [btn setTitleColor:FlatRed forState:0];
        }
        [btn addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
    }

    HKNewsBannerView *newsView = [[HKNewsBannerView alloc] initWithFrame:CGRectMake(20, 210, contonView.width, 30)];
    
    if (self.ads.count == 0) {
        NSArray *newsArr = @[@"数据准备中...",@"数据准备中...",@"数据准备中...",@"数据准备中...",@"数据准备中...",@"数据准备中..."];
        newsView.newsArray = newsArr;
        newsView.imageArray = @[@"laba",@"laba",@"laba",@"laba",@"laba",@"laba",@"laba"];
    }

    newsView.newsColor = [UIColor blackColor];
    newsView.delegate = self;

    [newsView startRolling];
    [headerView addSubview:newsView];
    _newsView = newsView;
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"user"];
    [bquery whereKey:@"UUID" equalTo:[SAMKeychain passwordForService:@"UUID" account:@"UUID"]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        _numLabel.hidden = NO;
        _a.hidden = YES;
        if (array.count > 1) {// 线程问题，有时候会把所有用户查出来
            return ;
        }
        if (error){
            
        }else{
            BmobObject *obj = array.firstObject;
            NSString *str = [obj objectForKey:@"Gold"];
            [_numLabel changeToNumber:@(str.longLongValue) animated:YES];
            _numLabel.center = CGPointMake(_contronView.width * 0.5, _contronView.height * 0.62);
        }
        
    }];
}
-(UIButton *)gameBtn
{
    if (!_gameBtn) {
        _gameBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _gameBtn.center = CGPointMake(CGRectGetMidX(self.view.frame), SCREEN_HEIGHT - 70);
        _gameBtn.layer.cornerRadius = 25.0f;
        _gameBtn.backgroundColor = [GzwThemeTool theme];
        [_gameBtn addTarget:self action:@selector(pushMethod) forControlEvents:UIControlEventTouchUpInside];
        [_gameBtn setImage:[UIImage imageNamed:@"luck_rps_%0_thumb"] forState:UIControlStateNormal];
        
        _gameBtn.hidden = [FHDufulatUtil sharedInstance].config.examine;
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        _timer = timer;
    }
    return _gameBtn;
}
//-(void)initGameBtn
//{
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    button.center = CGPointMake(CGRectGetMidX(self.view.frame), SCREEN_HEIGHT - 70);
//    button.layer.cornerRadius = 25.0f;
//    button.backgroundColor = [GzwThemeTool theme];
//    [button addTarget:self action:@selector(pushMethod) forControlEvents:UIControlEventTouchUpInside];
//    [button setImage:[UIImage imageNamed:@"luck_rps_%0_thumb"] forState:UIControlStateNormal];
//    [self.navigationController.view addSubview:button];
//    button.hidden = [FHDufulatUtil sharedInstance].config.examine;
//    
//    _gameBtn = button;
//    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    _timer = timer;
//}



-(void)timerAction
{
    _timeCount ++;
    NSInteger cont = _timeCount%self.titles.count;
    [self.gameBtn setTitle:_titles[cont] forState:0];
}

#pragma mark - network





#pragma mark - action
// 获取IP
-(void)getIp:(void (^)(NSDictionary *dcit))block
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"]] ;
    [request setHTTPMethod:@"POST"];
    NSURLSessionDataTask * task = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@" ===000 %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] );
        
        if (error == nil && data )
        {
            NSError * jsonError = nil ;
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            block(jsonData);
        }
        return ;
    }];
    
    [task resume];
}
// 判断设备是否安装sim卡
-(BOOL)isSIMInstalled
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        NSLog(@"No sim present Or No cellular coverage or phone is on airplane mode.");
        return NO;
    }
    return YES;
}


-(void)setupRate
{
    [iRate sharedInstance].applicationBundleID = @"www.zuanqianqian.zuanqianqian";
    [iRate sharedInstance].onlyPromptIfLatestVersion = YES;
    [iRate sharedInstance].daysUntilPrompt           = 0;
    [iRate sharedInstance].usesUntilPrompt           = 1;
    [iRate sharedInstance].remindPeriod              = 1;//下次提醒多少天后再提醒，缺省为1天
    //enable preview mode 预览模式是否启用 测试YES 发布NO
    [iRate sharedInstance].previewMode               = NO;
    //    if ([[iRate sharedInstance] shouldPromptForRating]) {
    //        [[iRate sharedInstance] promptForRating];
    //    }
}
void shakerAnimation (UIView *view ,NSTimeInterval duration,float height){

    
    ////An infinity animation
    
    ////Oval animation
    CAKeyframeAnimation * ovalTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    ovalTransformAnim.values         = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                                         [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 10, 0)]];
    ovalTransformAnim.keyTimes       = @[@0, @1];
    ovalTransformAnim.duration       = 0.5;
    ovalTransformAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    ovalTransformAnim.repeatCount    = INFINITY;
    ovalTransformAnim.autoreverses   = YES;
    [view.layer addAnimation:ovalTransformAnim forKey:@"ovalUntitled1Anim"];
}
-(void)leftClick
{
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
}
-(void)talkClck
{
    //在开发者需要调出聊天界面的位置，增加如下代码
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    [chatViewManager pushMQChatViewControllerInViewController:self];
}
-(void)headerClick:(UIButton *)btn
{
    
    if (btn.tag < 3) {
        ZhiWuTBVC *tb = [[ZhiWuTBVC alloc] init];
        tb.type = btn.tag;
        tb.datas = self.datas;
        tb.title = btn.titleLabel.text;
        [self.navigationController pushViewController:tb animated:YES];
    }else if (btn.tag == 3){
        AXWebViewController *axWeb = [[AXWebViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.mayiwo.me/"]];
        axWeb.navigationType = AXWebViewControllerNavigationBarItem;
        [self.navigationController pushViewController:axWeb animated:YES];
    }
}


-(void)rightClick
{
    DuiHuanViewController *duihuan = [[DuiHuanViewController alloc] init];
    duihuan.jinbi_count = [_numLabel.displayedNumber integerValue];
    [self.navigationController pushViewController:duihuan animated:YES];
    
}

-(void)pushMethod
{
    
    
    GameColorVC *gameVC = [[GameColorVC alloc] init];
    gameVC.jinbi_count = [NSString stringWithFormat:@"%@",_numLabel.displayedNumber];
    gameVC.viewDidDissMss = ^(NSInteger jinbi_count){

    };
    [self presentViewController:gameVC animated:YES completion:nil];

    
}

-(void)showRedViewWithSubText:(NSString *)text count:(NSInteger)count
{
    RedPackgeView *redView = [[RedPackgeView alloc] initWithTitle:text count:count isGame:NO];
    redView.degelate = self;
    [redView show];
}


#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([tableView isKindOfClass:YALContextMenuTableView.class]) {
        return self.menuTitles.count;
    }else {
        return self.datas.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isKindOfClass:YALContextMenuTableView.class]) {
        ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
        if (cell) {
            cell.backgroundColor = [UIColor clearColor];
            cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
            cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
        }
        return cell;
    }else {
        HomeModel *model = self.datas[indexPath.row];
        model.row = indexPath.row;
        FHHomeCell *cell = [FHHomeCell cellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([tableView isKindOfClass:YALContextMenuTableView.class]) {
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                NSString *uuid = [SAMKeychain passwordForService:@"UUID" account:@"UUID"];
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = uuid;
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"这是你的唯一ID，只要你用这部iphone，重装app也不会丢失和改变，你可用该ID在任何一款本公司app中访问你的数据，点确定复制ID,妥善保管！" message:uuid preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
                break;
            case 2:
            {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"文本对话框" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                    textField.text = [SAMKeychain passwordForService:@"UUID" account:@"UUID"];
                }];
                UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"重置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                   UITextField *f = alertController.textFields[0];
                    [SAMKeychain setPassword:f.text forService:@"UUID" account:@"UUID"];// 将UUID保存到钥匙串中去
                    //查找GameScore表
                    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"user"];
                    [bquery whereKey:@"UUID" equalTo:[SAMKeychain passwordForService:@"UUID" account:@"UUID"]];
                    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        if (error){
                            
                        }else{
                            BmobObject *obj = array.firstObject;
                            [obj setObject:f.text forKey:@"UUID"];
                            [obj sub_updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                
                                [alertController dismissViewControllerAnimated:YES completion:nil];
                            }];
                        }
                    }];
                }];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [alertController addAction:resetAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
                break;
            case 3:
            {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"严重操作！" message:@"此操作导致非常严重，请在客服的指导下进行，切勿独自尝试！！！切勿独自尝试！！！切勿独自尝试！！！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [SAMKeychain deletePasswordForService:@"UUID" account:@"UUID"];
                    //查找GameScore表
                    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"user"];
                    [bquery whereKey:@"UUID" equalTo:[SAMKeychain passwordForService:@"UUID" account:@"UUID"]];
                    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                        if (error){
                            
                        }else{
                            BmobObject *obj = array.firstObject;
                            [obj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                                
                                [alertController dismissViewControllerAnimated:YES completion:nil];
                            }];
                        }
                    }];
                }];
                
                UIAlertAction *cacelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [alertController addAction:cacelAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            default:
                break;
        }
        [tableView performSelector:@selector(dismisWithIndexPath:) withObject:indexPath];
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        HomeModel *model = self.datas[indexPath.row];
        
        AppDelegate *a = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if (!a.pass) {
            [UITabBar appearance].barTintColor = [UIColor whiteColor];
            NSURL *URL = [NSURL URLWithString:model.URL];
            SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
            [self.navigationController pushViewController:webViewController animated:YES];
            
                    //AXWebViewController *web = [[AXWebViewController alloc] initWithURL:[NSURL URLWithString:model.URL]];
                    //[self.navigationController pushViewController:web animated:YES];
            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"要使用此功能请先咨询客服" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
            
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.URL]];
        }
    }
    
}



#pragma mark - YALContextMenuTableViewDelegate

- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Menu dismissed with indexpath = %@", indexPath);
}






#pragma mark -scrollview
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isMove = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.gameBtn.top = SCREEN_HEIGHT;
    }];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_isMove && !decelerate) {
        [UIView animateWithDuration:0.3 animations:^{
            self.gameBtn.top = SCREEN_HEIGHT - 70;
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.isMove = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.gameBtn.top = SCREEN_HEIGHT - 70;
    }];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    self.isMove = YES;
}

#pragma mark - redViewDegelate
-(void)openRedPackgeViewWithCount:(NSInteger)count
{

}

#pragma mark - alert
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    [self.contextMenuTableView performSelector:@selector(dismisWithIndexPath:) withObject:indexPath];
}

#pragma mark - getter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(HeaderH, 0, 0, 0);
        _tableView.estimatedRowHeight = 70;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSArray *)titles
{
    if (_titles == nil) {
        if ([FHDufulatUtil sharedInstance].config.examine) {
            _titles = @[@"玩",@"游",@"戏",@"得",@"金",@"币"];
        }else{
            _titles = @[@"每",@"日",@"赚",@"80",@"元"];
        }
    }
    return _titles;
}

-(NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

-(NSMutableArray *)ads
{
    if (_ads == nil) {
        _ads = [NSMutableArray array];
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"ads"];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if (error){
                //进行错误处理
                [SYProgressHUD showToBottomText:error.description];
            }else{
                if (array) {
                    [self.ads removeAllObjects];
                    NSMutableArray *adTitls = [NSMutableArray array];
                    NSMutableArray *imgs = [NSMutableArray array];
                    for (BmobObject *kkk in array) {
                        NSDictionary *obj = [kkk mj_keyValues];
                        [self.ads addObject:obj[@"dataDic"]];
                        [adTitls addObject:obj[@"dataDic"][@"title"]];
                        [imgs addObject:@"laba"];
                    }
                    [self.newsView reloadBannerWithNews:adTitls images:imgs];
                }
            }
        }];
    }
    return _ads;
}

//- (GADInterstitial *)createAndLoadInterstitial {
//    GADInterstitial *interstitial =
//    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-7736315964094496/6547332680"];
//    interstitial.delegate = self;
//    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID];
//    [interstitial loadRequest:request];
//    return interstitial;
//}
-(NSArray *)menuTitles
{
    if (!_menuTitles) {
        _menuTitles = @[@"",
                            @"查看ID",
                            @"更换ID",
                            @"删除ID",
//                            @"Add to favourites",
//                            @"Block user"
                        ];
    }
    return _menuTitles;
}
-(NSArray *)menuIcons
{
    if (!_menuIcons) {
        _menuIcons = @[
                       [UIImage imageNamed:@"Icnclose"],
                       [UIImage imageNamed:@"icons8-View_50"],
                        [UIImage imageNamed:@"icons8-Edit File_50"],
//                        [UIImage imageNamed:@"AddToFriendsIcn"],
//                        [UIImage imageNamed:@"AddToFavouritesIcn"],
                        [UIImage imageNamed:@"BlockUserIcn"]
                       ];
    }
    return _menuIcons;
}
-(YALContextMenuTableView *)contextMenuTableView
{
    // init YALContextMenuTableView tableView
    if (!_contextMenuTableView) {
        _contextMenuTableView = [[YALContextMenuTableView alloc]initWithTableViewDelegateDataSource:self];
        _contextMenuTableView.rowHeight = 65;
        _contextMenuTableView.animationDuration = 0.1;
        //optional - implement custom YALContextMenuTableView custom protocol
        _contextMenuTableView.yalDelegate = self;
        //optional - implement menu items layout
        _contextMenuTableView.menuItemsSide = Left;
        _contextMenuTableView.menuItemsAppearanceDirection = FromTopToBottom;
        
        //register nib
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [_contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
    }
    return _contextMenuTableView;
}
-(UIButton *)talkBtn
{
    if (!_talkBtn) {
        _talkBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _talkBtn.frame = CGRectMake(ViewW - 65, self.view.height - 130, 50, 50);
        _talkBtn.layer.cornerRadius = 25.0f;
        _talkBtn.tintColor = [UIColor whiteColor];
        _talkBtn.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        _talkBtn.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _talkBtn.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        _talkBtn.layer.shadowRadius = 4;//阴影半径，默认3
        _talkBtn.backgroundColor = [GzwThemeTool theme];
        [_talkBtn addTarget:self action:@selector(talkClck) forControlEvents:UIControlEventTouchUpInside];
        [_talkBtn setImage:[UIImage imageNamed:@"icons8-Speech Bubble with Dots_"] forState:UIControlStateNormal];
        shakerAnimation(_talkBtn, 1, 20);
    }
    return _talkBtn;
}
@end
