//
//  AppDelegate.m
//  work
//
//  Created by pc on 2017/8/10.
//  Copyright © 2017年 pc. All rights reserved.
//

#define BMOB_KEY @"d4143c09cdb7e5d485251b00b232c526"
#define GOOLE_KEY @"ca-app-pub-7736315964094496~1486577696"

#define JPUSH_KEY @"3ec8ddac026bf125d8edb52d"

#import "IQKeyboardManager.h"
#import "m1AppDelegate.h"
//#import <GoogleMobileAds/GoogleMobileAds.h>
#import <UserNotifications/UserNotifications.h>
#import <BmobSDK/Bmob.h>
#import <BaiduMobStat.h>
#import <JPUSHService.h>
#import "GzwThemeTool.h"
#import "SAMKeychain.h"
#import <SAMKeychain/SAMKeychain.h>
#import <MeiQiaSDK/MeiQiaSDK.h>

#import "Harpy.h"
#import "IWNavigationController.h"
#import "ViewController.h"

#import "GZWTool.h"
@interface m1AppDelegate ()<JPUSHRegisterDelegate>
@property(nonatomic,strong)UITabBarController *tb;
@end

@implementation m1AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Bmob registerWithAppKey:BMOB_KEY];
    [[BaiduMobStat defaultStat] startWithAppId:@"046f44a2ba"];

    self.window                                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor                    = [UIColor whiteColor];
    self.window.rootViewController = [UIStoryboard storyboardWithName:@"mainSB" bundle:nil].instantiateInitialViewController;
    [self.window makeKeyAndVisible];
    
    [self creatUse];
    [self setupKeyboard];
    
    
   //[self loadTureVC];
    [self loadFalseVC];
    
    
    return YES;
}

- (void)setJupsh:(NSDictionary *)launchOptions{
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
    }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_KEY
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
    }];
}
-(void)creatUse
{
//    [SAMKeychain deletePasswordForService:@"UUID" account:@"UUID"];
    NSString *UUID = [SAMKeychain passwordForService:@"UUID" account:@"UUID"];// 从钥匙串中获取UUID
    if (!UUID) {// 获取不到则自己生成
        UUID = [[NSUUID UUID] UUIDString];
        //往GameScore表添加一条playerName为小明，分数为78的数据
        BmobObject *gameScore = [BmobObject objectWithClassName:@"user"];
        [gameScore setObject:UUID forKey:@"UUID"];
        [gameScore setObject:@"0" forKey:@"Gold"];
        [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            //进行操作
            if (isSuccessful) {
                [SAMKeychain setPassword:UUID forService:@"UUID" account:@"UUID"];// 将UUID保存到钥匙串中去
            }
        }];
    }
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    BmobUser *user = [BmobUser currentUser];
    if (user.objectId.length > 0) {
        NSLog(@"%@",user.objectId);
        [JPUSHService setTags:[NSSet setWithObject:user.objectId] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            
        } seq:0];
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {  //应用内消息,由锁屏进入应用内
    NSDictionary *userInfo = [notification userInfo];
    
    [JPUSHService handleRemoteNotification:userInfo];
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"SSSSSS" object:nil userInfo:userInfo];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationWillEnterForeground" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)setupKeyboard
{
    [MQManager initWithAppkey:@"5979a4368c7786c76b58306036952553" completion:^(NSString *clientId, NSError *error) {
    }];
    [GzwThemeTool setup];
    // 创建键盘管理者，它是个全局单利对象
    IQKeyboardManager *manager                  = [IQKeyboardManager sharedManager];
    // 设置激活状态
    manager.enable                              = YES;
    // 控制点击背景是否收起键盘。
    manager.shouldResignOnTouchOutside          = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义。
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    // 控制是否显示键盘上的工具条。
    manager.enableAutoToolbar                   = YES;
    //    [manager disableToolbarInViewControllerClass:NSClassFromString(@"QYSessionViewController")];
    //    [manager disableInViewControllerClass:NSClassFromString(@"QYSessionViewController")];
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
// 展示马甲
-(void)loadFalseVC
{
    
}
@end
