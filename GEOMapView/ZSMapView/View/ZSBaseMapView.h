//
//  ZSBaseMapView.h
//  ZGZhishu
//
//  Created by lyb on 15/12/7.
//  Copyright © 2015年 Melvins. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZSGEOParserManager.h"

@protocol ZSBaseMapViewDelegate <NSObject>

@optional
- (void)baseMapViewDidSelectProvince:(ZSProvinceGEOInfo *)provinceGEOInfo;

@end

@interface ZSBaseMapView : UIView

@property(strong, nonatomic) UIColor *fillColor;
@property(strong, nonatomic) UIColor *strokeColor;

// GEOJson 文件的解析类
@property(strong, nonatomic) ZSGEOParserManager *geoManager;

@property(assign, nonatomic) id <ZSBaseMapViewDelegate> delegate;

@end
