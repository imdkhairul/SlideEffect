//
//  MSFilter.h
//  MediaStudio
//
//  Created by Khairul on 10/19/16.
//  Copyright © 2016 Mostafizur Rahman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSFilter : UIImageView

@property(nonatomic, strong) NSMutableArray *stickers;

+ (NSArray *)filterNameList;
- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage *)image withContentMode:(UIViewContentMode)contentMode;
- (void) mask:(CGRect)maskRect;
- (void) updateMask:(CGRect)maskRect withNewXposition:(CGFloat)newXPosition;
- (MSFilter *) applyFilterWithFilterName:(NSString *)filterName;
+ (NSArray *)generateFiltersWithoriginalImage:(MSFilter *)image withFilters:(NSArray*)filters;

@end
