//
//  ViewController.m
//  SlideEffect
//
//  Created by Khairul Islam on 10/22/16.
//  Copyright © 2016 Khairul Islam. All rights reserved.
//

#import "ViewController.h"
#import "MSSlider.h"
#import "MSFilter.h"
#import "MSSliderDataSource.h"

#define k_screen_width [UIScreen mainScreen].bounds.size.width
#define k_screen_heigtht [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<MSSliderDataSource>

@property (nonatomic, strong) MSSlider *slider;
@property (nonatomic, strong) UIView *slideView;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_screen_width, k_screen_heigtht)];
    self.slider = [[MSSlider alloc] initWithFrame:self.slideView.frame];
    [self setupSlider];
}

- (void) setupSlider {
    
    [self createDataWithImage:[UIImage imageNamed:@"pic"]];
    self.slider.dataSource = self;
    self.slider.userInteractionEnabled = true;
    self.slider.multipleTouchEnabled = true;
    self.slider.exclusiveTouch = false;
    
    [self.slideView addSubview:self.slider];
    [self.view addSubview:self.slideView];
    [self.slider reloadData];
}


- (void) createDataWithImage:(UIImage *)image {
    
    self.data = [MSFilter generateFiltersWithoriginalImage:[[MSFilter alloc] initWithFrame:self.slider.frame withImage:image withContentMode:UIViewContentModeScaleToFill] withFilters:[MSFilter filterNameList]];
    
}

#pragma mark - MSSliderDatasource

- (NSInteger) numberOfSlides:(MSSlider *)slider{

    return self.data.count;
}
- (MSFilter *)slider:(MSSlider *)slider slideAtIndex:(NSInteger)index{

    return [self.data objectAtIndex:index];
}
- (NSInteger) startAtIndex:(MSSlider *)slider{

    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
