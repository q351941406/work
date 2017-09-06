//
//  UIWebView+Gzw.h
//  pjh365
//
//  Created by 嗨购 on 16/8/19.
//  Copyright © 2016年 bigkoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Gzw)
/// 获取某个标签的结点个数
- (int)gzw_nodeCountOfTag:(NSString *)tag;
/// 获取当前页面URL
- (NSString *)gzw_getCurrentURL;
/// 获取标题
- (NSString *)gzw_getTitle;
/// 获取图片
- (NSArray *)gzw_getImgs;
/// 获取当前页面所有链接
- (NSArray *)gzw_getOnClicks;
/// 为所有图片添加点击事件(网页中有些图片添加无效)
- (void)gzw_addClickEventOnImg;
/// 改变所有图像的宽度
- (void)gzw_setImgWidth:(int)size;
/// 改变所有图像的高度
- (void)gzw_setImgHeight:(int)size;
/// 改变指定标签的字体大小
- (void)gzw_setFontSize:(int) size withTag:(NSString *)tagName;
@end
