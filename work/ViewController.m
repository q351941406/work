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
static NSString *const menuCellIdentifier = @"rotationCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,HKNewsBannerViewDelegate,RedPackgeViewDegelate,GADInterstitialDelegate,UIAlertViewDelegate,YALContextMenuTableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) UIView *contronView;
@property (nonatomic,weak) HKNewsBannerView *newsView;
@property (nonatomic,weak) UIButton *gameBtn;
@property (nonatomic,strong) UIButton *talkBtn;
@property (nonatomic,strong) DPScrollNumberLabel *numLabel; //金额
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSMutableArray *ads;
@property (nonatomic,strong) NSMutableArray *datas;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (assign, nonatomic) NSInteger timeCount;
@property (assign, nonatomic) BOOL isMove;
@property (assign, nonatomic) BOOL isGoAppstore;
@property(nonatomic, strong) UIActivityIndicatorView *a;

@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;
@end

@implementation ViewController

void shakerAnimation (UIView *view ,NSTimeInterval duration,float height){
    NSString * fillMode = kCAFillModeForwards;
    
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
-(void)talkClck
{
    //在开发者需要调出聊天界面的位置，增加如下代码
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    [chatViewManager pushMQChatViewControllerInViewController:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    [self initUI];
//    [self.navigationController setValue:[[YALNavigationBar alloc]init] forKeyPath:@"navigationBar"];

//    if (![SAMKeychain passwordForService:@"UUID" account:@"UUID"]) {
//        RedPackgeView *redView = [[RedPackgeView alloc] initWithTitle:@"新用户送5999金币" count:5999 isGame:NO];
//        redView.degelate = self;
//        [redView show];
//    }
    
    
    [self checkNetworkStatus];
    
    [self.view addSubview:self.talkBtn];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (![FHDufulatUtil sharedInstance].config.examine) {
        _gameBtn.hidden = YES;
    }
//    self.navigationController.navigationBar.translucent = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![FHDufulatUtil sharedInstance].config.examine) {
        _gameBtn.hidden = NO;
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

-(void)initUI
{
    
    self.title = @"赚钱大厅";
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"我的ID" style:0 target:self action:@selector(leftClick)];
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"duihuan"] style:0 target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = right;
    
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
-(void)leftClick
{
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
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
-(void)initGameBtn
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.center = CGPointMake(CGRectGetMidX(self.view.frame), SCREEN_HEIGHT - 70);
    button.layer.cornerRadius = 25.0f;
    button.backgroundColor = [GzwThemeTool theme];
//    [button setTitleColor:[GzwThemeTool complementaryFlatColor] forState:0];
    [button addTarget:self action:@selector(pushMethod) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"luck_rps_%0_thumb"] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:button];
    button.hidden = [FHDufulatUtil sharedInstance].config.examine;
    
    _gameBtn = button;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    _timer = timer;
}



-(void)timerAction
{
    _timeCount ++;
    NSInteger cont = _timeCount%self.titles.count;
    [_gameBtn setTitle:_titles[cont] forState:0];
}

#pragma mark - network

-(void)checkNetworkStatus
{
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                [FHDufulatUtil sharedInstance].network = NO;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                [FHDufulatUtil sharedInstance].network = YES;
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                [FHDufulatUtil sharedInstance].network = YES;
                break;
            }
            case AFNetworkReachabilityStatusUnknown:
                [FHDufulatUtil sharedInstance].network = NO;
                break;
            default:
                
                break;
        }
    }];
}




#pragma mark - click
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
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"文本对话框" message:@"登录和密码对话框示例" preferredStyle:UIAlertControllerStyleAlert];
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
                
                
                
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"严重操作！" message:@"此操作导致非常严重，请在客服的指导下进行，切勿独自尝试！！！切勿独自尝试！！！切勿独自尝试！！！" preferredStyle:UIAlertControllerStyleAlert];
//                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
//                    textField.text = [SAMKeychain passwordForService:@"UUID" account:@"UUID"];
//                }];
//                UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                    UITextField *f = alertController.textFields[0];
//                    //查找GameScore表
//                    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"user"];
//                    [bquery whereKey:@"UUID" equalTo:[SAMKeychain passwordForService:@"UUID" account:@"UUID"]];
//                    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                        if (error){
//                            
//                        }else{
//                            BmobObject *obj = array.firstObject;
//                            [obj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
//                                [SAMKeychain deletePasswordForService:@"UUID" account:@"UUID"];
//                                [alertController dismissViewControllerAnimated:YES completion:nil];
//                            }];
//                        }
//                    }];
//                }];
//                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//                [alertController addAction:okAction];
//                [alertController addAction:resetAction];
//                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            default:
                break;
        }
        [tableView performSelector:@selector(dismisWithIndexPath:) withObject:indexPath];
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        HomeModel *model = self.datas[indexPath.row];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"pass"]) {
            //        AXWebViewController *web = [[AXWebViewController alloc] initWithURL:[NSURL URLWithString:model.URL]];
            //        [self.navigationController pushViewController:web animated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"要使用此功能请先咨询客服" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
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
        _gameBtn.top = SCREEN_HEIGHT;
    }];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_isMove && !decelerate) {
        [UIView animateWithDuration:0.3 animations:^{
            _gameBtn.top = SCREEN_HEIGHT - 70;
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.isMove = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _gameBtn.top = SCREEN_HEIGHT - 70;
    }];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    self.isMove = YES;
}

#pragma mark - redViewDegelate
-(void)openRedPackgeViewWithCount:(NSInteger)count
{
    [self viewWillAppear:YES];
    [self viewDidAppear:YES];
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
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
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(HeaderH, 0, 0, 0);
        _tableView.rowHeight = 140;
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
                    
                    [self initGameBtn];
                }
            }
        }];
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

- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-7736315964094496/6547332680"];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    [interstitial loadRequest:request];
    return interstitial;
}
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

@end
