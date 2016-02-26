//
//  CALayer+Category.m
//  KindergartenAssistant
//
//  Created by SKD_YiBin on 14/12/23.
//  Copyright (c) 2014年 SKD. All rights reserved.
//

#import "CALayer+Category.h"

@implementation CALayer (Category)

- (void)setBorderUIColor:(UIColor *)borderUIColor
{
    self.borderColor = borderUIColor.CGColor;
}

@end


@implementation UIView (BoardCategory)

- (void)addDefaultBoard
{
    self.layer.cornerRadius = 2;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1].CGColor;
}

- (void)clipToRound
{
    CGFloat w = CGRectGetWidth(self.frame);
    self.layer.cornerRadius = w/2;
}

@end


@implementation UIControl (BoardCategory)

- (void)addDefaultBoard
{
    self.layer.cornerRadius = 2;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1].CGColor;
}

- (void)clipToRound
{
    CGFloat w = CGRectGetWidth(self.frame);
    self.layer.cornerRadius = w/2;
}


@end