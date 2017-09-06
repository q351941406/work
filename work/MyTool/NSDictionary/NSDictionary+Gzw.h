//
//  NSDictionary+Gzw.h
//  pjh365
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 bigkoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Gzw)
/**
 *  替换<null>的键值为@""
 *
 *  @return 替换完成的字典
 */
- (NSDictionary *)gzw_dictionaryByReplacingNullsWithStrings;
/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)gzw_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)gzw_dictionaryByMergingWith:(NSDictionary *)dict;
@end
