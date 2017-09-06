//
//  UIImage+MJ.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MJ)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
//修改image的大小

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

// 控件截屏
+ (UIImage *)imageWithCaputureView:(UIView *)view;
/**
 *  根据图片和颜色返回一张加深颜色以后的图片
 */
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;
/**
 *  为图片打水印
 *
 *  @param bgImage    背景图片
 *  @param imageView  打水印前的那个imageView
 *  @param text       水印文字
 *  @param attributes 文字属性
 *
 *  *****************************  示例代码  ***************************************
 *
 *  NSDictionary *attrs = @{
 *  NSFontAttributeName : [UIFont boldSystemFontOfSize:8],
 *  NSForegroundColorAttributeName : [UIColor whiteColor]
 *  };
 *  UIImage *lastImage = [UIImage waterImageWithBackgroundImage:[UIImage imageNamed:@"scene"] andText:@"大熊出品出品出品出品大熊出品出品出品出品大熊出品出品出品出品" andTextAttributes:attrs];
 
 *  // 输出到屏幕上
 *  _imgView.image = lastImage;
 *  *****************************  示例end  ***************************************
 */
+ (instancetype)waterImageWithBackgroundImage:(UIImage *)bgImage superView:(UIImageView *)imageView andText:(NSString *)text andTextAttributes:(NSDictionary *)attributes;

/**
 *  图片切割成圆形
 *
 *  @param name        图片名
 *  @param borderWidth 边界宽度
 *  @param borderColor 边界颜色
 *
 *  @return 切割好的图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  合并多张图片
 *
 *  @param header  <#header description#>
 *  @param content <#content description#>
 *  @param footer  <#footer description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)composeWithHeader:(UIImage *)header content:(UIImage *)content footer:(UIImage *)footer;
/**
 *  根据传入的宽度然后算出宽高比生成一张图片
 *
 *  @param width 指定宽度
 *
 *  @return 高保帧的小图
 */
-(UIImage *)imageWithScale:(CGFloat)width;
/**
 *  @brief  修正图片的方向
 *
 *  @param srcImg 图片
 *
 *  @return 修正方向后的图片
 */
+ (UIImage *)gzw_fixOrientation:(UIImage *)srcImg;
/**
 *  @brief  旋转图片
 *
 *  @param degrees 角度
 *
 *  @return 旋转后图片
 */
- (UIImage *)gzw_imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  @brief  旋转图片
 *
 *  @param degrees 弧度
 *
 *  @return 旋转后图片
 */
- (UIImage *)gzw_imageRotatedByRadians:(CGFloat)radians;

/**
 *  @brief  垂直翻转
 *
 *  @return  翻转后的图片
 */
- (UIImage *)gzw_flipVertical;
/**
 *  @brief  水平翻转
 *
 *  @return 翻转后的图片
 */
- (UIImage *)gzw_flipHorizontal;

/**
 *  @brief  角度转弧度
 *
 *  @param degrees 角度
 *
 *  @return 弧度
 */
+(CGFloat)gzw_degreesToRadians:(CGFloat)degrees;
/**
 *  @brief  弧度转角度
 *
 *  @param radians 弧度
 *
 *  @return 角度
 */
+(CGFloat)gzw_radiansToDegrees:(CGFloat)radians;
/**
 *  @brief  更改图片颜色，保持图片内容纹理不变
 *
 *  @param blendColor 颜色
 *
 *  @return 新的图片
 */
- (UIImage *)gzw_imageWithBlendColor:(UIColor *)blendColor;
// 改变图片线条颜色
- (UIImage *)gzw_imageWithColor:(UIColor *)color;
@end
