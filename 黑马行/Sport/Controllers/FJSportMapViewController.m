//
//  FJSportMapViewController.m
//  黑马行
//
//  Created by Mac on 16/11/8.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSportMapViewController.h"

#import <MAMapKit/MAMapKit.h> //那个高德的框架

@interface FJSportMapViewController () <MAMapViewDelegate>

@end

@implementation FJSportMapViewController {
    //是否设置了起始的大头针
    BOOL _hasSetStartLocation;
    //起始点
    CLLocation *_firstLocation;
}

- (IBAction)back:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)GPSStateSelect:(UIButton *)sender
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self setupMapView];
}

#pragma mark - MAMapViewDelegate
/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据) 是一个固定的对象
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
//位置或者设备方向更新后，会调用此函数
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //判断位置是否变化(YES:location数据更新 NO:heading数据更新）
    //做个判断的呗，过滤掉一些不必要的操作
    if (!updatingLocation) {
        return;
    }
    
    //判断运动状态，只有继续才需要绘制运动轨迹
    if (_sportTracking.sportState != FJSportStateContinue) {
        return;
    }
    
    //将用户位置设置在地图视图的中心点
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    
    
    //这里原来的设置是如果没有起始点的情况下，我设置起始点的位置为大头针
    //但是在所有的地图的框架中，在最开始定位的时候，会有偏差
    //所以要判断起始位置是否存在
    //初始化大头针
    
    if (!_hasSetStartLocation && _sportTracking.sportStartLocation != nil) {
        
        _hasSetStartLocation = YES;
        
        //实例化大头针
        MAPointAnnotation *annotation = [MAPointAnnotation new];
        
        //指定大头针坐标位置 = 用户所在的位置
        annotation.coordinate = userLocation.location.coordinate;
        
        //添加到地图视图
        [mapView addAnnotation:annotation];
    }
    
    //绘制轨迹模型
    [mapView addOverlay:[_sportTracking appendLocation:userLocation.location]];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //判断大头针的类型（从这里看的话，有两点，那个蓝点也算一个MAPointAnnotation，你的大头针会和他混淆，所以进行一下区分)
    if (![annotation isKindOfClass:[MAPointAnnotation class]]) {
        return nil;
    }
    
    //否则的话创建大头针视图
    static NSString *annotationId = @"annotationId";
    
    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationId];
    
    //如果没有找到可以重用的大头针视图的话
    if (annotationView == nil) {
        //这个里面的annotation是个数据，是上面的代理方法，大头针模型的位置信息
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationId];
    }
    
    annotationView.image = self.sportTracking.sportImage;
    
    //设置大头针的偏移
    annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height * 0.5);
    
    return annotationView;
}

/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度(点击位置的）
 */
//这个方法依旧相对于模型
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    
    //开始画线
    //1.建立结构体的数组
    CLLocationCoordinate2D coords[2];
    
    coords[0] = coordinate;
    //起始点的位置
    coords[1] = _firstLocation.coordinate;
    
    //2.构造折线对象 @param coords 经纬度坐标数据,coords对应的内存会拷贝,调用者负责该内存的释放
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:2];
    
    //3.添加到地图
    [mapView addOverlay:polyline];
}

/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay (overlay:覆盖)
 * @return 生成的覆盖物Renderer
 */
//要想将绘制的线显示在屏幕上，需要实现代理方法-mapView:rendererForOverlay:
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    //类似于大头针的方法，该方法的overlay也不全是你的折线，所以要做判断
    if (![overlay isKindOfClass:[MAPolyline class]]) {
        return nil;
    }
    
    //实例化折线渲染器
    FJSportPolyline *polyline = (FJSportPolyline *)overlay;
    MAPolylineRenderer *render = [[MAPolylineRenderer alloc] initWithPolyline:polyline];
    
    //设置一些显示的属性
    render.lineWidth = 5;
    render.strokeColor = polyline.color;
    
    return render;
}



//设置一哈地图的视图
- (void)setupMapView
{
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    //因为要显示点计数器之类的东西，所以直接添加的话盖住那个东西，用插入的方式，将地图视图放在控制器的最底层
    [self.view insertSubview:mapView atIndex:0];
    
    _mapView = mapView;
    
    //1.显示用户的位置
    mapView.showsUserLocation = YES;
    
    //2.设置用户追踪模式 - 会将用户的位置显示在屏幕中间，3D地图会自动显示成放大的样式
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    //3.隐藏比例尺
    mapView.showsScale = NO;
    
    //4.禁止相机旋转
    mapView.rotateCameraEnabled = NO;
    
    //5.允许后台跟踪
    mapView.allowsBackgroundLocationUpdates = YES;
    
    //6.不允许系统自动暂停
    mapView.pausesLocationUpdatesAutomatically = NO;
    
    //7.设置个代理
    mapView.delegate = self;
}

@end
