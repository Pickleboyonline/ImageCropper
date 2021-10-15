//
//  IMGCropperModule.m
//  ImageCropper
//
//  Created by Imran Shitta-Bey on 10/15/21.
//

#import "TOCropViewController.h"
#import <Foundation/Foundation.h>
#import "IMGCropperModule.h"
#import "TOCropViewController.h"
#import "SharedTOViewController.h"
#import "UIImage+CropRotate.h"

@implementation IMGCropperModule

// To export a module named RCTCalendarModule
RCT_EXPORT_MODULE(CropperModule);

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}


RCT_EXPORT_METHOD(getCroppedImageUri: (double)compressionQuality
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  )
{
  TOCropViewController *cropViewController = [SharedTOViewController getSharedTOViewController];
  
  if (cropViewController != nil) {
    UIImage *image = nil;
    NSInteger angle = cropViewController.angle;
    CGRect cropFrame = cropViewController.cropView.imageCropFrame;
    
    if (angle == 0 && CGRectEqualToRect(cropFrame, (CGRect){CGPointZero, cropViewController.image.size})) {
        image = cropViewController.image;
    }
    else {
        image = [cropViewController.image croppedImageWithFrame:cropFrame angle:angle circularClip:NO];
    }
    
    
    NSData *imgData= UIImageJPEGRepresentation(image,compressionQuality /*compressionQuality*/);
    
    image = [UIImage imageWithData:imgData];
    
    NSString * base64Encoding = [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    resolve(base64Encoding);
    
  } else {
    resolve(@"It did not work");
  }

    
  
}


RCT_EXPORT_METHOD(setImageUrl: (NSString *)url
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  )
{
  [SharedTOViewController setSharedImageUrl:url];
  resolve(nil);
}

@end
