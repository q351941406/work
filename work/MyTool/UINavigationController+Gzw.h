//
//  UINavigationController+Gzw.h
//  pjh365
//
//  Created by 嗨购 on 16/8/19.
//  Copyright © 2016年 bigkoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Gzw)
/**
 *  @brief  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)gzw_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;
@end
