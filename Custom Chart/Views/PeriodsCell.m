//
//  PeriodsCell.m
//  Custom Chart
//
//  Created by Konstantin Mishukov on 14/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "PeriodsCell.h"
#import "../Categories/UIColor+BarChartView.h"

@implementation PeriodsCell

NSDictionary *data;

UILabel *bottomLabel;
UIView *bottomLine;

UIView *bottomBlock;
UILabel *bottomBlockLabel;
UIView *topBlock;
UILabel *topBlockLabel;
UIView *topBlockCornerCoverView;

UILabel *topLabel;

NSMutableArray<UIView*> *blocksArray;
NSMutableArray<UILabel*> *blockLabelsArray;

NSLayoutConstraint *bottomBlockHeightConstraint;
NSLayoutConstraint *topBlockHeightConstraint;

NSMutableArray<NSLayoutConstraint*> *constraintArray;


- (id)initWithFrame:(CGRect)aRect
{
    if (self = [super initWithFrame:aRect])
    {
        [self addBottomLabel];
        [self addTowerViews];
        [self addTopLabel];
        self.backgroundColor = [UIColor clearColor];
        [self addBottomLine];
       
    }
    return self;
}


-(void)configureWithData:(NSDictionary*)periodData maxValue:(double)maxValue seriesArray:(NSArray*)serArray {
    data = periodData;
    bottomLabel.text = (data[@"sName"]) ? [NSString stringWithFormat:@"%@", data[@"sName"]] : @"???";
    topLabel.text = periodData[@"fBarTotalValue"] != nil ? [NSString stringWithFormat:@"%.1f", [periodData[@"fBarTotalValue"] doubleValue]] : @"???";
    
    NSArray *vals = [periodData valueForKey: @"vals"];
    // Коэфициент высоты башни относительно экрана;
    double labelsOffset = -36 -36 -10 -10;
    double pixelPerPoint = (self.contentView.frame.size.height + labelsOffset) / maxValue;
    
//    NSLog(@"\ncontentView.height: %f;\nbottomLabel.height: %f;\ntopLabel.height: %f;\nmaxValue: %f;\npixelPerPoint: %f", self.contentView.frame.size.height, bottomLabel.frame.size.height,topLabel.frame.size.height,maxValue, pixelPerPoint);
    
    if (vals && [vals count]==2) {
        for (int i=0; i < 2; i++) {
            blocksArray[i].backgroundColor = [UIColor colorForSeriesID: vals[i][@"nSeriesID"] inSeriesArray: serArray];
            topBlockCornerCoverView.backgroundColor = topBlock.backgroundColor;
            float value = [[vals[i] valueForKey:@"fValue"] floatValue];
            blockLabelsArray[i].text = [NSString stringWithFormat: @"%.1f", value];
          
            [constraintArray[i] setConstant: value * pixelPerPoint];
            if  (topBlockHeightConstraint.constant == 0) {
                topBlockCornerCoverView.alpha = 0;
            } else {
                topBlockCornerCoverView.alpha = 1;
            }
        }
    }

    [self layoutIfNeeded];
    return;
}

//  Значение года под столбиком;
-(void)addBottomLabel {
    bottomLabel = [UILabel new];
    bottomLabel.textColor = [UIColor whiteColor];
    bottomLabel.alpha = 0.35;
    bottomLabel.font = [UIFont systemFontOfSize: 30];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.adjustsFontSizeToFitWidth = YES;
    bottomLabel.minimumScaleFactor = 0.1;
    bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: bottomLabel];
    [bottomLabel.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor].active = YES;
    [bottomLabel.centerXAnchor constraintEqualToAnchor: self.contentView.centerXAnchor].active = YES;
    [bottomLabel.widthAnchor constraintEqualToAnchor: self.contentView.widthAnchor multiplier: 0.55].active = YES;
}

// Полоса под столбиками;
-(void)addBottomLine{
    bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor whiteColor];
    bottomLine.alpha = 0.1;
    bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: bottomLine];
    [bottomLine.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor].active = YES;
    [bottomLine.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor].active = YES;
    [bottomLine.bottomAnchor constraintEqualToAnchor: bottomLabel.topAnchor constant: -15].active = YES;
    CGFloat bottomLineHeightConstant = 4;
    [bottomLine.heightAnchor constraintEqualToConstant: bottomLineHeightConstant].active = YES;
}

