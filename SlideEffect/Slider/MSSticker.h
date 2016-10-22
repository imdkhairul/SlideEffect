//
//  MSSticker.h
//  SlideEffect
//
//  Created by Khairul Islam on 10/22/16.
//  Copyright © 2016 Khairul Islam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSSticker : UIImageView

- (instancetype)initWithFrame:(CGRect)frame withImage:(UIImage *)image withContentMode:(UIViewContentMode)contentMode atZposition:(CGFloat)zPosition;

@end
