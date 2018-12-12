//
//  ViewController.m
//  CGContextRefDemo
//
//  Created by hongbaodai on 2018/12/10.
//  Copyright © 2018年 caomaoxiaozi. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CustomView *custom = [[CustomView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:custom];

    // Do any additional setup after loading the view, typically from a nib.
}










@end
