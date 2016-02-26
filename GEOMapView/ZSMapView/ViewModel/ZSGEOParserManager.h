//
//  ZSGEOParserManager.h
//  ZGZhishu
//
//  Created by lyb on 15/12/7.
//  Copyright © 2015年 Melvins. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZSProvinceGEOInfo.h"
#import "ZSGeoDefine.h"

@interface ZSGEOParserManager : NSObject

@property(strong, nonatomic) NSMutableArray *provinceGEOArray;
@property(nonatomic) CGRect bounds;

- (void)loadMapDataWithFilePath:(NSString *)mapPath completion:(void (^ __nullable)(void))completion;

+ (CGPoint)tranformCoordinateToCGPointWithLongitude:(double)longitude
                                           latitude:(double)latitude
                                              scale:(float)scale;

@end
