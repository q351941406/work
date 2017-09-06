//
//  ConfigModel.h
//  work
//
//  Created by 林海 on 17/8/21.
//  Copyright © 2017年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigModel : UIButton
/**
 基础提现金额
 **/
@property (nonatomic,assign) NSInteger baseExchange;
/**
 最小提现金额
 **/
@property (nonatomic,assign) NSInteger minExchange;
/**
 兑换比例
 **/
@property (nonatomic,assign) NSInteger exchangeCount;
/**
 是否审核
 **/
@property (nonatomic,assign) BOOL examine;
/**
 游戏按钮是否允许跳转到到App Store
 **/
@property (nonatomic,assign) BOOL gameGoAppstore;
/**
 兑换说明
 **/
@property (nonatomic,copy) NSString *duihuanDes;

@end
