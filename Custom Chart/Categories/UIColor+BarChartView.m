//
//  UIColor+BarChartView.m
//  Custom Chart
//
//  Created by Konstantin Mishukov on 11/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "UIColor+BarChartView.h"

@implementation UIColor (BarChartView)

+(UIColor*)chartViewBackgroundColor {
    UIColor *color = [UIColor colorWithRed: 26.0f/255.0f green: 35.0f/255.0f blue: 43.0f/255.0f alpha: 1];
    return color;
};

+(UIColor*)chartFieldBackgroundColor {
    UIColor *color = [UIColor colorWithRed:37.0f/255.0f green:46.0f/255.0f blue:54.0f/255.0f alpha: 1];
    return color;
};

+(UIColor*)colorForSeriesID:(NSNumber*)seriesID inSeriesArray:(NSArray*)serArray  {
    for (int i=0; i<[serArray count];i++) {
        if (serArray[i][@"nID"] == seriesID) {
            CGFloat red = serArray[i][@"color"][@"r"] != nil ? [serArray[i][@"color"][@"r"] doubleValue] : 0;
            CGFloat green = serArray[i][@"color"][@"g"] != nil ? [serArray[i][@"color"][@"g"] doubleValue] : 0;
            CGFloat blue = serArray[i][@"color"][@"b"] != nil ? [serArray[i][@"color"][@"b"] doubleValue]: 0;
            return [UIColor colorWithRed: red/255.0f green: green/255.0f blue: blue/255.0f alpha: 1];
        }
    }
    return [UIColor whiteColor];
}

@end
