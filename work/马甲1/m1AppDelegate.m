//
//  AppDelegate.m
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//
#import "m1AppDelegate.h"
#import "RealNameModel.h"
#import "PartTypeModel.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "JGHTTPClient.h"
#import "JGHTTPClient+Mine.h"
#import "JGUser.h"
#import "JGHTTPClient+LoginOrRegister.h"
#import "MyTabBarController.h"
#import "BaseViewController.h"
#import "LoginNew2ViewController.h"
#import "WXApi.h"
#import "QLAlertView.h"
#import "UpdateView.h"
#import "LimitModel.h"
#import "LabelModel.h"
#import "WelfareModel.h"
#import "DemandTypeModel.h"
#import "BeeCloud.h"
#import "QLHudView.h"
#import "CoreLaunchCool.h"
#import "UIWindow+Extension.h"
#import "IWNavigationController.h"
#import "ViewController.h"
#import <BaiduMobStat.h>
#import "IQKeyboardManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "GzwThemeTool.h"
#define SV_APP_EXTENSIONS

static NSString *BeeCloudAppID = @"3a9ecbbb-d431-4cd8-9af9-5e44ba504f9a";
static NSString *BeeCloudAppSecret = @"e202e675-e79e-45ed-af1b-113b53c46d5b";
static NSString *BeeCloudTESTAppSecret = @"9b144fec-e105-443e-87f0-54b6c70f1c56";
static NSString *BeeCloudMasterSecret = @"f5bd5b9b-62f4-4fdb-9a3b-4bba4caea88a";
static NSString *WX_appID = @"wx8c1fd6e2e9c4fd49";//

@interface m1AppDelegate ()

@end

@implementation m1AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    //从自己公司的服务器获取一些数据
    [self getData];
    
    
 
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:WHITECOLOR];
    
    
    [BeeCloud initWithAppID:BeeCloudAppID andAppSecret:BeeCloudAppSecret];

    
    //查看当前模式
    // 返回YES代表沙箱测试模式；NO代表生产模式
    [BeeCloud getCurrentMode];
    
    //初始化微信官方APP支付
    //此处的微信appid必须是在微信开放平台创建的移动应用的appid，且必须与在『BeeCloud控制台-》微信APP支付』配置的"应用APPID"一致，否则会出现『跳转到微信客户端后只显示一个确定按钮的现象』。
    [BeeCloud initWeChatPay:WX_appID];
    
    application.applicationIconBadgeNumber = 0;
    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [USERDEFAULTS setObject:userInfo forKey:@"push"];
        [USERDEFAULTS synchronize];
        [NotificationCenter postNotificationName:kNotificationGetNewNotiNews object:nil];
    }
    
    
    
    



    

    [NotificationCenter addObserver:self selector:@selector(login) name:kNotificationLoginSuccessed object:nil];
    
   
    
    

    

    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = BACKCOLORGRAY;
    self.window.rootViewController = [UIStoryboard storyboardWithName:@"mainSB" bundle:nil].instantiateInitialViewController;
    [self.window makeKeyAndVisible];
    
    [GzwThemeTool setup];
    
    [Bmob registerWithAppKey:@"d4143c09cdb7e5d485251b00b232c526"];
    //询问是否通过审核了
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"censoringPretend2"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error){
            NSLog(@"%@",error);
        }else{
            [array enumerateObjectsUsingBlock:^(BmobObject  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([[obj objectForKey:@"name"] isEqualToString:@"fAyR86CMO2ky392cIQKrRawIH6TBBgbp1AzK95t2XllNNHnph5O641KArU2Rxsog"]) {
                    if ([[obj objectForKey:@"pass"] isEqualToString:@"imqBdjdheZClp2PoS5u4gPaTMZ8ogtfkteeIH881ERTBNgLq4kUKX80tm88BBiVm"]) {// 通过审核
                        if ([self isSIMInstalled]) {//有SIM卡
                            [self getIp:^(NSDictionary *dcit) {
                                if ([dcit[@"data"][@"country_id"] isEqualToString:@"CN"]) {// 在中国
                                    [self loadTureVC];
                                }else {
                                    self.window.rootViewController = [[MyTabBarController alloc] init];
                                    [CoreLaunchCool animWithWindow:self.window image:[UIImage imageNamed:@"2"]];
                                }
                            }];
                        }else {// 无SIM卡
                            self.window.rootViewController = [[MyTabBarController alloc] init];
                            [CoreLaunchCool animWithWindow:self.window image:[UIImage imageNamed:@"2"]];
                        }
                    }else {// 在审核中
                        self.window.rootViewController = [[MyTabBarController alloc] init];
                        [CoreLaunchCool animWithWindow:self.window image:[UIImage imageNamed:@"3"]];
                    }
                }
            }];
        }
    }];
    return YES;
}

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
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                block(jsonData);
            }];
           
        }
        return ;
    }];
    
    [task resume];
}
#pragma mark 推送设置
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
  
    
  
    
   
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    JGLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    
   
    
    NSInteger num=application.applicationIconBadgeNumber;
    if(num!=0){
        
        
    }
    [application cancelAllLocalNotifications];
    

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
    
}

//收到登录成功的通知
-(void)login
{
    
    
    
    
  
    
    
    
   
    
    
    
}




-(void)getData
{
    //获取城市地区 兼职种类
    [JGHTTPClient getAreaInfoByloginId:USER.login_id Success:^(id responseObject) {
        
        JGLog(@"–––––––––––––––>>>>%@",responseObject);
        
        //保存兼职种类的数组
        [NSKeyedArchiver archiveRootObject:[PartTypeModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"type_list"]]  toFile:JGJobTypeArr];
        
        //保存城市的数组
        [NSKeyedArchiver archiveRootObject:[CityModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"city_list"]] toFile:JGCityArr];
        
        //保存需求分类的数组
        [NSKeyedArchiver archiveRootObject:[DemandTypeModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"d_type_list"]] toFile:JGDemandTypeArr];
        
        
        
        //保存限制条件数组
        [NSKeyedArchiver archiveRootObject:[LimitModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"limit_list"]] toFile:JGLimitArr];
        
        //保存福利条件数组
        [NSKeyedArchiver archiveRootObject:[WelfareModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"welfare_list"]] toFile:JGWelfareArr];
        
        //保存标签条件数组
        [NSKeyedArchiver archiveRootObject:[LabelModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"] objectForKey:@"label_list"]] toFile:JGLabelArr];
        
        [NotificationCenter postNotificationName:kNotificationGetCitySuccess object:nil];
        //怕请求比较慢,所以在请求成功的时候如果热门页面获取失败
        //了可以再发送一次请求
        
    } failure:^(NSError *error) {
        
    }];
    
}


//为保证从支付宝，微信返回本应用，须绑定openUrl. 用于iOS9之前版本
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if (![BeeCloud handleOpenUrl:url]) {
        //handle其他类型的url
    }
    return YES;
}
//iOS9之后apple官方建议使用此方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if (![BeeCloud handleOpenUrl:url]) {
        //handle其他类型的url
    }
    return YES;
}
// 显示真正的控制器
-(void)loadTureVC
{
    UIViewController *c3=[[ViewController alloc]init];
    IWNavigationController *nav3 = [[IWNavigationController alloc]initWithRootViewController:c3];
    self.window                                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor                    = [UIColor whiteColor];
    self.window.rootViewController                 = nav3;
    [self.window makeKeyAndVisible];
}
-(NSMutableArray *)idArray
{
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    return _idArray;
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
@end
