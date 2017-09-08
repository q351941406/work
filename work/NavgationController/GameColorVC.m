

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

#define MAX_level 18

#import "GameColorVC.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import  <AVFoundation/AVFoundation.h>
#import "GameResultCell.h"
#import "RedPackgeView.h"
#import "FHExplainxibView.h"
#import "YQLightLab.h"
#import "FHJiangLiView.h"


@interface GameColorVC ()<AVAudioPlayerDelegate,UITableViewDelegate,UITableViewDataSource,RedPackgeViewDegelate,GADInterstitialDelegate,UIAlertViewDelegate,GADRewardBasedVideoAdDelegate>
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (weak, nonatomic) IBOutlet UIButton *shitouBtn;
@property (weak, nonatomic) IBOutlet UIButton *buBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiandaoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottmImage;
@property (nonatomic,strong) NSTimer *timer;
@property (strong, nonatomic) NSArray *btns;
@property (strong, nonatomic) NSMutableArray *results;
@property (weak,   nonatomic) IBOutlet UITableView *resutTableView;
@property (weak,   nonatomic) IBOutlet UILabel *gameTitle;
@property (weak,   nonatomic) IBOutlet UILabel *maxTitle;
@property (assign, nonatomic) NSInteger ewaiCount;
@property (assign, nonatomic) NSInteger maxCount;
@property (assign, nonatomic) NSInteger timerCount;
@property (assign, nonatomic) BOOL isAlwaysAd;
@property (assign, nonatomic) BOOL isJingAlert;
@property (assign, nonatomic) NSInteger level; //等级
@property (weak,   nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *jinBILabel;
@property (weak, nonatomic) IBOutlet UIView *bageView;

@end

@implementation GameColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.shitouBtn.layer.borderWidth = 4;
    self.shitouBtn.layer.cornerRadius = 4;
    self.shitouBtn.clipsToBounds = YES;
    self.shitouBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.jiandaoBtn.layer.borderWidth = 4;
    self.jiandaoBtn.layer.cornerRadius = 4;
    self.jiandaoBtn.clipsToBounds = YES;
    self.jiandaoBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.buBtn.layer.borderWidth = 4;
    self.buBtn.layer.cornerRadius = 4;
    self.buBtn.clipsToBounds = YES;
    self.buBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.btns = @[self.shitouBtn,self.jiandaoBtn,self.buBtn];
    
    self.resutTableView.dataSource = self;
    self.resutTableView.delegate = self;
    self.resutTableView.bounces = NO;
    self.resutTableView.userInteractionEnabled = NO;
    self.resutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.resutTableView.showsVerticalScrollIndicator = NO;
    self.resutTableView.showsHorizontalScrollIndicator = NO;
    
    self.backButton.layer.cornerRadius = 6;
    self.backButton.clipsToBounds = NO;
    self.backButton.layer.shadowColor = KRGB(29, 103, 289, 1).CGColor;
    self.backButton.layer.shadowOffset = CGSizeMake(4, 4);
    self.backButton.layer.shadowOpacity = 1;
    self.backButton.layer.shadowRadius = 6;

    self.jinBILabel.text = self.jinbi_count;
    
    self.ewaiCount = [FHDufulatUtil sharedInstance].maxCount;  //金币
    NSInteger liansheng = [FHDufulatUtil sharedInstance].lisheng;  //连胜
    if (Liansheng > 0) {
        self.maxCount = liansheng;
        self.maxTitle.text = [NSString stringWithFormat:@"每局可额外获得%ld金币",(long)self.ewaiCount];
        self.gameTitle.text = [NSString stringWithFormat:@"今日最高获得%ld连胜",(long)self.maxCount];
    }
    
    //AD
//    self.interstitial = [self createAndLoadInterstitial];
//    
//    [GADRewardBasedVideoAd sharedInstance].delegate = self;
//    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
//                                           withAdUnitID:@"ca-app-pub-5630134464311346/8390260332"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRedBage) name:nil object:nil];
    
    [self checkRedBage];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (self.viewDidDissMss) {
        self.viewDidDissMss([self.jinBILabel.text integerValue]);
    }
}

