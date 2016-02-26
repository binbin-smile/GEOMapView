//
//  ViewController.m
//  GEOMapView
//
//  Created by lyb on 16/2/26.
//  Copyright © 2016年 lyb. All rights reserved.
//

#import "ViewController.h"

#import "ZSBaseMapView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZSBaseMapView *mapView = [[ZSBaseMapView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    mapView.center = self.view.center;
    [self.view addSubview:mapView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
