//
//  FJSportTracking.h
//  黑马行
//
//  Created by Mac on 16/11/8.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSportingTrackingLine.h"

///运动类型判断的枚举
typedef enum {
    
    FJSportTypeRun,
    FJSportTypeWalk,
    FJSportTypeBike
    
}FJSportType;

/// 运动状态枚举
typedef enum : NSUInteger {
    FJSportStatePause,
    FJSportStateContinue,
    FJSportStateFinish,
} FJSportState;

@interface FJSportTracking : NSObject

//实例化的时候传入运动模型类型
- (instancetype)initWithType:(FJSportType)type state:(FJSportState)state;

//运动的起始点
@property (nonatomic,readonly) CLLocation *sportStartLocation;

//运动的类型
@property (nonatomic,assign) FJSportType sportType;

//运动状态
@property (nonatomic,assign) FJSportState sportState;

//运动的图像
@property (nonatomic,strong) UIImage *sportImage;

/**
 通过拼接各个点，返回折线模型
 */
- (MAPolyline *)appendLocation:(CLLocation *)location;

/**
 平均速度
 */
@property (nonatomic,readonly) double avgSpeed;

/**
 最大速度
 */
@property (nonatomic,readonly) double maxSpeed;

/**
 总时长
 */
@property (nonatomic,readonly) double totalTime;

/**
 总距离
 */
@property (nonatomic,readonly) double totalDistance;

@end
