//
//  ViewController.m
//  黑马行
//
//  Created by Mac on 16/11/8.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSportMainViewController.h"
#import "FJSportTracking.h"

#import "FJSportSportingViewController.h"

@interface FJSportMainViewController ()

@end

@implementation FJSportMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

///运动的三个按钮
- (IBAction)startSport:(UIButton *)sender
{
    //根据按钮的类型来确定运动的类型
    FJSportType type = (int)sender.tag;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"FJSportView" bundle:nil];
    
    FJSportSportingViewController *vc = sb.instantiateInitialViewController;
    
    vc.type = type;
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
