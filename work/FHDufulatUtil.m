//
//  FHDufulatUtil.m
//  HaiHuiTong
//
//  Created by 林海 on 16/12/15.
//  CopyrigFH © 2016年 zsq. All rigFHs reserved.
//



static NSString *UserInfoKeyByDefault = @"UserInfoKeyByDefault";

#import "FHDufulatUtil.h"

@implementation FHDufulatUtil

+ (instancetype)sharedInstance {
    
    static FHDufulatUtil *_defulatUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defulatUtil = [[FHDufulatUtil alloc] init];
    });
    return _defulatUtil;
}

-(void)setLisheng:(NSInteger )lisheng
{
    [[NSUserDefaults standardUserDefaults] setObject:@(lisheng) forKey:Liansheng];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setMaxCount:(NSInteger)maxCount
{
    [[NSUserDefaults standardUserDefaults] setObject:@(maxCount) forKey:MaxCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setShenglicount:(NSInteger)shenglicount
{
    [[NSUserDefaults standardUserDefaults] setObject:@(shenglicount) forKey:ShengliCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)shenglicount
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:ShengliCount] integerValue];
}

-(NSInteger)lisheng
{
   return [[[NSUserDefaults standardUserDefaults] objectForKey:Liansheng] integerValue];
}

-(NSInteger)maxCount
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:MaxCount] integerValue];
}


-(void)setBool:(BOOL)k indexkey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:k forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)getBoolWithKey:(NSString *)key
{
   return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


@end
