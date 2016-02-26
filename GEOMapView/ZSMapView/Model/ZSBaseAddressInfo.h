//
//  ZSBaseCityInfo.h
//  ZGZhishu
//
//  Created by lyb on 15/12/4.
//  Copyright © 2015年 Melvins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSBaseAddressInfo : NSObject

@property(strong, nonatomic) NSString *addressId;
@property(strong, nonatomic) NSString *addressName;
@property(assign, nonatomic) double latitude;
@property(assign, nonatomic) double longitude;
@property(assign, nonatomic) BOOL isNeedExtendLine;
@property(assign, nonatomic) double extendLatitude;
@property(assign, nonatomic) double extendLongitude;

- (CGPoint)transformToUIPointWithMapSize:(CGSize)mapSize;

@end
