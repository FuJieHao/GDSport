//
//  HMSportGPSSignalButton.h
//  黑马行
//
//  Created by  on 2016/9/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 GPS信号强度提示按钮
 
 IB_DESIGNABLE 表示该视图可以在 IB 中设置属性
 */
IB_DESIGNABLE
@interface FJSportGPSSignalButton : UIButton

/**
 是否地图界面按钮
 */
@property (nonatomic, assign) IBInspectable BOOL isMapButton;

@end
