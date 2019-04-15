//
//  PeriodsCell.h
//  Custom Chart
//
//  Created by Konstantin Mishukov on 14/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Categories/UIColor+BarChart.h"

NS_ASSUME_NONNULL_BEGIN

@interface PeriodsCell : UICollectionViewCell 
-(void)configureWithData:(NSDictionary*)periodData maxValue:(double)maxValue seriesArray:(NSArray*)serArray;
@end

NS_ASSUME_NONNULL_END
