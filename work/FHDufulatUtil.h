//
//  HTDufulatUtil.h
//  HaiHuiTong
//
//  Created by 林海 on 16/12/15.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHUser.h"
#import "ConfigModel.h"

@interface FHDufulatUtil : NSObject

@property (nonatomic,strong) BmobObject *bmObject;

@property (nonatomic,strong) ConfigModel *config;
/**
 解锁
 */
@property (nonatomic,assign) BOOL network;


@property (nonatomic,assign) NSInteger maxCount;

@property (nonatomic,assign) NSInteger lisheng;

@property (nonatomic,assign) NSInteger shenglicount;

@property (nonatomic,copy) NSString *goAppstoreTime;

/**
 单例模式，实例化对象
 */
+ (instancetype)sharedInstance;

-(void)setBool:(BOOL)k indexkey:(NSString *)key;

-(BOOL)getBoolWithKey:(NSString *)key;





@end
