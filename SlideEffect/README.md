# SlideEffect

## How to use

### Slider

To insert a slider in your ViewController, all you need is to create the slider, load the data and show it.

```Objective C
self.slider = [[MSSlider alloc] initWithFrame:self.slideView.frame];
```

Then, you can generate filters from your original picture, using the [Core Image Filter](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/). `MSFilter.filterNameList`is a small selection of filters that you can use for a quick demo :
 
// Create your original filter
```Objective C
MSFilter *filter = [[MSFilter alloc] initWithFrame:self.slider.frame withImage:image withContentMode:UIViewContentModeScaleToFill];
```
// Generate differents filters by passing in argument the original picture and an array of filter's name

```Objective C
self.data = [MSFilter generateFiltersWithoriginalImage:filter withFilters:[MSFilter filterNameList]];
```

Your ViewController must conform to the `MSSliderDataSource` protocol. It allows the slider to be populated with your own data.

```Objective C
- (NSInteger) numberOfSlides:(MSSlider *)slider{

    return self.data.count;
}
- (MSFilter *)slider:(MSSlider *)slider slideAtIndex:(NSInteger)index{

    return [self.data objectAtIndex:index];
}
- (NSInteger) startAtIndex:(MSSlider *)slider{

    return 0;
}
```

Finally, you can show the slider :

```Objective C
self.slider.dataSource = self;
    self.slider.userInteractionEnabled = true;
    self.slider.multipleTouchEnabled = true;
    self.slider.exclusiveTouch = false;
    
    [self.slideView addSubview:self.slider];
    [self.view addSubview:self.slideView];
    [self.slider reloadData];
```