//
//  FJSportMapViewController.h
//  黑马行
//
//  Created by Mac on 16/11/8.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSportTracking.h"

@interface FJSportMapViewController : UIViewController

//本次运动轨迹的追踪模型
@property (nonatomic,strong) FJSportTracking *sportTracking;

@property (nonatomic,weak,readonly) MAMapView *mapView;

@end
