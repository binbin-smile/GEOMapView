//
//  ZSGEOParserManager.m
//  ZGZhishu
//
//  Created by lyb on 15/12/7.
//  Copyright © 2015年 Melvins. All rights reserved.
//

#import "ZSGEOParserManager.h"

@interface ZSGEOParserManager ()

@property(assign, nonatomic) CGFloat leftLongitude;
@property(assign, nonatomic) CGFloat rightLongitude;
@property(assign, nonatomic) CGFloat topLatitude;
@property(assign, nonatomic) CGFloat bottomLatitude;

@end

@implementation ZSGEOParserManager

- (id)init
{
    self = [super init];
    if (self) {
        
        _provinceGEOArray = [NSMutableArray array];
        
        _bounds = CGRectMake(kLeftLongitude, kBottomLatitude, kLongitudeDistance, kLatitudeDistance);
    }
    return self;
}

- (void)loadMapDataWithFilePath:(NSString *)mapPath completion:(void (^ __nullable)(void))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *error = nil;
        NSString *geoJsonString = [[NSString alloc] initWithContentsOfFile:mapPath encoding:NSUTF8StringEncoding error:&error];
        NSDictionary *geoDic = JSONObjectFromString(geoJsonString);
        [self parserGeoArray:geoDic[@"features"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    });
    
}

- (void)parserGeoArray:(NSArray *)geoArray
{
    if (IsEmptyArray(geoArray)) {
        return;
    }
    
    // 该方法只在更换 china_geo.json 文件后调用一次，计算出当前地图的最大和最小经纬度，手动赋值给该类.h 文件中的相对应的宏定义
//    [self computeFirstProvinceBounds:geoArray];
    
    for (NSDictionary *provinceDic in geoArray) {
        
        ZSProvinceGEOInfo *provinceGeoInfo = [[ZSProvinceGEOInfo alloc] init];
        
        provinceGeoInfo.identifier = [[[provinceDic objectForKey:@"properties"] objectForKey:@"id"] stringValue];
        provinceGeoInfo.name = [[provinceDic objectForKey:@"properties"] objectForKey:@"name"];
        provinceGeoInfo.geoType = [[provinceDic objectForKey:@"geometry"] objectForKey:@"type"];
        NSArray *coordinateArray = [[provinceDic objectForKey:@"geometry"] objectForKey:@"coordinates"];
        
        // MultiPolygon 与 Polygon 区分
        if ([provinceGeoInfo.geoType isEqualToString:@"Polygon"]) {
            // 单个多边形
            provinceGeoInfo.path = [self pathForCoordinateArray:coordinateArray];
            
        } else if ([provinceGeoInfo.geoType isEqualToString:@"MultiPolygon"]) {
            // 内部带孔的多边形
            provinceGeoInfo.path = [self pathForMultiPolygonCoordinateArray:coordinateArray];
        }
        
        [_provinceGEOArray addObject:provinceGeoInfo];
    }
    
    // 该方法只在更换 china_geo.json 文件后调用一次，计算出当前地图的最大和最小经纬度，手动赋值给该类.h 文件中的相对应的宏定义
//    [self printfBounds];
}

#pragma mark - 内部辅助性方法

- (UIBezierPath *)pathForCoordinateArray:(NSArray *)coordinateArray
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 获取内层坐标数组
    NSArray *innerCoordinateArray = [coordinateArray firstObject];
    
    for (int i = 0; i < innerCoordinateArray.count; i++) {
        NSArray *coordinate = innerCoordinateArray[i];
        CGFloat longitude = [[coordinate firstObject] floatValue];
        CGFloat latitude = [[coordinate lastObject] floatValue];
        
        // 该方法只在更换 china_geo.json 文件后调用一次，计算出当前地图的最大和最小经纬度，手动赋值给该类.h 文件中的相对应的宏定义
//        [self updateRectValueWithLatitude:latitude andLongitude:longitude];
        
        CGPoint point = CGPointMake(longitude - kLeftLongitude, kTopLatitude - latitude);
        
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
    }
    [path closePath];
    
    return path;
}

