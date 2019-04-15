//
//  UIColor+BarChartView.h
//  Custom Chart
//
//  Created by Konstantin Mishukov on 11/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (BarChartView)

+(UIColor*)chartViewBackgroundColor;
+(UIColor*)chartFieldBackgroundColor;
+(UIColor*)colorForSeriesID:(NSNumber*)seriesID inSeriesArray:(NSArray*)serArray;

@end

NS_ASSUME_NONNULL_END
