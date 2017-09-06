//
//  NSArray+Gzw.m
//  pjh365
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 bigkoo. All rights reserved.
//

#import "NSArray+Gzw.h"
#import "NSDictionary+Gzw.h"
@implementation NSArray (Gzw)
- (NSArray *)gzw_arrayByReplacingNullsWithBlanks  {
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object gzw_dictionaryByReplacingNullsWithStrings]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object gzw_arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}
- (NSMutableArray *)gzw_removeRepeat
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [self count]; i++){
        if ([categoryArray containsObject:[self objectAtIndex:i]] == NO){
            [categoryArray addObject:[self objectAtIndex:i]];
        }
        
    }
    return categoryArray;
}
@end
