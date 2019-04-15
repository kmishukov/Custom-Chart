//
//  BarChartView.h
//  Custom Chart
//
//  Created by Konstantin Mishukov on 11/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Categories/UIColor+BarChart.h"
#import "../Views/SeriesCell.h"
#import "../Views/PeriodsCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BarChartView : UIView

// Data
@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong, nonatomic) NSArray *series;
@property (strong, nonatomic) NSArray *periods;
@property double periodMaxValue;

// Views
@property (strong,nonatomic) UICollectionView *topCollectionView;
@property (strong,nonatomic) UICollectionView *bottomCollectionView;

// Labels
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *subtitleLabel;

@end

NS_ASSUME_NONNULL_END
