//
//  SharedTOViewController.m
//  ImageCropper
//
//  Created by Imran Shitta-Bey on 10/15/21.
//

#import <Foundation/Foundation.h>
#import "TOCropViewController.h"
#import "SharedTOViewController.h"

static TOCropViewController * sharedTOViewController = nil;
static NSString* sharedImageUrl = @"";

@implementation SharedTOViewController
	
+(void)setSharedTOViewController:(TOCropViewController*) newTOViewController
{
  sharedTOViewController = newTOViewController;
}

+(TOCropViewController * )getSharedTOViewController
{
  return sharedTOViewController;
}

+(void) setSharedImageUrl:(NSString *)imageUrl
{
  sharedImageUrl = imageUrl;
}

+ (NSString *)getSharedImageUrl
{
  return sharedImageUrl;
}

@end
