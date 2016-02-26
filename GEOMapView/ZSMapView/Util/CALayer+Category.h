//
//  CALayer+Category.h
//  KindergartenAssistant
//
//  Created by SKD_YiBin on 14/12/23.
//  Copyright (c) 2014年 SKD. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Category)

- (void)setBorderUIColor:(UIColor *)borderUIColor;

@end

@interface UIView (BoardCategory)

- (void)addDefaultBoard;
- (void)clipToRound;


@end


@interface UIControl (BoardCategory)

- (void)addDefaultBoard;
- (void)clipToRound;

@end