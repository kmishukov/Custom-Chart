//
//  BarChartView.m
//  Custom Chart
//
//  Created by Konstantin Mishukov on 11/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "BarChartView.h"
#import "../Categories/UIColor+BarChartView.h"
#import "../Views/SeriesCell.h"
#import "../Views/PeriodsCell.h"

@implementation BarChartView

// Data
NSDictionary *dictionary;
NSArray *series;
NSArray *periods;
double periodMaxValue;

// Views
UIView *chartFieldView;
UIView *topSubview;
UILabel *titleLabel;
UILabel *subtitleLabel;
UICollectionView *topCollectionView;
UICollectionView *bottomCollectionView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor chartViewBackgroundColor];
        [self addChartField];
        [self addTopSubview];
        [self addTopSubviewLabels];
        [self addTopCollectionView];
        [self addBottomCollectionView];
    }
    return self;
}

// Method That Builds UIView
- (void)configureWithData:(NSDictionary *)data {
    dictionary = data;
    series = dictionary[@"series"];
    periods = dictionary[@"periods"];
    for (int i=0; i < [periods count]; i++) {
        NSNumber *totalValue = periods[i][@"fBarTotalValue"];
        if ([totalValue doubleValue] > periodMaxValue) {
            periodMaxValue = [totalValue doubleValue];
        }
    }
    NSString *sWidgetName = dictionary[@"sWidgetName"] != nil ? dictionary[@"sWidgetName"] : @"???";
    NSString *sMeasureName = dictionary[@"sMeasureName"] != nil ? dictionary[@"sMeasureName"] : @"???";
    titleLabel.text = sWidgetName;
    subtitleLabel.text = sMeasureName;
    [self layoutIfNeeded];
}

// Прямоугольник с закругленными углами;
-(void)addChartField {
    chartFieldView = [UIView new];
    chartFieldView.backgroundColor = [UIColor chartFieldBackgroundColor];
    chartFieldView.layer.cornerRadius = 15;
    chartFieldView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: chartFieldView];
    [chartFieldView.topAnchor constraintEqualToAnchor: self.topAnchor constant: 20].active = YES;
    [chartFieldView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -20].active = YES;
    [chartFieldView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 20].active = YES;
    [chartFieldView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant: -20].active = YES;
}

// Вспомогательное View для топ лейблов;
-(void)addTopSubview{
    topSubview = [UIView new];
    topSubview.translatesAutoresizingMaskIntoConstraints = NO;
    [chartFieldView addSubview:topSubview];
    [topSubview.topAnchor constraintEqualToAnchor: chartFieldView.topAnchor constant: 20].active = YES;
    CGFloat leadingOffset = 0.05196402877 * [UIScreen mainScreen].bounds.size.width;
    [topSubview.leadingAnchor constraintEqualToAnchor: chartFieldView.leadingAnchor constant: leadingOffset].active = YES;
    [topSubview.trailingAnchor constraintEqualToAnchor: chartFieldView.trailingAnchor constant: -20].active = YES;
    CGFloat heightRelation = 0.150; // Отношение высоты topSubview к высоте chartField;
    [topSubview.heightAnchor constraintEqualToAnchor: chartFieldView.heightAnchor multiplier: heightRelation].active = YES;
    // topSubview.backgroundColor = [UIColor yellowColor];
}

// Тайтл и сабтайтл;
-(void)addTopSubviewLabels {
    titleLabel = [UILabel new];
    CGFloat fontSize = 50;
    titleLabel.font = [UIFont systemFontOfSize: fontSize];
    titleLabel.numberOfLines = 1;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumScaleFactor = 0.1;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [topSubview addSubview: titleLabel];
    [titleLabel.topAnchor constraintEqualToAnchor: topSubview.topAnchor constant: 0].active = YES;
    [titleLabel.leadingAnchor constraintEqualToAnchor: topSubview.leadingAnchor constant: 0].active = YES;
    [titleLabel setContentHuggingPriority: UILayoutPriorityDefaultHigh forAxis: UILayoutConstraintAxisHorizontal];
    [titleLabel setContentCompressionResistancePriority: UILayoutPriorityDefaultLow forAxis: UILayoutConstraintAxisHorizontal];
    [titleLabel.bottomAnchor constraintLessThanOrEqualToAnchor: topSubview.centerYAnchor constant: 0].active = YES;
    // titleLabel.backgroundColor = [UIColor redColor]; // UITest

    subtitleLabel = [UILabel new];
    subtitleLabel.font = [UIFont systemFontOfSize: (titleLabel.font.pointSize - 10)];
    subtitleLabel.numberOfLines = 1;
    subtitleLabel.adjustsFontSizeToFitWidth = YES;
    subtitleLabel.minimumScaleFactor = 0.01;
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.textColor = [UIColor whiteColor];
    subtitleLabel.alpha = 0.5;
    [topSubview addSubview: subtitleLabel];
    [subtitleLabel.centerYAnchor constraintEqualToAnchor: titleLabel.centerYAnchor].active = YES;
    CGFloat spacingOffset = (0.05196402877 * [UIScreen mainScreen].bounds.size.width) / 3;
    [subtitleLabel.leadingAnchor constraintEqualToAnchor: titleLabel.trailingAnchor constant: spacingOffset].active = YES;
    [subtitleLabel.trailingAnchor constraintLessThanOrEqualToAnchor: topSubview.trailingAnchor constant: -5].active = YES;
    [subtitleLabel setContentCompressionResistancePriority: UILayoutPriorityDefaultHigh forAxis: UILayoutConstraintAxisHorizontal];
    [subtitleLabel setContentHuggingPriority: UILayoutPriorityDefaultLow forAxis: UILayoutConstraintAxisHorizontal];
    [subtitleLabel.widthAnchor constraintEqualToAnchor: titleLabel.widthAnchor multiplier: 0.20].active = YES;
    // subtitleLabel.backgroundColor = [UIColor greenColor]; // UITest
}

