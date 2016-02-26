//
//  ZSBaseCityInfo.m
//  ZGZhishu
//
//  Created by lyb on 15/12/4.
//  Copyright © 2015年 Melvins. All rights reserved.
//

#import "ZSBaseAddressInfo.h"

#import "ZSGeoDefine.h"

@implementation ZSBaseAddressInfo

- (CGPoint)transformToUIPointWithMapSize:(CGSize)mapSize
{
    CGPoint uiPoint = CGPointZero;
    
    double longitudeDistance = kRightLongitude-kLeftLongitude;
    double latitudeDistance = kTopLatitude-kBottomLatitude;
    uiPoint.x = mapSize.width*(_longitude-kLeftLongitude)/longitudeDistance;
    uiPoint.y = mapSize.height*(kTopLatitude-_latitude)/latitudeDistance;
    return uiPoint;
}

@end
