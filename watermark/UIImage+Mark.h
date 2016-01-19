//
//  UIImage+Mark.h
//  WSCloudBoardPartner
//
//  Created by MrChens on 8/1/2016.
//  Copyright © 2016 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Mark)
/**
 *  添加文字水印（不支持中文）
 *
 *  @param originImage 图片
 *  @param markTextStr 文本
 *
 *  @return 文本＋图片
 */
+(UIImage *)markImageWithOriginImage:(UIImage *)originImage markTextStr:(NSString *)markTextStr;

/**
 *  添加图片水印
 *
 *  @param originImage 图片
 *  @param logoImage   logo
 *
 *  @return logo水印＋图片
 */
+(UIImage *)markImageWithOriginImage:(UIImage *)originImage logoImage:(UIImage *)logoImage;

/**
 *  添加文字水印
 *
 *  @param text  水印文字
 *  @param image 图片
 *
 *  @return 水印＋图片
 */
+ (UIImage *)markImageWithText:(NSString *)text image:(UIImage *)image;

@end
