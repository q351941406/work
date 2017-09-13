//
//  UIWindow+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MyTabBarController.h"


@implementation UIWindow (Extension)
- (void)switchRootViewController
{
    

        
  
            
            self.rootViewController = [[MyTabBarController alloc] init];
}
        

@end