//  Столбик ( состоит из 3 );
-(void)addTowerViews{
    bottomBlock = [UIView new];
    bottomBlock.backgroundColor = [UIColor blueColor];
    bottomBlock.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: bottomBlock];
    [bottomBlock.bottomAnchor constraintEqualToAnchor: bottomLabel.topAnchor constant: -15].active = YES;
    [bottomBlock.widthAnchor constraintEqualToAnchor: self.contentView.widthAnchor multiplier: 0.5].active = YES;
    [bottomBlock.centerXAnchor constraintEqualToAnchor: self.contentView.centerXAnchor].active = YES;
    bottomBlockHeightConstraint = [bottomBlock.heightAnchor constraintEqualToConstant: 0];
    bottomBlockHeightConstraint.active = YES;
    
    topBlock = [UIView new];
    topBlock.backgroundColor = [UIColor lightGrayColor];
    topBlock.layer.cornerRadius = 5;
    topBlock.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: topBlock];
    [topBlock.bottomAnchor constraintEqualToAnchor: bottomBlock.topAnchor constant: -5].active = YES;
    [topBlock.widthAnchor constraintEqualToAnchor: self.contentView.widthAnchor multiplier: 0.5].active = YES;
    [topBlock.centerXAnchor constraintEqualToAnchor: self.contentView.centerXAnchor].active = YES;
    topBlockHeightConstraint = [topBlock.heightAnchor constraintEqualToConstant: 0];
    topBlockHeightConstraint.active = YES;
    
    topBlockCornerCoverView = [UIView new];
    topBlockCornerCoverView.translatesAutoresizingMaskIntoConstraints = NO;
    [topBlock addSubview: topBlockCornerCoverView];
    [topBlockCornerCoverView.bottomAnchor constraintEqualToAnchor: topBlock.bottomAnchor].active = YES;
    [topBlockCornerCoverView.widthAnchor constraintEqualToAnchor: topBlock.widthAnchor].active = YES;
    [topBlockCornerCoverView.heightAnchor constraintEqualToConstant: topBlock.layer.cornerRadius].active = YES;
    
    blocksArray = [[NSMutableArray alloc] initWithObjects: bottomBlock, topBlock, nil];
    constraintArray = [[NSMutableArray alloc] initWithObjects: bottomBlockHeightConstraint, topBlockHeightConstraint, nil];
    
    bottomBlockLabel = [UILabel new];
    bottomBlockLabel.font = [UIFont systemFontOfSize: 30 weight: UIFontWeightLight];
    bottomBlockLabel.textColor = [UIColor whiteColor];
    bottomBlockLabel.textAlignment = NSTextAlignmentCenter;
    bottomBlockLabel.adjustsFontSizeToFitWidth = YES;
    bottomBlockLabel.minimumScaleFactor = 0.5;
    bottomBlockLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomBlock addSubview: bottomBlockLabel];
    [bottomBlockLabel.centerXAnchor constraintEqualToAnchor: bottomBlock.centerXAnchor].active = YES;
    [bottomBlockLabel.centerYAnchor constraintEqualToAnchor: bottomBlock.centerYAnchor].active = YES;
    [bottomBlockLabel.widthAnchor constraintEqualToAnchor: bottomBlock.widthAnchor multiplier: 0.9].active = YES;
    
    topBlockLabel = [UILabel new];
    topBlockLabel.font = bottomBlockLabel.font;
    topBlockLabel.textColor = [UIColor whiteColor];
    topBlockLabel.textAlignment = NSTextAlignmentCenter;
    topBlockLabel.adjustsFontSizeToFitWidth = YES;
    topBlockLabel.minimumScaleFactor = 0.1;
    topBlockLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [topBlock addSubview: topBlockLabel];
    [topBlockLabel.centerXAnchor constraintEqualToAnchor: topBlock.centerXAnchor].active = YES;
    [topBlockLabel.centerYAnchor constraintEqualToAnchor: topBlock.centerYAnchor].active = YES;
    [topBlockLabel.widthAnchor constraintEqualToAnchor: topBlock.widthAnchor multiplier: 0.9].active = YES;
    
    blockLabelsArray = [[NSMutableArray alloc] initWithObjects: bottomBlockLabel, topBlockLabel, nil];
}

//  Значение total над столбиком;
-(void)addTopLabel{
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 36)];
    topLabel.font = [UIFont boldSystemFontOfSize: 30];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.adjustsFontSizeToFitWidth = YES;
    topLabel.minimumScaleFactor = 0.1;
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: topLabel];
    
    [topLabel.bottomAnchor constraintEqualToAnchor: topBlock.topAnchor constant: -5].active = YES;
    [topLabel.centerXAnchor constraintEqualToAnchor: self.contentView.centerXAnchor].active = YES;
    [topLabel.widthAnchor constraintEqualToAnchor: self.contentView.widthAnchor multiplier: 0.5].active = YES;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)didMoveToSuperview {
    if (bottomBlockLabel.frame.size.height > bottomBlock.frame.size.height) {
        [bottomBlockLabel setHidden: YES];
    } else {
        [bottomBlockLabel setHidden: NO];
    }
    if (topBlockLabel.frame.size.height > topBlock.frame.size.height) {
        [topBlockLabel setHidden: YES];
    } else {
        [topBlockLabel setHidden: NO];
    }
}



@end
