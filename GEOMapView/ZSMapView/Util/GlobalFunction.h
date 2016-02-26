//
//  GlobalFunction.h
//  ZGZhishu
//
//  Created by lyb on 15/9/22.
//  Copyright (c) 2015年 Melvins. All rights reserved.
//

#import <Foundation/Foundation.h>

// 判空
extern BOOL IsEmptyString(NSString *string);
extern BOOL IsEmptyArray(NSArray *array);

// Json 解析
extern NSString *JSONStringFromDictionary(NSDictionary *parameters);
extern id JSONObjectFromString(NSString* string);

// NSDate 格式处理
extern NSDate *NSDateWithDateString(NSString *dateString, NSString *dateFormat);
extern NSString *StringWithNSDateAndDateFormat(NSDate *date, NSString *dateFormat);

/**
 *  获取APP版本号
 *  @return version
 */
extern NSString *ApplicationVersion();

/**
 *  判断时间转化（是不是今天时间及显示的字符串），今天显示为10：00，昨天的显示具体日期；超过一年显示去年具体时间日期
 */
extern NSString *StringConversionWithNSDate(NSDate *date);

/**
 *  通过十六进制色值获取UIColor
 *  @param hexStr 十六进制字符串
 *  @param alpha  alpha
 *  @return UIColor
 */
extern UIColor *UIColorWithHex(NSString *hexStr, float alpha);