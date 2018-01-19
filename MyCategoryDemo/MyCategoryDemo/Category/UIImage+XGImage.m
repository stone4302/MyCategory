//
//  UIImage+XGImage.m
//  install-app-IOS
//
//  Created by pengbingxiang on 2017/8/9.
//  Copyright © 2017年 YWX. All rights reserved.
//

#import "UIImage+XGImage.h"

@implementation UIImage (XGImage)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    // 获取位图上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, color.CGColor);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - 虚线
+ (UIImage *)imaginaryLineWithColor:(UIColor*)color ImageView:(UIImageView *)imageView {
    CGFloat width = imageView.frame.size.width;
    CGFloat height = imageView.frame.size.height;
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, width, height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {2,1};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    CGContextSetLineDash(line, 0, lengths, 1);
    CGContextMoveToPoint(line, 0, 1);
    CGContextAddLineToPoint(line, width, 1);
    CGContextStrokePath(line);
    return  UIGraphicsGetImageFromCurrentImageContext();
}
@end
