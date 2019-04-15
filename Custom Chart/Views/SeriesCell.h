//
//  SeriesCollectionViewCell.h
//  Custom Chart
//
//  Created by Konstantin Mishukov on 13/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeriesCell : UICollectionViewCell
-(void)configureCellwithTitle:(NSString*)title andColor:(NSDictionary*)colorDict;
@end

NS_ASSUME_NONNULL_END