#pragma mark - action
- (IBAction)shitoujiandaobuClick:(id)sender {
    UIButton *senderbtn = sender;
    for (UIButton *button in self.btns) {
        if (senderbtn.tag == button.tag) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
        button.userInteractionEnabled   = NO;
    }
    
    [self seletedMusicWithName:@"sfx_wing.caf"];
    _bottmImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"rps_option_%ld",(long)senderbtn.tag]];
    
    NSInteger yin = 0;
    NSInteger shu = 0;
    NSInteger pin = senderbtn.tag;
    if (senderbtn.tag == 1) {
        yin = 3;
        shu = 2;
    }else if (senderbtn.tag == 2){
        yin = 1;
        shu = 3;
    }else if (senderbtn.tag == 3){
        yin = 2;
        shu = 1;
    }
    
    self.level += 1; //没进行一次等级＋1
    
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < MAX_level + 1; i++) {
        if (self.level > i + 1) {
            int k = 3 + i;
            if ((k % 2) >= 1) {
                [ary addObject:@(pin)];
            }else{
                [ary addObject:@(shu)];
            }
        }else{
            [ary addObject:@(yin)];
        }
    }
    
    NSInteger arcNum = arc4random() %19;
    NSInteger result = [ary[arcNum] integerValue];
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [self seletedMusicWithName:@"luck_running.wav"];
    
    //延时2秒后出结果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timer invalidate];
        
        self.shitouBtn.userInteractionEnabled = YES;
        self.jiandaoBtn.userInteractionEnabled = YES;
        self.buBtn.userInteractionEnabled = YES;

        _topImage.image =  [UIImage imageNamed:[NSString stringWithFormat:@"rps_option_fan%ld",(long)result]];
        [self seletedMusicWithName:@"sfx_point.caf"];
        NSString *K;
        
        int ResultValue = 0;
        
        if (result == yin) {
            ResultValue = 0;
            K = @"赢";
            if (self.level > 0) {
                K = [NSString stringWithFormat:@"%ld 连胜",(long)self.level];
            }
            
            [FHDufulatUtil sharedInstance].shenglicount += 1;
        }else if (result == shu){
            ResultValue = 1;
            int F = arc4random() % self.level;
            self.level -= F;
            K = [NSString stringWithFormat:@"连胜降为 %ld",(long)self.level];
            
        }else if (result == pin){
            ResultValue = 2;
            self.level --;
            K = @"双方平局";
        }
        
        if (self.level > self.maxCount) {
            self.maxCount = self.level;
            
            if (self.maxCount >= 3 && self.maxCount <= 5) {
                self.ewaiCount = 5;
            }else if (self.maxCount > 5 && self.maxCount <= 7){
                self.ewaiCount = 10;
            }else if (self.maxCount > 7 && self.maxCount <= 9){
                self.ewaiCount = 15;
            }else if (self.maxCount > 9 && self.maxCount <= 11){
                self.ewaiCount = 20;
            }else if (self.maxCount > 11 && self.maxCount <= 13){
                self.ewaiCount = 25;
            }else if (self.maxCount > 13 && self.maxCount <= 15){
                self.ewaiCount = 30;
            }else if (self.maxCount > 15 && self.maxCount <= 17){
                self.ewaiCount = 35;
            }else if (self.maxCount > 17 && self.maxCount <= 20){
                self.ewaiCount = 40;
            }
            
        }

        self.maxTitle.text = [NSString stringWithFormat:@"每局可额外获得%ld金币",(long)self.ewaiCount];
        self.gameTitle.text = [NSString stringWithFormat:@"今日最高获得%ld连胜",(long)self.maxCount];
        
        //保存当日纪录
        [FHDufulatUtil sharedInstance].maxCount = self.ewaiCount;
        [FHDufulatUtil sharedInstance].lisheng = self.maxCount;

        
        [self.results addObject:K];
        [self.resutTableView reloadData];
        [self.resutTableView setContentOffset:CGPointMake(0, self.resutTableView.contentSize.height -self.resutTableView.bounds.size.height) animated:self.results.count > 5 ? YES : NO];
        [self openRedViewWithResult:ResultValue];
    });
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)jieshao:(id)sender {
    FHExplainxibView *xibView = [[[NSBundle mainBundle] loadNibNamed:@"FHExplainxibView" owner:nil options:nil] lastObject];
    xibView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:xibView];
}

- (IBAction)meirirenwu:(id)sender {
    FHJiangLiView *xibView = [[[NSBundle mainBundle] loadNibNamed:@"FHJiangLiView" owner:nil options:nil] lastObject];
    xibView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    xibView.jinbi_count = [self.jinBILabel.text integerValue];
    [self.view addSubview:xibView];
}


