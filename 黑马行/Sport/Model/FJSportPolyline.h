//
//  FJSportPolyline.h
//  黑马行
//
//  Created by Mac on 16/11/11.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

/**
 自定义折线模型，增加颜色属性
 */
@interface FJSportPolyline : MAPolyline

+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color;

//增加一个颜色的属性
@property (nonatomic,strong) UIColor *color;

@end
