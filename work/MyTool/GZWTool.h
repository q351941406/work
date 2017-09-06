#import "Singleton.h"// 单例
#import "UIBarButtonItem+MJ.h"
#import "UIColor+WNXColor.h"
#import "UIImage+Gzw.h"
#import "UIView+Extension.h"
#import "NSDate+GZW.h"
#import "NSData+Gzw.h"
//#import "MJExtension.h"
#import "UITextField+Gzw.h"
#import "UILabel+Extended.h"
#import "GzwRegexTool.h"// 正则表达式
#import "SecurityStrategy.h"// 后台模糊
#import "UIImage+BlurGlass.h"
#import "NSString+Gzw.h"
#import "UIButton+Gzw.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
//#import "UINavigationItem+Loading.h"// 导航栏item加载状态
#import "UIImage+GzwColor.h"
#import "NSDictionary+Gzw.h"
#import "NSArray+Gzw.h"
#import "NSObject+Gzw.h"
#import "UIImage+ImageEffects.h"
// block里面用的弱self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define Gzw_WeakSelf(type)  __weak typeof(type) weak##type = type;
#define Gzw_StrongSelf(type)  __strong typeof(type) type = weak##type;
// 屏幕的宽高
#define ViewW [UIScreen mainScreen].bounds.size.width
#define viewH [UIScreen mainScreen].bounds.size.height
#define Screen_Width   [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

#define GZWColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]// RGB颜色
#define GZWColorWithAlpha(r, g, b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]// RGB颜色和透明度
#define Gzw_systemSeparatorColor [UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1]// 系统分割线颜色
#define Gzw_systemBackgroundColor [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:244.0f/255.0f alpha:1]// 系统的背景颜色
#define Gzw_RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]// 随机色
