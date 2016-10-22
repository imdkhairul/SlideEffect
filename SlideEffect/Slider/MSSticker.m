//
//  MSSticker.m
//  SlideEffect
//
//  Created by Khairul Islam on 10/22/16.
//  Copyright © 2016 Khairul Islam. All rights reserved.
//

#import "MSSticker.h"

@implementation MSSticker

- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage *)image withContentMode:(UIViewContentMode)contentMode atZposition:(CGFloat)zPosition {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.image = image;
        self.contentMode = contentMode;
        self.clipsToBounds = true;
        if (zPosition) {
            self.layer.zPosition = zPosition;
        }
        else {
            self.layer.zPosition = 0;
        }
    }
    return self;
}

@end