-(void)timerAction
{
    self.timerCount ++;
    _topImage.image =  [UIImage imageNamed:[NSString stringWithFormat:@"rps_option_fan%ld",(self.timerCount % 3 + 1)]];
}

-(void)openRedViewWithResult:(int)result
{
    
    NSString *name;
    NSInteger count;
    
    if (result == 0) {  //输赢
//        name = [NSString stringWithFormat:@"✌️猜对了 基础 20 + 额外 %ld",(long)self.ewaiCount];
        count = self.ewaiCount + 20;
    }else if (result == 2){
        name = @"😐平分秋色 奖励 10";
        count = 10;
    }else{
        name = @"😖输了 安慰奖 1";
        count = 1;
    }
    
    RedPackgeView *redView = [[RedPackgeView alloc] initWithTitle:name count:count isGame:YES];
    redView.degelate = self;
    [redView show];
}


-(void)seletedMusicWithName:(NSString *)name
{
    SystemSoundID sound;
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &sound);
    AudioServicesPlaySystemSound(sound);
}

#pragma mark - tableViewDegelate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameResultCell *cell = [GameResultCell cellWithTableView:tableView];
    cell.titelText.text = [NSString stringWithFormat:@" %@     ",self.results[indexPath.row]];
    return cell;
}

#pragma mark - redViewDegelate
-(void)openRedPackgeViewWithCount:(NSInteger)count
{
    self.jinBILabel.text = [NSString stringWithFormat:@"%ld",([self.jinBILabel.text integerValue] + count)];
    //打开广告
    
//    if (self.interstitial.isReady == NO) {
//        self.interstitial = [self createAndLoadInterstitial];
//    }
//    
//    if (self.interstitial.isReady) {
//        [self.interstitial presentFromRootViewController:self];
//    }else{
//        if ([[GADRewardBasedVideoAd sharedInstance] isReady] && self.isJingAlert) {
//            [self showAlert];
//        }
//    }
    
    //检查小红点是否存在
    [self checkRedBage];
}

-(void)checkRedBage{
    NSArray *ary = @[@(10),@(50),@(100),@(200),@(300),@(400),@(500)];
    NSInteger count =  [FHDufulatUtil sharedInstance].shenglicount;

    for (int i = 0; i < 7; i++) {
        NSInteger kkk = [ary[i] integerValue];
        if (count >= kkk) {
            if ([[FHDufulatUtil sharedInstance]getBoolWithKey:[NSString stringWithFormat:@"%d",i]]) {
                self.bageView.hidden = YES;
            }else{
                self.bageView.hidden = NO;
                break;
            }
        }
    }
}

#pragma mark - AD
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    
    self.interstitial = [self createAndLoadInterstitial];
    
    if (self.isJingAlert) {
        return;
    }
    if (self.isAlwaysAd) {
        if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
            [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
        }
        return;
    }
    
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [self showAlert];
    }
}

-(void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"观看广告,即可获得88~188金币奖励" message:nil delegate:self cancelButtonTitle:@"😥取消" otherButtonTitles:@"😍获取更多金币", @"😊每次游戏结束我都要随机奖励",@"😖本局游戏不想多看广告",nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }else if (buttonIndex == 2){
        self.isAlwaysAd = YES;
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }else if (buttonIndex == 3){
        self.isJingAlert = YES;
    }
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
    reward.type,
    [reward.amount doubleValue]];
    NSLog(@"%@", rewardMessage);
    
    //准备广告
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
                                           withAdUnitID:@"ca-app-pub-7736315964094496/5234251018"];
    [self haveMoneyWithCount:(arc4random() %101) + 87];
}

-(void)haveMoneyWithCount:(NSInteger)count
{
    self.jinBILabel.text = [NSString stringWithFormat:@"%ld",(long)[self.jinBILabel.text integerValue] + count];
    [SYProgressHUD showToBottomText:[NSString stringWithFormat:@"您获得%ld个金币",(long)count]];
    BmobUser *bUser = [BmobUser currentUser];
    [bUser setObject:@([self.jinBILabel.text integerValue]) forKey:@"money"];
    [bUser setObject:[NSString getCurrentTime] forKey:@"mytime"];
    [bUser sub_updateInBackgroundWithResultBlock:nil];
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}


#pragma mark - 懒加载
-(NSMutableArray *)results
{
    if (_results == nil) {
        _results = [NSMutableArray array];
    }
    return _results;
}

- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-5630134464311346/8515874107"];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    [interstitial loadRequest:request];
    return interstitial;
}


@end
