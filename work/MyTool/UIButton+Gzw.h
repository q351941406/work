//
//  UIButton+Gzw.h
//  跑腿
//
//  Created by sky33 on 16/1/18.
//  Copyright © 2016年 paotui. All rights reserved.
//  防止按钮连续点击

#import <UIKit/UIKit.h>

@interface UIButton (Gzw)
/**
 *  重复点击加间隔
 */
@property (nonatomic, assign) NSTimeInterval gzw_acceptEventInterval;
/**
 *  标示是否可点
 */
@property (nonatomic, assign) BOOL gzw_ignoreEvent;

@end
