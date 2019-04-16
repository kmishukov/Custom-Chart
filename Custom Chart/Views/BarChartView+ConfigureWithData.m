//
//  BarChartView+ConfigureWithData.m
//  Custom Chart
//
//  Created by Konstantin Mishukov on 15/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "BarChartView+ConfigureWithData.h"

@implementation BarChartView (ConfigureWithData)

// Method That Builds UIView
- (void)configureWithData:(NSDictionary *)data {
    self.dictionary = data;
    self.series = self.dictionary[@"series"];
    self.periods = self.dictionary[@"periods"];
    for (int i=0; i < [self.periods count]; i++) {
        NSNumber *totalValue = self.periods[i][@"fBarTotalValue"];
        if ([totalValue doubleValue] > self.periodMaxValue) {
            self.periodMaxValue = [totalValue doubleValue];
        }
    }
    NSString *sWidgetName = (self.dictionary[@"sWidgetName"] != nil) ? self.dictionary[@"sWidgetName"] : @"???";
    NSString *sMeasureName = (self.dictionary[@"sMeasureName"] != nil) ? self.dictionary[@"sMeasureName"] : @"???";
    self.titleLabel.text = sWidgetName;
    self.subtitleLabel.text = sMeasureName;
    [self layoutIfNeeded];
}

@end