- (UIBezierPath *)pathForMultiPolygonCoordinateArray:(NSArray *)coordinateArray
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 获取内层坐标数组
    
    for (NSArray *innerCoordinateArray in coordinateArray) {
        
        NSArray *tempCoordinateArray = [innerCoordinateArray firstObject];
        UIBezierPath *childPath = [UIBezierPath bezierPath];
        
        for (int i = 0; i < tempCoordinateArray.count; i++) {
            NSArray *coordinate = tempCoordinateArray[i];
            CGFloat longitude = [[coordinate firstObject] floatValue];
            CGFloat latitude = [[coordinate lastObject] floatValue];
            
            // 该方法只在更换 china_geo.json 文件后调用一次，计算出当前地图的最大和最小经纬度，手动赋值给该类.h 文件中的相对应的宏定义
            //        [self updateRectValueWithLatitude:latitude andLongitude:longitude];
            
            CGPoint point = CGPointMake(longitude - kLeftLongitude, kTopLatitude - latitude);
            
            if (i == 0) {
                [childPath moveToPoint:point];
            } else {
                [childPath addLineToPoint:point];
            }
        }
        [childPath closePath];
        [path appendPath:childPath];
    }
    
    return path;
}

#pragma mark - 获取GEOJson的经纬度范围等数据

- (void)printfBounds
{
    NSLog(@"left ::  %lf", _leftLongitude);
    NSLog(@"right :: %lf", _rightLongitude);
    NSLog(@"top :: %lf", _topLatitude);
    NSLog(@"bottom :: %lf", _bottomLatitude);
}

- (void)updateRectValueWithLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude
{
    // 以下判断仅适合东半球、北半球的经纬度范围的计算
    
    if (longitude < _leftLongitude) {
        _leftLongitude = longitude;
    }
    if (longitude > _rightLongitude) {
        _rightLongitude = longitude;
    }
    if (latitude < _bottomLatitude) {
        _bottomLatitude = latitude;
    }
    if (latitude > _topLatitude) {
        _topLatitude = latitude;
    }
}

- (void)computeFirstProvinceBounds:(NSArray *)provinceGeoArray
{
    NSDictionary *firstProvinceDic = [provinceGeoArray firstObject];
    NSArray *coordinateArray = [[firstProvinceDic objectForKey:@"geometry"] objectForKey:@"coordinates"];
    NSString *geoType = [[firstProvinceDic objectForKey:@"geometry"] objectForKey:@"type"];
    
    NSArray *innerCoordinateArray = [NSArray array];
    
    // MultiPolygon 与 Polygon 区分
    if ([geoType isEqualToString:@"Polygon"]) {
        // 单个多边形
        innerCoordinateArray = [coordinateArray firstObject];
        
    } else if ([geoType isEqualToString:@"MultiPolygon"]) {
        // 内部带孔的多边形
        innerCoordinateArray = [[coordinateArray firstObject] lastObject];
    }
    
    NSArray *coordinate = [innerCoordinateArray firstObject];
    CGFloat longitude = [[coordinate firstObject] floatValue];   // 获取维度
    CGFloat latitude = [[coordinate lastObject] floatValue];   // 获取经度
    
    _leftLongitude = longitude;
    _rightLongitude = longitude;
    _topLatitude = latitude;
    _bottomLatitude = latitude;
}

#pragma mark - Tool Method

+ (CGPoint)tranformCoordinateToCGPointWithLongitude:(double)longitude
                                           latitude:(double)latitude
                                              scale:(float)scale
{
    return CGPointMake((longitude-kLeftLongitude)*scale,
                       (kTopLatitude - latitude)*scale*kLongitudeLatitudeRatio);
}

@end
