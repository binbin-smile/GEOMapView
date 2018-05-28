//
//  ViewController.m
//  GEOMapView
//
//  Created by lyb on 16/2/26.
//  Copyright © 2016年 lyb. All rights reserved.
//

#import "ViewController.h"

#import "ZSBaseMapView.h"

@interface ViewController () <ZSBaseMapViewDelegate>
{
    UILabel *_tipLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 100, 50)];
    [self.view addSubview:_tipLabel];
    
    ZSBaseMapView *mapView = [[ZSBaseMapView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    mapView.center = self.view.center;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZSBaseMapViewDelegate

- (void)baseMapViewDidSelectProvince:(ZSProvinceGEOInfo *)provinceGEOInfo
{
    _tipLabel.text = provinceGEOInfo.name;
}

@end
