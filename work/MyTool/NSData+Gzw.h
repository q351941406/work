//
//  NSData+Gzw.h
//  跑腿
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 paotui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface NSData (Gzw)
/**
 *  将音频、图片转成base64Binary
 *
 *  @param data 二进制数据
 *  
 NSData * data = [[NSData alloc]initWithContentsOfURL:filepath];
 NSData * base64Data = [self base64Encoded:data];
 NSString * strBase64 = [[NSString alloc]initWithData:base64Data encoding:NSASCIIStringEncoding];
 *  @return <#return value description#>
 */
+(NSData *)base64Encoded:(NSData *)data;
/**
 *  @brief  将APNS NSData类型token 格式化成字符串
 *
 *  @return 整理过后的字符串token
 */
- (NSString *)gzw_APNSToken;
/**
 *  拼接 wav data
 *
 *  @param self   raw audio data
 *  @param pcmFormat format of pcm
 *
 *  @return wav data
 */
- (NSData *)jk_wavDataWithPCMFormat:(AudioStreamBasicDescription)PCMFormat;
@end
