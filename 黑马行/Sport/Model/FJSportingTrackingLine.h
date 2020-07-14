//
//  FJSportingTrackingLine.h
//  黑马行
//
//  Created by Mac on 16/11/11.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJSportPolyline.h"

/**
 轨迹追踪线条模型，记录起始点和结束点
 */
@interface FJSportingTrackingLine : NSObject

@property (nonatomic ,strong ,readonly) CLLocation *startLocation;
@property (nonatomic ,strong ,readonly) CLLocation *endLocation;

//描述起始点和结束点之间的折线模型
@property (nonatomic,readonly) FJSportPolyline *polyLine;

//起始点和结束点之间的平均速度，单位是“公路/小时"
@property (nonatomic,readonly) double speed;

//起始点和结束点之间的时间差值，单位/秒
@property (nonatomic,readonly) NSTimeInterval time;

//起始点和结束点之间的距离，单位：公里
@property (nonatomic,readonly) double distance;

/**
 使用起始点和结束点，实例化线条模型
 */
- (instancetype)initWithStartLocation:(CLLocation *)startLoction endLocation:(CLLocation *)endLocation;

@end
