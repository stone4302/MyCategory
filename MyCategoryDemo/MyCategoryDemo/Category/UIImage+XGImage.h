//
//  UIImage+XGImage.h
//  install-app-IOS
//
//  Created by pengbingxiang on 2017/8/9.
//  Copyright © 2017年 YWX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XGImage)

// 根据颜色创建image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 虚线
+ (UIImage *)imaginaryLineWithColor:(UIColor*)color ImageView:(UIImageView *)imageView;

@end
