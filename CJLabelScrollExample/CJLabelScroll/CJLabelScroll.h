//
//  CJLabelScroll.h
//  LetsFit
//
//  Created by Camus on 19/08/13.
//  Copyright (c) 2013 SumacApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJLabelScroll : UIView <UIScrollViewDelegate>

@property (nonatomic, retain) UILabel *label;

@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGFloat fadeLength;

@end
