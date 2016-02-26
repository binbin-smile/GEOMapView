//
//  ZSProvinceGEOInfo.h
//  ZGZhishu
//
//  Created by lyb on 15/12/7.
//  Copyright © 2015年 Melvins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSProvinceGEOInfo : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tranform;
@property (nonatomic, strong) NSString *geoType;
@property (nonatomic, strong) UIBezierPath *path;

@end
