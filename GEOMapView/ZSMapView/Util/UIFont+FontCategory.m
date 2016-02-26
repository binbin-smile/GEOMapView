//
//  UIFont+FontCategory.m
//  ZGZhishu
//
//  Created by lyb on 15/9/21.
//  Copyright (c) 2015年 Melvins. All rights reserved.
//

#import "UIFont+FontCategory.h"

@implementation UIFont (FontCategory)

+ (UIFont *)generateFontWithSize5s:(CGFloat)size5s size6:(CGFloat)size6 size6p:(CGFloat)size6p
{
    if (isIPHONE5 || PrIPHONE5 || PrIPAD) {
        return [UIFont systemFontOfSize:size5s];
    } else if (isIPHONE6) {
        return [UIFont systemFontOfSize:size6];
    } else {
        return [UIFont systemFontOfSize:size6p];
    }
}

+ (UIFont *)generateFontAutomaticallyWithSize6:(CGFloat)size6
{
    if (isIPHONE5 || PrIPHONE5 || PrIPAD) {
        return [UIFont systemFontOfSize:size6-1];
    } else if (isIPHONE6) {
        return [UIFont systemFontOfSize:size6];
    } else {
        return [UIFont systemFontOfSize:size6+1];
    }
}

+ (UIFont *)generateBoldFontWithSize5s:(CGFloat)size5s size6:(CGFloat)size6 size6p:(CGFloat)size6p
{
    if (isIPHONE5 || PrIPHONE5 || PrIPAD) {
        return [UIFont boldSystemFontOfSize:size5s];
    } else if (isIPHONE6) {
        return [UIFont boldSystemFontOfSize:size6];
    } else {
        return [UIFont boldSystemFontOfSize:size6p];
    }
}

+ (UIFont *)generateBoldFontAutomaticallyWithSize6:(CGFloat)size6
{
    if (isIPHONE5 || PrIPHONE5 || PrIPAD) {
        return [UIFont boldSystemFontOfSize:size6-1];
    } else if (isIPHONE6) {
        return [UIFont boldSystemFontOfSize:size6];
    } else {
        return [UIFont boldSystemFontOfSize:size6+1];
    }
}

@end
