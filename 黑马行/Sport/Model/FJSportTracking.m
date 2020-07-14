//
//  FJSportTracking.m
//  黑马行
//
//  Created by Mac on 16/11/8.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSportTracking.h"

//
@implementation FJSportTracking
{
    //起始点的位置
    CLLocation *_startLocation;
    
    //所有运动线条的模型数组
    NSMutableArray <FJSportingTrackingLine *> *_trackingLines;
}

- (CLLocation *)sportStartLocation
{
    //返回运动轨迹数组中，第一个线条的起点
    return _trackingLines.firstObject.startLocation;
}

- (instancetype)initWithType:(FJSportType)type state:(FJSportState)state
{
    if (self = [super init]) {
        self.sportType = type;
        self.sportState = state;
        _trackingLines = [NSMutableArray array];
    }
    return self;
}

//如果不是继续状态的话，需要清空起始点
- (void)setSportState:(FJSportState)sportState
{
    
    _sportState = sportState;
    
    if (_sportState != FJSportStateContinue) {
        _startLocation = nil;
    }
}

- (UIImage *)sportImage
{
    UIImage *image;
    switch (self.sportType) {
        case FJSportTypeRun:
            image = [UIImage imageNamed:@"map_annotation_run"];
            break;
        case FJSportTypeWalk:
            image = [UIImage imageNamed:@"map_annotation_walk"];
            break;
        case FJSportTypeBike:
            image = [UIImage imageNamed:@"map_annotation_bike"];
            break;
    }
    
    return image;
}

- (MAPolyline *)appendLocation:(CLLocation *)location
{
    //判断速度是否发生变化 - 性能优化，在室内定位的话，速度有可能为负数
    if (location.speed <= 0) {
        return nil;
    }
    
    //判断是否存在起始点
    if (_startLocation == nil) {
        _startLocation = location;
        
        return nil;
    }
    
    //否则的话，创建追踪线条模型
    FJSportingTrackingLine *trackLine = [[FJSportingTrackingLine alloc] initWithStartLocation:_startLocation endLocation:location];
    
    [_trackingLines addObject:trackLine];
    
    NSLog(@"%f - %f - %f - %f", self.avgSpeed, self.maxSpeed, self.totalTime, self.totalDistance);
    
    //将当前位置设置成下一次的起点
    _startLocation = location;
    
    //返回折线模型
    return trackLine.polyLine;
}

- (double)avgSpeed
{
    return [[_trackingLines valueForKeyPath:@"@avg.speed"] doubleValue];
}

- (double)maxSpeed {
    return [[_trackingLines valueForKeyPath:@"@max.speed"] doubleValue];
}

- (double)totalTime {
    return [[_trackingLines valueForKeyPath:@"@sum.time"] doubleValue];
}

- (double)totalDistance {
    return [[_trackingLines valueForKeyPath:@"@sum.distance"] doubleValue];
}

@end
