//
//  MSFilter.m
//  MediaStudio
//
//  Created by Khairul on 10/19/16.
//  Copyright © 2016 Mostafizur Rahman. All rights reserved.
//

#import "MSFilter.h"
#import "MSSticker.h"

@interface MSFilter()<NSCopying>

@property(nonatomic, strong) NSString *name;


@end

@implementation MSFilter

+ (NSArray *)filterNameList
{
    static NSArray *filterName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filterName = @[@"No Filter" , @"CIPhotoEffectFade", @"CIPhotoEffectChrome", @"CIPhotoEffectTransfer", @"CIPhotoEffectInstant", @"CIPhotoEffectMono", @"CIPhotoEffectNoir", @"CIPhotoEffectProcess", @"CIPhotoEffectTonal"];
    });
    return filterName;
}

- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage *)image withContentMode:(UIViewContentMode)contentMode {

    self = [super initWithFrame:frame];
    if (self) {
        self.image = image;
        self.contentMode = contentMode;
        self.stickers = [NSMutableArray array];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    MSFilter *copy = [[MSFilter alloc] initWithFrame:self.frame];
    copy.backgroundColor = self.backgroundColor;
    copy.image = self.image;
    copy.name = self.name;
    copy.contentMode = self.contentMode;
    
    return copy;

}

- (void) mask:(CGRect)maskRect {
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, maskRect);
    maskLayer.path = path;
    self.layer.mask = maskLayer;
}

- (void) updateMask:(CGRect)maskRect withNewXposition:(CGFloat)newXPosition {
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect = maskRect;
    rect.origin.x = newXPosition;
    CGPathAddRect(path, nil, rect);
    maskLayer.path = path;
    self.layer.mask = maskLayer;
}

- (MSFilter *) applyFilterWithFilterName:(NSString *)filterName {
    
    MSFilter *msfilter = (MSFilter *)self.copy;
    msfilter.name = filterName;
    
    if ([MSFilter.filterNameList containsObject:filterName] == false) {
        return msfilter;
    }
    else if ([filterName isEqualToString:@"No Filter"] ) {
        return msfilter;
    }
    else
    {
        // Create and apply filter
        // 1 - create source image
        CIImage *sourceImage = [CIImage imageWithCGImage:msfilter.image.CGImage];
        
        // 2 - create filter using name
        CIFilter *myFilter = [CIFilter filterWithName:filterName];
        [myFilter setDefaults];
        
        // 3 - set source image
        [myFilter setValue:sourceImage forKey:kCIInputImageKey];
        
        // 4 - create core image context
        CIContext *context = [CIContext contextWithOptions:nil];
        
        // 5 - output filtered image as cgImage with dimension.
        CGImageRef outputCGImage = [context createCGImage:myFilter.outputImage fromRect:myFilter.outputImage.extent];
        
        // 6 - convert filtered CGImage to UIImage
        UIImage *filteredImage = [UIImage imageWithCGImage:outputCGImage];
        
        //UIImageWriteToSavedPhotosAlbum(filteredImage, nil, nil, nil);
        // 7 - set filtered image to array
        msfilter.image = filteredImage;
        return msfilter;
    }
}

+ (NSArray *)generateFiltersWithoriginalImage:(MSFilter *)image withFilters:(NSArray*)filters {
    
    NSMutableArray *finalFilters = [[NSMutableArray alloc] init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_attr_t qos_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, 0);
    dispatch_queue_t syncQueue = dispatch_queue_create("com.snapsliderfilters.app", qos_attr);
    
    dispatch_apply(filters.count, queue, ^(size_t iteration) {
        
       MSFilter *filterComputed = [image applyFilterWithFilterName:[filters objectAtIndex:iteration]];
        dispatch_sync(syncQueue, ^{
            [finalFilters addObject:filterComputed];
        });
    });
    
    return finalFilters;
}

- (void) addSticker:(MSSticker *) sticker{
    [self.stickers addObject:sticker];
}

@end
