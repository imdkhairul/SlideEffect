//
//  MSSlider.h
//  SlideEffect
//
//  Created by Khairul Islam on 10/22/16.
//  Copyright © 2016 Khairul Islam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSliderDataSource.h"

@interface MSSlider : UIView

@property (nonatomic, strong) id<MSSliderDataSource> dataSource;

- (void) reloadData;

@end
