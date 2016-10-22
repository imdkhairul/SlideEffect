//
//  MSSlider.m
//  SlideEffect
//
//  Created by Khairul Islam on 10/22/16.
//  Copyright © 2016 Khairul Islam. All rights reserved.
//

#import "MSSlider.h"
#import "MSSticker.h"
#import "MSFilter.h"

@interface MSSlider()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *slider;
@property (nonatomic, readwrite) NSInteger numberOfPages;
@property (nonatomic, readwrite) NSInteger startingIndex;
@property (nonatomic, strong) NSMutableArray *data;



@end

@implementation MSSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self.numberOfPages = 3;
    self.startingIndex = 0;
    self.slider = [[UIScrollView alloc] initWithFrame:frame];
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void) configure {

    self.data = [[NSMutableArray alloc] init];
    self.slider.delegate = self;
    self.slider.pagingEnabled = YES;
    self.slider.bounces = NO;
    self.slider.scrollEnabled = YES;
    self.slider.showsHorizontalScrollIndicator = NO;
    self.slider.showsVerticalScrollIndicator = NO;
    self.slider.layer.zPosition = 1;
    self.slider.userInteractionEnabled = YES;
    [self addSubview:self.slider];
}

- (void) reloadData {
    
    [self cleanData];
    [self loadData];
    [self presentData];
}

- (MSFilter *) slideShown {
    
    NSInteger index = self.slider.contentOffset.x / self.slider.frame.size.width;
    return [self.data objectAtIndex:index];
}

- (void) cleanData {
    for(UIView *v in self.subviews) {
        if ([v isKindOfClass:[MSFilter class]]) {
            MSFilter *filter = (MSFilter *)v;
            if (filter != nil) {
                [v removeFromSuperview];
            }
        }
    }
    
    for(UIView *s in self.slider.subviews) {
        if([s isKindOfClass:[MSSticker class]]){
            MSSticker *sticker = (MSSticker *)s;
            if  (sticker != nil) {
                [s removeFromSuperview];
            }
        }
    }
    
    [self.data removeAllObjects];
}

- (void) loadData {
    
    self.numberOfPages = [self.dataSource numberOfSlides:self];
    self.startingIndex = [self.dataSource startAtIndex:self];
    self.slider.contentSize = CGSizeMake(self.frame.size.width*(self.numberOfPages+2),self.frame.size.height);
    
    MSFilter *filter = [[self.dataSource slider:self slideAtIndex:self.numberOfPages-1] copy];
    //(self, slideAtIndex:self.numberOfPages-1)
    [self.data addObject:filter];
    
    
    for(NSInteger i = 0;  i<self.numberOfPages; i++){
        MSFilter *filter = [self.dataSource slider:self slideAtIndex:i];
        [self.data addObject:filter];
    }
    
    filter = [[self.dataSource slider:self slideAtIndex:0] copy];
    [self.data addObject:filter];
    
    [self.slider scrollRectToVisible:CGRectMake([self positionOfPageAtIndex:self.startingIndex], 0, self.frame.size.width, self.frame.size.height) animated:false];
}

- (void) presentData {
    
    for (NSInteger i=0; i <self.data.count; i++ ){
        MSFilter *filter = [self.data objectAtIndex:i];
        filter.layer.zPosition = 0;
        [filter mask:filter.frame];
        [filter updateMask:filter.frame withNewXposition:[self positionOfPageAtIndex:i-self.startingIndex-2]];
        [self addSubview:filter];
        
        for (MSSticker *s in filter.stickers){
            [s setFrame:CGRectMake(s.frame.origin.x+ [self positionOfPageAtIndex:i-1], s.frame.origin.y, s.frame.size.width, s.frame.size.height)];
            [self.slider addSubview:s];
        }
    }
}

- (CGFloat) positionOfPageAtIndex:(NSInteger)index {
    
    return (self.frame.size.width*index) + self.frame.size.width;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    for (NSInteger i = 0; i<self.data.count;i++) {
        MSFilter *filter = [self.data objectAtIndex:i];
        [filter updateMask:filter.frame withNewXposition:([self positionOfPageAtIndex:i-1]-scrollView.contentOffset.x)];
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x == [self positionOfPageAtIndex:-1]) {
        [self.slider scrollRectToVisible:CGRectMake([self positionOfPageAtIndex:self.numberOfPages-1], 0, self.frame.size.width, self.frame.size.height) animated:false];
    }
    else if (scrollView.contentOffset.x == [self positionOfPageAtIndex:self.numberOfPages]) {
        [self.slider scrollRectToVisible:CGRectMake([self positionOfPageAtIndex:0], 0, self.frame.size.width, self.frame.size.height) animated:false];
    }
}

@end
