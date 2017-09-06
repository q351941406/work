//
//  NSArray+Gzw.h
//  pjh365
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 bigkoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Gzw)
/**
 *  替换<null>的键值为@""
 *
 *  @return 替换完成的数组
 */
- (NSArray *)gzw_arrayByReplacingNullsWithBlanks;
/**
 *  去数组内的重复元素
 */
- (NSMutableArray *)gzw_removeRepeat;
@end
