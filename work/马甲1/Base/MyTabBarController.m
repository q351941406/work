//
//  MyTabBarController.m
//  JianGuo
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "MyTabBarController.h"

#import "MineNewViewController.h"
#import "HomeViewController.h"
#import "HomeSegmentViewController.h"
#import "DemandListViewController.h"
#import "DiscoveryViewController.h"
#import "PartJobViewController.h"
#import "DemandDetailNewViewController.h"

#import "NewsScrollViewController.h"

#import "RemindMsgViewController.h"
#import "MyWalletNewViewController.h"
#import "RealNameNewViewController.h"
#import "SignDemandViewController.h"

#import "MyPostDetailViewController.h"
#import "BillsViewController.h"
#import "MySignDetailViewController.h"

#import "JianZhiDetailController.h"
#import "MyPartJobViewController.h"
#import "WebViewController.h"
#import "MineChatViewController.h"




#import "POP.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"

@interface MyTabBarController ()<UITabBarControllerDelegate>



@end

@implementation MyTabBarController




-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        


    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setChildController];
    
   
    
}




//测试一下分支
-(void)testBranch
{
    
}

-(void)setChildController
{
    
    HomeSegmentViewController *homeVC = [[HomeSegmentViewController alloc] init];
    homeVC.title = @"首页";

    //设置图标
//    homeVC.tabBarItem.badgeValue = @"2";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"zh_sy"];
    //选中图标样式  修改渲染模式
    homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"xz_sy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    navHome.tabBarItem.title = @"首页";
    
    
    HomeViewController *partjobVC = [[HomeViewController alloc] init];
    partjobVC.title = @"兼职";
    //设置图标
    partjobVC.tabBarItem.image = [UIImage imageNamed:@"part-times"];
    //选中图标样式  修改渲染模式
    partjobVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"parttime"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navPartjob = [[UINavigationController alloc] initWithRootViewController:partjobVC];
    navPartjob.tabBarItem.title = @"兼职";
    
    
    DiscoveryViewController *discoveryVC = [[DiscoveryViewController alloc] init];
    discoveryVC.title = @"发现新鲜";
    //设置图标
    discoveryVC.tabBarItem.image = [UIImage imageNamed:@"find"];
    //选中图标样式  修改渲染模式
    discoveryVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"finds"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navDiscovery = [[UINavigationController alloc] initWithRootViewController:discoveryVC];
    navDiscovery.tabBarItem.title = @"发现";
    


    
    NewsScrollViewController *chatVC = [[NewsScrollViewController alloc] init];

    chatVC.title = @"果聊";
    //设置图标
    chatVC.tabBarItem.image = [UIImage imageNamed:@"zh_lt"];
    //选中图标样式  修改渲染模式
    chatVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"xz_lt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navChat = [[UINavigationController alloc] initWithRootViewController:chatVC];
    navChat.tabBarItem.title = @"果聊";
    
    
    MineNewViewController *mineVC = [[MineNewViewController alloc] init];
    mineVC.title = @"我的";
    //设置图标
    mineVC.tabBarItem.image = [UIImage imageNamed:@"zh_wd"];
    //选中图标样式  修改渲染模式
    mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"xz_wd"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navMine = [[UINavigationController alloc] initWithRootViewController:mineVC];
    navMine.tabBarItem.title = @"我的";
    
    
//    [self addChildViewController:navHome];
    [self addChildViewController:navPartjob];
//    [self addChildViewController:navDiscovery];
    [self addChildViewController:navChat];
    [self addChildViewController:navMine];

    self.tabBar.tintColor = RGBCOLOR(113, 170, 58); // 设置tabbar上的字体颜色
    
}



-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{

    
        APPLICATION.keyWindow.backgroundColor = WHITECOLOR;

    
    
    
    NSInteger index = [tabBarController.childViewControllers indexOfObject:viewController];
    UIView *tabBarBtn = tabBarController.tabBar.subviews[index+1];

    UIImageView *imageV = tabBarBtn.subviews.firstObject;
    
    

    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shakeAnimation.duration = 0.15f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    shakeAnimation.toValue = [NSNumber numberWithFloat:1.5];
    shakeAnimation.autoreverses = YES;
    [imageV.layer addAnimation:shakeAnimation forKey:nil];
    
    return YES;
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}


-(void)dealloc
{
    [NotificationCenter removeObserver:self name:kNotificationClickNotification object:nil];
}

@end
