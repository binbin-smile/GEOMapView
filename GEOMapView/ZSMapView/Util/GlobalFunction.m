//
//  GlobalFunction.m
//  ZGZhishu
//
//  Created by lyb on 15/9/22.
//  Copyright (c) 2015年 Melvins. All rights reserved.
//

#import "GlobalFunction.h"

BOOL IsEmptyString(NSString *string)
{
    return string == nil  || [string isKindOfClass:[NSNull class]] || string.length == 0;
}

BOOL IsEmptyArray(NSArray *array)
{
    if (!array || [array isKindOfClass:[NSNull class]] || array.count <= 0) {
        return YES;
    } else {
        return NO;
    }
}

NSString *JSONStringFromDictionary(NSDictionary *parameters)
{
    NSError *error = nil;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];;
    
    if (!error) {
        return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

id JSONObjectFromString(NSString* string)
{
    if (!string || [string isKindOfClass:[NSNull class]] || string.length <= 0) {
        return nil;
    }
    NSError * error = nil;
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id ret = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    return ret;
    
}

#pragma mark - Date

NSDate *NSDateWithDateString(NSString *dateString, NSString *dateFormat)
{
    if (!dateFormat || dateFormat == NULL) {
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

NSString *StringWithNSDateAndDateFormat(NSDate *date, NSString *dateFormat)
{
    if (dateFormat == NULL) {
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

// APP版本
NSString *ApplicationVersion()
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//判断是不是今年的时间
BOOL isCurrentLocalYear(NSDate *date)
{
    NSString *dateString = StringWithNSDateAndDateFormat(date, @"yyyy-MM-dd");
    NSString *localDateString = StringWithNSDateAndDateFormat([NSDate date], @"yyyy-MM-dd");
    NSString * dateYear = [[dateString componentsSeparatedByString:@"-"] firstObject];
    NSString * localdateYear = [[localDateString componentsSeparatedByString:@"-"] firstObject];
    return [dateYear isEqualToString:localdateYear];
    
}
//时间判断
 NSString *StringConversionWithNSDate(NSDate *date)
{
    NSString *dateString = StringWithNSDateAndDateFormat(date, @"yyyy-MM-dd");
    NSString *localDateString = StringWithNSDateAndDateFormat([NSDate date], @"yyyy-MM-dd");
    
    if ([localDateString isEqualToString:dateString])
    {
        dateString = @"10:00";
    }
    else
    {
        if (isCurrentLocalYear(date))
        {
            dateString = [dateString substringFromIndex:5];
        }
    }
    return dateString;
}

#pragma mark - Color Generate

UIColor *UIColorWithHexValue(uint hexValue,float alpha)
{
    return [UIColor
            colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
            green:((float)((hexValue & 0xFF00) >> 8))/255.0
            blue:((float)(hexValue & 0xFF))/255.0
            alpha:alpha];
}

UIColor *UIColorWithHex(NSString *hexStr, float alpha)
{
    if (hexStr == nil || (id)hexStr == [NSNull null]) {
        return nil;
    }
    else{
        UIColor *color;
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
        
        uint hexValue;
        if ([[NSScanner scannerWithString:hexStr] scanHexInt:&hexValue]) {
            color = UIColorWithHexValue(hexValue, alpha);
        }
        else {
            // invalid hex string
            color = [UIColor clearColor];
        }
        return color;
    }
}

