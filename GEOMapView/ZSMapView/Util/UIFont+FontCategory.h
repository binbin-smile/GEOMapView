//
//  UIFont+FontCategory.h
//  ZGZhishu
//
//  Created by lyb on 15/9/21.
//  Copyright (c) 2015年 Melvins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (FontCategory)

+ (UIFont *)generateFontWithSize5s:(CGFloat)size5s size6:(CGFloat)size6 size6p:(CGFloat)size6p;
+ (UIFont *)generateFontAutomaticallyWithSize6:(CGFloat)size6;

+ (UIFont *)generateBoldFontWithSize5s:(CGFloat)size5s size6:(CGFloat)size6 size6p:(CGFloat)size6p;
+ (UIFont *)generateBoldFontAutomaticallyWithSize6:(CGFloat)size6;

@end
