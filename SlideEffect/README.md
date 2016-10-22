# SlideEffect

SlideEffect allows you to create easily a SnapChat like navigation between a picture and its filters (that you can automatically generate).This is the Objective C conversion of (https://github.com/pauljeannot/SnapSliderFilters).

#### Supported Device

iPhone 4s, 5, 5s, 5c, 6, 6 Plus, 6s, 6s Plus, all iPad having iOS 9.

## How to use

### Slider

To insert a slider in your ViewController, all you need is to create the slider, load the data and show it.

```swift
self.slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_screen_width, k_screen_heigtht)];
self.slider = [[MSSlider alloc] initWithFrame:self.slideView.frame];
```

Then, you can generate filters from your original picture, using the [Core Image Filter](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/). `[MSFilter filterNameList]`is a small selection of filters that you can use for a quick demo :
```swift 
// Create your original filter
MSFilter *originalPicture = [[MSFilter alloc] initWithFrame:self.slider.frame withImage:image withContentMode:UIViewContentModeScaleToFill];
// Generate differents filters by passing in argument the original picture and an array of filter's name
self.data = [MSFilter generateFiltersWithoriginalImage:originalPicture withFilters:[MSFilter filterNameList]];
```

Your ViewController must conform to the `MSSliderDataSource` protocol. It allows the slider to be populated with your own data.

```swift
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

```swift 
self.slider.dataSource = self;
self.slider.userInteractionEnabled = true;
self.slider.multipleTouchEnabled = true;
self.slider.exclusiveTouch = false;

[self.slideView addSubview:self.slider];
[self.view addSubview:self.slideView];
[self.slider reloadData];

```
## Author

Md. Khairul Islam.
Contact at imdkhairul@gmail.com

## License

Free Icons provided by [Icons8](https://icons8.com)

SlideEffect is available under the MIT license. See the LICENSE file for more info.
