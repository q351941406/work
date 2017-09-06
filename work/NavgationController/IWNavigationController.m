//
//  JPNavigationController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWNavigationController.h"
#import "GzwThemeTool.h"
#import "Chameleon.h"

@interface IWNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)UIPanGestureRecognizer *pan;
@end

@implementation IWNavigationController
-(UIPanGestureRecognizer *)pan
{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    }
    return _pan;
}
/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
    // 全局的设置
    [[UITextField appearance] setTintColor:[UIColor colorWithRed:246/255.0f green:59/255.0f blue:125/255.0f alpha:1]];
    [[UITextView appearance] setTintColor:[UIColor colorWithRed:246/255.0f green:59/255.0f blue:125/255.0f alpha:1]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        __weak typeof(self) weakSelf = self;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
    // 半透明会影响导航栏的颜色，如果有控制器需要透明，可在自身里自行设置
//    self.navigationBar.translucent  = NO;
    
    
    
    // 添加拖动手势监听
//    [self.view addGestureRecognizer:self.pan];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    
//    UIImage* image = [UIImage imageNamed:@"返回"];
//    // 加载图片的宽度结合resizableImageWithCapInsets生成一个缩放时不会拉伸的新图片作为BackButtonBackgroundImage
////    [item setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    
    
    //    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"goods_detaile_back_dowm"]];
    //    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"goods_detaile_back_dowm"]];
    //    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    
//    //自定义返回按钮
//    UIImage *backButtonImage = [[UIImage imageNamed:@"goods_detaile_back_dowm"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//    [item setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    
    
    
    
    // 修改返回按钮样式
//    [item setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
//
//    
//
    UIColor *flatColor = [UIColor blackColor];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = flatColor;
    //    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    //    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
//
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] =  flatColor;
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 会有半透明效果，这个颜色会变成目标主题色。因为导航栏不能用不透明
//    UIColor *color = [UIColor colorWithRed:222.0f/255.0f green:11.0f/255.0f blue:50.0f/255.0f alpha:1];
    UIColor *color = [GzwThemeTool theme];
    // 设置bar的颜色
        navBar.barTintColor = color;
//    [navBar setBackgroundImage:[UIImage imageNamed:@"上导航bg"] forBarMetrics:UIBarMetricsDefault];// 背景图片
    UIColor *flatColor = ComplementaryFlatColor([GzwThemeTool theme]);
    // 设置状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = flatColor;
        textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:textAttrs];
    [navBar setTintColor:flatColor];
    

    
    // 下划线
//    [navBar setBackgroundImage:[[UIImage alloc] init]
//             forBarPosition:UIBarPositionAny
//                 barMetrics:UIBarMetricsDefault];
//    
//    [navBar setShadowImage:[[UIImage alloc] init]];
    
//    // 恢复
//    [navBar setBackgroundImage:nil
//                forBarPosition:UIBarPositionAny
//                    barMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:nil];
}



- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if (animated) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return  [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.interactivePopGestureRecognizer.enabled = NO;
    return [super popToViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    self.interactivePopGestureRecognizer.enabled = YES;
}
// 重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 导航栏都是盏管理的，如果盏里面的内容大于0，说明push了，
    if (self.viewControllers.count > 0) {
        // 把tabbar隐藏
        viewController.hidesBottomBarWhenPushed = YES;
    }
//    // 栈顶控制器push后需要移除手势
//    if (self.viewControllers.count >= 1) {
//        [self.view removeGestureRecognizer:self.pan];
//    }
    if (animated) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)showMenu
{
//    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
//    [self.frostedViewController panGestureRecognized:sender];
}
// 重写了pop，需要添加监听手势
-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 2) {// 回到盏顶控制器
        // 添加拖动手势监听
//        [self.view addGestureRecognizer:self.pan];
    }
    return [super popViewControllerAnimated:animated];
}

#pragma mark UIGestureRecognizerDelegate
// 根据需要是否是否开启拖动返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer
        && self.viewControllers.count < 2) {
        return NO;
    }
    return YES;
}

// 在push完成后从Nav中删除当前控制器
- (void)removeViewController:(UIViewController *)controller animated:(BOOL)flag
{
//    NSMutableArray<__kindof UIViewController *> *controllers = [self.viewControllers mutableCopy];
//    __block UIViewController *controllerToRemove = nil;
//    [controllers enumerateObjectsUsingBlock:^(__kindof UIViewController * obj, NSUInteger idx, BOOL * stop) {
//        if (RTSafeUnwrapViewController(obj) == controller) {
//            controllerToRemove = obj;
//            *stop = YES;
//        }
//    }];
//    if (controllerToRemove) {
//        [controllers removeObject:controllerToRemove];
//        [super setViewControllers:[NSArray arrayWithArray:controllers] animated:flag];
//    }
}
@end
