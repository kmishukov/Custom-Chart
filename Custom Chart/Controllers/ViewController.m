//
//  ViewController.m
//  Custom Chart
//
//  Created by Konstantin Mishukov on 11/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "ViewController.h"
#import "../Views/BarChartView.h"

@interface ViewController ()
@property (strong,nonatomic) BarChartView *barChartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *myDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource: @"MockData" ofType: @"plist"]];
    [self createBarChartView];
    [_barChartView configureWithData: myDict];
}

// Create BarChartView + Constraints
-(void)createBarChartView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    _barChartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _barChartView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: _barChartView];
    [_barChartView.topAnchor constraintEqualToAnchor: self.view.topAnchor].active = YES;
    [_barChartView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor].active = YES;
    [_barChartView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor ].active = YES;
    [_barChartView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor ].active = YES;
};

@end
