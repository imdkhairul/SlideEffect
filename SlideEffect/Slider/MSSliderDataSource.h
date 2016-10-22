//
//  MSSliderDataSource.h
//  SlideEffect
//
//  Created by Khairul Islam on 10/22/16.
//  Copyright © 2016 Khairul Islam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSSlider;
@class MSFilter;

@protocol MSSliderDataSource <NSObject>

- (NSInteger) numberOfSlides:(MSSlider *)slider;
- (MSFilter *)slider:(MSSlider *)slider slideAtIndex:(NSInteger)index;
- (NSInteger) startAtIndex:(MSSlider *)slider;

@end
