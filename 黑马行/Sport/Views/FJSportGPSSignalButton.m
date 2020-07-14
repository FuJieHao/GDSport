//
//  HMSportGPSSignalButton.m
//  黑马行
//
//  Created by on 2016/9/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSportGPSSignalButton.h"
#import "FJSportTracking.h"

@implementation FJSportGPSSignalButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gpsChanged:) name:HMSportGPSSignalChangedNotification object:nil];
}

- (void)dealloc {
    // 注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)gpsChanged:(NSNotification *)notification {
    
    // 1. 从通知中获取 GPS 强度信号
    FJSportGPSSignalState state = [notification.object integerValue];
    
//    NSLog(@"信号强度 %zd", state);
    // 2. 根据 state 设置按钮的图像和标题
    NSString *imageName = (_isMapButton) ? @"ic_sport_gps_map_" : @"ic_sport_gps_";
    NSString *title;
    
    switch (state) {
        case FJSportGPSSignalStateDisconnect:
            title = @"  GPS已经断开";
            imageName = [imageName stringByAppendingString:@"disconnect"];
            break;
        case FJSportGPSSignalStateBad:
            title = @"  请绕开高楼大厦";
            imageName = [imageName stringByAppendingString:@"connect_1"];
            break;
        case FJSportGPSSignalStateNormal:
            imageName = [imageName stringByAppendingString:@"connect_2"];
            break;
        case FJSportGPSSignalStateGood:
            imageName = [imageName stringByAppendingString:@"connect_3"];
            break;
    }
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    // 根据是否存在标题设置右侧的内容间距
    UIEdgeInsets insets = self.contentEdgeInsets;
    insets.right = (title == nil) ? 4 : 8;
    self.contentEdgeInsets = insets;
}

@end