-(void)addTopCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    topCollectionView = [[UICollectionView alloc]
                         initWithFrame: CGRectMake(50, 50, topSubview.frame.size.width, topSubview.frame.size.height / 2)
                         collectionViewLayout: flowLayout ];
    [topCollectionView registerClass: SeriesCell.class forCellWithReuseIdentifier: @"topCollectionViewCell"];
    topCollectionView.delegate = self;
    topCollectionView.dataSource = self;
    topCollectionView.backgroundColor = [UIColor clearColor]; // UITest
    topCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [topSubview addSubview: topCollectionView];
    [topCollectionView.heightAnchor constraintEqualToAnchor: topSubview.heightAnchor multiplier: 0.5].active = YES;
    [topCollectionView.leadingAnchor constraintEqualToAnchor: topSubview.leadingAnchor].active = YES;
    [topCollectionView.trailingAnchor constraintEqualToAnchor: topSubview.trailingAnchor].active = YES;
    [topCollectionView.bottomAnchor constraintEqualToAnchor: topSubview.bottomAnchor].active = YES;
}

// MARK: CollectionView Delegates & Datasource;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==topCollectionView) {
        SeriesCell *cell = [topCollectionView dequeueReusableCellWithReuseIdentifier: @"topCollectionViewCell" forIndexPath: indexPath];
        NSString *title = series[indexPath.row][@"sName"] != nil ? series[indexPath.row][@"sName"] : @"???";
        NSDictionary *colorDict = series[indexPath.row][@"color"];
        [cell configureCellwithTitle: title andColor: colorDict];
        return cell;
    } else if (collectionView == bottomCollectionView) {
        PeriodsCell *cell = [bottomCollectionView dequeueReusableCellWithReuseIdentifier: @"bottomCollectionViewCell" forIndexPath: indexPath];
        NSDictionary *periodData = periods[indexPath.row];
        [cell configureWithData: periodData maxValue: periodMaxValue seriesArray: series];
        return cell;
    } else {
        return nil;
    }
};

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == topCollectionView) {
        return [series count];
    } else if (collectionView == bottomCollectionView) {
        return [periods count];
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    if (collectionView == topCollectionView || collectionView == bottomCollectionView) {
        return 1;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==bottomCollectionView) {
        NSLog(@"frameSize.Width: %f, frameSize.Height: %f", collectionView.frame.size.width / 4.0, collectionView.frame.size.height);
        return CGSizeMake(collectionView.frame.size.width / 4.0, collectionView.frame.size.height);
    } else {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
    }
}

// MARK: BottomCollectionView Setup
-(void)addBottomCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    
    bottomCollectionView = [[UICollectionView alloc]
                         initWithFrame: CGRectMake(50, 50, 0, 0)
                         collectionViewLayout: flowLayout];
    
    [bottomCollectionView registerClass: PeriodsCell.class forCellWithReuseIdentifier: @"bottomCollectionViewCell"];
    bottomCollectionView.delegate = self;
    bottomCollectionView.dataSource = self;
    bottomCollectionView.backgroundColor = [UIColor clearColor]; // UITest
    bottomCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [chartFieldView addSubview: bottomCollectionView];
    [bottomCollectionView.topAnchor constraintEqualToAnchor: topSubview.bottomAnchor constant: 10].active = YES;
    [bottomCollectionView.leftAnchor constraintEqualToAnchor: chartFieldView.leftAnchor constant: 20].active = YES;
    [bottomCollectionView.rightAnchor constraintEqualToAnchor: chartFieldView.rightAnchor constant: -20].active = YES;
    [bottomCollectionView.bottomAnchor constraintEqualToAnchor: chartFieldView.bottomAnchor constant: -50].active = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [bottomCollectionView.collectionViewLayout invalidateLayout];
//        [bottomCollectionView invalidateIntrinsicContentSize];
//        [bottomCollectionView reloadData];
//    });
   
}






@end
