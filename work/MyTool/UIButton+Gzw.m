//
//  UIButton+Gzw.m
//  跑腿
//
//  Created by sky33 on 16/1/18.
//  Copyright © 2016年 paotui. All rights reserved.
//

#import "UIButton+Gzw.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIcontrol_ignoreEvent = "UIcontrol_ignoreEvent";
@implementation UIButton (Gzw)
- (NSTimeInterval)gzw_acceptEventInterval
{
    //    id temp = objc_getAssociatedObject(self, UIControl_acceptEventInterval);
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}
- (void)setGzw_acceptEventInterval:(NSTimeInterval)gzw_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(gzw_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)gzw_ignoreEvent {
    return [objc_getAssociatedObject(self, UIcontrol_ignoreEvent) boolValue];
}
- (void)setGzw_ignoreEvent:(BOOL)gzw_ignoreEvent {
    objc_setAssociatedObject(self, UIcontrol_ignoreEvent, @(gzw_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//load方法会在类第一次加载的时候被调用
//调用的时间比较靠前，适合在这个方法里做方法交换
+ (void)load{
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(sendAction:to:forEvent:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(swiz_gzw_sendAction:to:forEvent:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}
-(void)swiz_gzw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
//    if (self.gzw_acceptEventInterval <= 0) {// 默认给定一些
//        self.gzw_acceptEventInterval = 0.01f;
//    }
//    
//    // 延迟设为NO之后，这个判断就不会成立了
//    if (self.gzw_ignoreEvent) return;
//    
//    if (self.gzw_acceptEventInterval > 0) {
//        self.gzw_ignoreEvent = YES;
//        // 多少秒之后存为NO
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.gzw_acceptEventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.gzw_ignoreEvent = NO;
//        });
//    }
    // 看起来是死循环，其实方法已经被交换了，调系统的方法
    [self swiz_gzw_sendAction:action to:target forEvent:event];
}

@end
