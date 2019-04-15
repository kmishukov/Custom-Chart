//
//  SeriesCollectionViewCell.m
//  Custom Chart
//
//  Created by Konstantin Mishukov on 13/04/2019.
//  Copyright © 2019 Konstantin Mishukov. All rights reserved.
//

#import "SeriesCell.h"

@implementation SeriesCell

UIView *dot;
UILabel *sName;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addLayers];
    }
    return self;
}

-(void)addLayers{
    // Colored Dot;
    CGFloat dotRadius = self.contentView.frame.size.height / 3;
    dot = [[UIView alloc] initWithFrame: CGRectMake(0, 0, dotRadius, dotRadius)];
    dot.layer.cornerRadius = dot.frame.size.width / 2;
    dot.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: dot];
    // Constraints
    [dot.heightAnchor constraintEqualToConstant: dotRadius].active = YES;
    [dot.widthAnchor constraintLessThanOrEqualToAnchor: dot.heightAnchor multiplier: 1].active = YES;
    [dot.centerYAnchor constraintEqualToAnchor: self.contentView.centerYAnchor].active = YES;
    [dot.leftAnchor constraintEqualToAnchor: self.contentView.leftAnchor constant: 5].active = YES;
    // sName;
    sName = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    sName.font = [UIFont systemFontOfSize: 30];
    sName.textColor = [UIColor whiteColor];
    sName.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: sName];
    [sName.leftAnchor constraintEqualToAnchor: dot.rightAnchor constant: 15].active = YES;
    [sName.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: 0].active = YES;
    [sName.centerYAnchor constraintEqualToAnchor: self.contentView.centerYAnchor].active = YES;
}

-(void)configureCellwithTitle:(NSString*)title andColor:(NSDictionary*)colorDict {
    sName.text = title;
    if (colorDict != nil) {
        CGFloat red = colorDict[@"r"] != nil ? [colorDict[@"r"] doubleValue] : 0;
        CGFloat green = colorDict[@"g"] != nil ? [colorDict[@"g"] doubleValue] : 0;
        CGFloat blue = colorDict[@"b"] != nil ? [colorDict[@"b"] doubleValue] : 0;
        dot.backgroundColor = [UIColor colorWithRed: red/255.0f green: green/255.0f blue: blue/255.0f alpha: 1];
    };
}

@end
