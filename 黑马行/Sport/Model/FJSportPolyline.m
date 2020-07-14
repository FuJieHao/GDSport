//
//  FJSportPolyline.m
//  黑马行
//
//  Created by Mac on 16/11/11.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSportPolyline.h"

@implementation FJSportPolyline

+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color
{
    FJSportPolyline *polyline = [self polylineWithCoordinates:coords count:count];
    polyline.color = color;
    
    return polyline;
}

@end
