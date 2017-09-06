//
//  UINavigationController+Gzw.m
//  pjh365
//
//  Created by 嗨购 on 16/8/19.
//  Copyright © 2016年 bigkoo. All rights reserved.
//

#import "UINavigationController+Gzw.h"

@implementation UINavigationController (Gzw)
- (NSArray *)gzw_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated
{
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}
@end
