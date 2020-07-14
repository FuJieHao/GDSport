//
//  FJSportingTrackingLine.m
//  黑马行
//
//  Created by Mac on 16/11/11.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSportingTrackingLine.h"

@implementation FJSportingTrackingLine

- (instancetype)initWithStartLocation:(CLLocation *)startLoction endLocation:(CLLocation *)endLocation
{
    if (self = [super init]) {
        
        _startLocation = startLoction;
        _endLocation = endLocation;
    }
    
    return self;
}

- (double)speed
{
    return (_startLocation.speed + _endLocation.speed) * 0.5 * 3.6;
}

- (NSTimeInterval)time
{
    
    //timestamp 时间戳
    return [_endLocation.timestamp timeIntervalSinceDate:_startLocation.timestamp];
}

- (double)distance
{
    return [_endLocation distanceFromLocation:_startLocation] * 0.001;
}

- (FJSportPolyline *)polyLine
{
    CLLocationCoordinate2D coords[2];
    
    coords[0] = _startLocation.coordinate;
    coords[1] = _endLocation.coordinate;
    
    //设置放大的比例因子
    CGFloat factor = 4;
    
    //设置颜色
    CGFloat green = 1 - factor * self.speed / 255.0;
    
    UIColor *color = [UIColor colorWithRed:1 green:green blue:0 alpha:1.0];
    
    NSLog(@"速度 %f 时间 %f 距离 %f", self.speed, self.time, self.distance);
    
    return [FJSportPolyline polylineWithCoordinates:coords count:2 color:color];
}

@end
