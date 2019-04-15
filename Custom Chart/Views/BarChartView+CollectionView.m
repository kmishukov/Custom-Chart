//
//  BarChartView+CollectionView.m
//  Custom Chart
//
//  Created by Konstantin Mishukov on 15/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "BarChartView+CollectionView.h"

@implementation BarChartView (CollectionView)

// MARK: CollectionView Delegates & Datasource;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==self.topCollectionView) {
        SeriesCell *cell = [self.topCollectionView dequeueReusableCellWithReuseIdentifier: @"topCollectionViewCell" forIndexPath: indexPath];
        NSString *title = self.series[indexPath.row][@"sName"] != nil ? self.series[indexPath.row][@"sName"] : @"???";
        NSDictionary *colorDict = self.series[indexPath.row][@"color"];
        [cell configureCellwithTitle: title andColor: colorDict];
        return cell;
    } else if (collectionView == self.bottomCollectionView) {
        PeriodsCell *cell = [self.bottomCollectionView dequeueReusableCellWithReuseIdentifier: @"bottomCollectionViewCell" forIndexPath: indexPath];
        NSDictionary *periodData = self.periods[indexPath.row];
        [cell configureWithData: periodData maxValue: self.periodMaxValue seriesArray: self.series];
        return cell;
    } else {
        return nil;
    }
};

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.topCollectionView) {
        return [self.series count];
    } else if (collectionView == self.bottomCollectionView) {
        return [self.periods count];
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    if (collectionView == self.topCollectionView || collectionView == self.bottomCollectionView) {
        return 1;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==self.bottomCollectionView) {
        NSLog(@"frameSize.Width: %f, frameSize.Height: %f", collectionView.frame.size.width / 4.0, collectionView.frame.size.height);
        return CGSizeMake(collectionView.frame.size.width / 4.0, collectionView.frame.size.height);
    } else {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
    }
}
@end
