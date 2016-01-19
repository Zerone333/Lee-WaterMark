//
//  UIImage+Mark.m
//  WSCloudBoardPartner
//
//  Created by MrChens on 8/1/2016.
//  Copyright © 2016 Lee. All rights reserved.
//

#import "UIImage+Mark.h"
#import <CoreText/CoreText.h>

@implementation UIImage (Mark)
+(UIImage *)markImageWithOriginImage:(UIImage *)originImage markTextStr:(NSString *)markTextStr
{
    
    //1.获取上下文
    UIGraphicsBeginImageContext(originImage.size);
    //2.绘制图片
    [originImage drawInRect:CGRectMake(0, 0, originImage.size.width, originImage.size.height)];
    //3.绘制水印文字
    CGRect rect = CGRectMake(0, originImage.size.height-20, originImage.size.width, 20);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    
    //文字的属性
    NSDictionary *dic = @{
                          
                          NSFontAttributeName:[UIFont systemFontOfSize:13],
                          
                          NSParagraphStyleAttributeName:style,
                          
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          
                          };
    
    //将文字绘制上去
    [markTextStr drawInRect:rect withAttributes:dic];
    
    //4.获取绘制到得图片
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //5.结束图片的绘制
    
    UIGraphicsEndImageContext();
    
    return watermarkImage;
    
}

+(UIImage *)markImageWithOriginImage:(UIImage *)originImage logoImage:(UIImage *)logoImage
{
    UIGraphicsBeginImageContext(originImage.size);
    [originImage drawInRect:CGRectMake(0, 0, originImage.size.width, originImage.size.height)];
    [logoImage drawInRect:CGRectMake(0, originImage.size.height-logoImage.size.height, logoImage.size.width, logoImage.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)markImageWithText:(NSString *)text image:(UIImage *)image
{
    //get image width and height
    int w = image.size.width;
    int h = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1);
    
    
    //    // Prepare font
    CGFloat s = 20 * w / 400.f;
    CTFontRef ctfont = CTFontCreateWithName(CFSTR("STHeitiSC-Medium"), s, NULL);
    CGColorRef ctColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.3] CGColor];
    
    // Create an attributed string
    CFStringRef keys[] = { kCTFontAttributeName,kCTForegroundColorAttributeName };
    CFTypeRef values[] = { ctfont,ctColor};
    CFDictionaryRef attr = CFDictionaryCreate(NULL, (const void **)&keys, (const void **)&values,
                                              
                                              sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    CFStringRef ctStr = CFStringCreateWithCString(nil, [text UTF8String], kCFStringEncodingUTF8);
    
    CFAttributedStringRef attrString = CFAttributedStringCreate(NULL,ctStr, attr);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, text.length), attr, CGSizeMake(MAXFLOAT, MAXFLOAT), NULL);
    
    
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    
    CGContextRotateCTM(context, M_PI_4);
    
    
    CGFloat inset = size.width + 40.f * w / 400.f;
    CGSize imageSize = image.size;
    CGFloat startX = - inset;
    CGFloat startY = - inset;
    
    for (int i = 0 ;  startY < imageSize.height;  i ++) {
        CGContextSetTextPosition(context, startX, startY);
        startY += inset;
        for (int j = 0;  startX < imageSize.width ; ++j) {
            startX += inset;
            CGContextSetTextPosition(context, startX * cos(M_PI_4) + startY * sin(M_PI_4), startY * cos(M_PI_4) - startX * sin(M_PI_4));
            CTLineDraw(line, context);
            
        }
        startX = -inset;
        
        NSLog(@"%d", i);
    }
    
    /**
     *  坐标变化 x' = x * cos + y * sin
     *          y' = y * cos - x * sin
     */
    
    CFRelease(line);
    CFRelease(attrString);
    CFRelease(ctStr);
    CFRelease(framesetter);
    // Clean up
    CFRelease(attr);
    CFRelease(ctfont);
    
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

@end
