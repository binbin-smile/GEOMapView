//
//  ZSBaseMapView.m
//  ZGZhishu
//
//  Created by lyb on 15/12/7.
//  Copyright © 2015年 Melvins. All rights reserved.
//

#import "ZSBaseMapView.h"

#import "ZSMapShapeLayer.h"

@interface ZSBaseMapView ()

@property(weak, nonatomic) ZSMapShapeLayer *lastSeletedLayer;

- (ZSMapShapeLayer *)getMapShapeLayerWithID:(NSString *)layerID;

@end

@implementation ZSBaseMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _strokeColor = [UIColor blackColor];
        _fillColor = [UIColor yellowColor];
        
        _geoManager = [[ZSGEOParserManager alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"china_geo" ofType:@"json"];
        [_geoManager loadMapDataWithFilePath:path completion:^{
            [self drawMap];
        }];
    }
    return self;
}

#pragma mark - Setup UI

- (void)drawMap
{
    for (ZSProvinceGEOInfo *provinceGeoPath in _geoManager.provinceGEOArray) {
        
        float scaleHorizontal = self.frame.size.width / kLongitudeDistance;
        float scaleVertical = self.frame.size.height / kLatitudeDistance;
        float scale = MIN(scaleHorizontal, scaleVertical);
        
        CGAffineTransform scaleTransform = CGAffineTransformIdentity;
        scaleTransform = CGAffineTransformMakeScale(scale, scale*kLongitudeLatitudeRatio);
        [provinceGeoPath.path applyTransform:scaleTransform];
        
        ZSMapShapeLayer *shapeLayer = [ZSMapShapeLayer layer];
        shapeLayer.ID = provinceGeoPath.identifier;
        shapeLayer.path = provinceGeoPath.path.CGPath;
        
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = _strokeColor.CGColor;
        shapeLayer.fillColor = _fillColor.CGColor;
        shapeLayer.lineWidth = 0.3;
        
        [self.layer addSublayer:shapeLayer];
    }
}

#pragma mark - Inner Method

- (ZSMapShapeLayer *)getMapShapeLayerWithID:(NSString *)layerID
{
    for (ZSMapShapeLayer *layer in self.layer.sublayers) {
        if ([layerID isEqualToString:layer.ID]) {
            return layer;
        }
    }
    return nil;
}

#pragma mark - Touch Handler

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    ZSMapShapeLayer *selectedLayer = nil;
    ZSProvinceGEOInfo *selectedProvinceGEOInfo = nil;
    
    for (ZSProvinceGEOInfo *provinceGeoInfo in _geoManager.provinceGEOArray) {
        if ([provinceGeoInfo.path containsPoint:touchPoint]) {
            NSLog(@"touched :: %@", provinceGeoInfo.name);
            selectedLayer = [self getMapShapeLayerWithID:provinceGeoInfo.identifier];
            selectedProvinceGEOInfo = provinceGeoInfo;
            break;
        }
    }
    if (!selectedLayer || selectedLayer == _lastSeletedLayer) {
        return;
    }
    
    selectedLayer.fillColor = [UIColor greenColor].CGColor;
    if (_lastSeletedLayer) {
        _lastSeletedLayer.fillColor = _fillColor.CGColor;
    }
    _lastSeletedLayer = selectedLayer;
    
    if (_delegate && [_delegate respondsToSelector:@selector(baseMapViewDidSelectProvince:)]) {
        [_delegate baseMapViewDidSelectProvince:selectedProvinceGEOInfo];
    }
}


@end
