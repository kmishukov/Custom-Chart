//
//  BarChartView.m
//  Custom Chart
//
//  Created by Konstantin Mishukov on 11/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "BarChartView.h"


@implementation BarChartView

// Views
UIView *chartFieldView;
UIView *topSubview;

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
    _titleLabel = [UILabel new];
    CGFloat fontSize = 50;
    _titleLabel.font = [UIFont systemFontOfSize: fontSize];
    _titleLabel.numberOfLines = 1;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.minimumScaleFactor = 0.1;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [topSubview addSubview: _titleLabel];
    [_titleLabel.topAnchor constraintEqualToAnchor: topSubview.topAnchor constant: 0].active = YES;
    [_titleLabel.leadingAnchor constraintEqualToAnchor: topSubview.leadingAnchor constant: 0].active = YES;
    [_titleLabel setContentHuggingPriority: UILayoutPriorityDefaultHigh forAxis: UILayoutConstraintAxisHorizontal];
    [_titleLabel setContentCompressionResistancePriority: UILayoutPriorityDefaultLow forAxis: UILayoutConstraintAxisHorizontal];
    [_titleLabel.bottomAnchor constraintLessThanOrEqualToAnchor: topSubview.centerYAnchor constant: 0].active = YES;
    // titleLabel.backgroundColor = [UIColor redColor]; // UITest

    _subtitleLabel = [UILabel new];
    _subtitleLabel.font = [UIFont systemFontOfSize: (_titleLabel.font.pointSize - 10)];
    _subtitleLabel.numberOfLines = 1;
    _subtitleLabel.adjustsFontSizeToFitWidth = YES;
    _subtitleLabel.minimumScaleFactor = 0.01;
    _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _subtitleLabel.textColor = [UIColor whiteColor];
    _subtitleLabel.alpha = 0.5;
    [topSubview addSubview: _subtitleLabel];
    [_subtitleLabel.centerYAnchor constraintEqualToAnchor: _titleLabel.centerYAnchor].active = YES;
    CGFloat spacingOffset = (0.05196402877 * [UIScreen mainScreen].bounds.size.width) / 3;
    [_subtitleLabel.leadingAnchor constraintEqualToAnchor: _titleLabel.trailingAnchor constant: spacingOffset].active = YES;
    [_subtitleLabel.trailingAnchor constraintLessThanOrEqualToAnchor: topSubview.trailingAnchor constant: -5].active = YES;
    [_subtitleLabel setContentCompressionResistancePriority: UILayoutPriorityDefaultHigh forAxis: UILayoutConstraintAxisHorizontal];
    [_subtitleLabel setContentHuggingPriority: UILayoutPriorityDefaultLow forAxis: UILayoutConstraintAxisHorizontal];
    [_subtitleLabel.widthAnchor constraintEqualToAnchor: _titleLabel.widthAnchor multiplier: 0.20].active = YES;
    // subtitleLabel.backgroundColor = [UIColor greenColor]; // UITest
}

-(void)addTopCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    _topCollectionView = [[UICollectionView alloc]
                         initWithFrame: CGRectMake(50, 50, topSubview.frame.size.width, topSubview.frame.size.height / 2)
                         collectionViewLayout: flowLayout ];
    [_topCollectionView registerClass: SeriesCell.class forCellWithReuseIdentifier: @"topCollectionViewCell"];
    _topCollectionView.delegate = self;
    _topCollectionView.dataSource = self;
    _topCollectionView.backgroundColor = [UIColor clearColor]; // UITest
    _topCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [topSubview addSubview: _topCollectionView];
    [_topCollectionView.heightAnchor constraintEqualToAnchor: topSubview.heightAnchor multiplier: 0.5].active = YES;
    [_topCollectionView.leadingAnchor constraintEqualToAnchor: topSubview.leadingAnchor].active = YES;
    [_topCollectionView.trailingAnchor constraintEqualToAnchor: topSubview.trailingAnchor].active = YES;
    [_topCollectionView.bottomAnchor constraintEqualToAnchor: topSubview.bottomAnchor].active = YES;
}



// MARK: BottomCollectionView Setup
-(void)addBottomCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    
    _bottomCollectionView = [[UICollectionView alloc]
                         initWithFrame: CGRectMake(50, 50, 0, 0)
                         collectionViewLayout: flowLayout];
    
    [_bottomCollectionView registerClass: PeriodsCell.class forCellWithReuseIdentifier: @"bottomCollectionViewCell"];
//    _bottomCollectionView.delegate = self;
//    _bottomCollectionView.dataSource = self;
    _bottomCollectionView.backgroundColor = [UIColor clearColor]; // UITest
    _bottomCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [chartFieldView addSubview: _bottomCollectionView];
    [_bottomCollectionView.topAnchor constraintEqualToAnchor: topSubview.bottomAnchor constant: 10].active = YES;
    [_bottomCollectionView.leftAnchor constraintEqualToAnchor: chartFieldView.leftAnchor constant: 20].active = YES;
    [_bottomCollectionView.rightAnchor constraintEqualToAnchor: chartFieldView.rightAnchor constant: -20].active = YES;
    [_bottomCollectionView.bottomAnchor constraintEqualToAnchor: chartFieldView.bottomAnchor constant: -50].active = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

@end
