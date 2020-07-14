//
//  FJSportSportingViewController.m
//  黑马行
//
//  Created by Mac on 16/11/8.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSportSportingViewController.h"
#import "FJSportMapViewController.h"

@interface FJSportSportingViewController ()

//这里虽然是两个控制器，但是我将B设置成A的属性，并且强引用，即便页面跳转，这个属性也没有销毁，而B的初始化是在A的里面完成的
@property (nonatomic,strong) FJSportMapViewController *mapViewController;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;

@end

@implementation FJSportSportingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupMapViewController];
}

//当所有的子控件布局完成，然后再设置控件的位置
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    //重新设置罗盘的位置
    CGFloat x = _mapButton.center.x - _mapViewController.mapView.compassSize.width * 0.5;
    CGFloat y = _mapButton.center.y - _mapViewController.mapView.compassSize.width * 0.5;
    
    _mapViewController.mapView.compassOrigin = CGPointMake(x, y);
    
}

- (IBAction)showMapViewController
{
    [self presentViewController:_mapViewController animated:YES completion:nil];
}

//修改运动状态
- (IBAction)changeSportState:(UIButton *)button
{
    //修改地图控制器的运动状态
    _mapViewController.sportTracking.sportState = button.tag;
}

- (void)setupMapViewController
{
    //通过storyboard加载控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"FJSportView" bundle:nil];
    
    _mapViewController = [sb instantiateViewControllerWithIdentifier:@"sportMapViewController"];
    
    //设置运动的轨迹模型
    _mapViewController.sportTracking = [[FJSportTracking alloc] initWithType:_type state:FJSportStateContinue];
    
}

//设置个地图的控制器，搞成什么父子控制器
//现在不是父子控制器，设置成分开跳转的
//- (void)setupMapViewController
//{
//    // 1. 获取地图控制器
//    for (UIViewController *child in self.childViewControllers) {
//        if ([child isKindOfClass:[FJSportMapViewController class]]) {
//            _mapViewController = (FJSportMapViewController *)child;
//            
//            break;
//        }
//    }
//    
//    // 2. 设置运动轨迹模型
//    _mapViewController.sportTracking = [[FJSportTracking alloc] initWithType:_type state:FJSportStateContinue];
//}

@end
