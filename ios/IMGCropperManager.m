#import "TOCropViewController.h"
#import "SharedTOViewController.h"
#import <React/RCTViewManager.h>
#import "UIImage+CropRotate.h"

@interface IMGCropperManager : RCTViewManager <TOCropViewControllerDelegate>
@end

@implementation IMGCropperManager

RCT_EXPORT_MODULE(IMGCropper)
RCT_EXPORT_VIEW_PROPERTY(onRegionChange, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(uri, NSString)

- (UIView *)view
{
  // NSURL *defaultUrl = [NSURL URLWithString:@"https://media.nature.com/lw800/magazine-assets/d41586-020-01430-5/d41586-020-01430-5_17977552.jpg"];
  NSString* sharedImageUrl = [SharedTOViewController getSharedImageUrl];

  if (!sharedImageUrl) sharedImageUrl = @"https://media.nature.com/lw800/magazine-assets/d41586-020-01430-5/d41586-020-01430-5_17977552.jpg";
  
  NSURL *url = [NSURL URLWithString:sharedImageUrl];
  NSData *data = [NSData dataWithContentsOfURL:url];
  UIImage *image = [[UIImage alloc] initWithData:data];
  
    TOCropViewController *cropViewController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleCircular image:image];
    cropViewController.delegate = self;
  [SharedTOViewController setSharedTOViewController:cropViewController];
    UIView *view = cropViewController.view;
    return view;
}

#pragma mark TOCropViewControllerDelegate
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
  // 'image' is the newly cropped version of the original image
  NSLog(@"hey");
}
 
@end
