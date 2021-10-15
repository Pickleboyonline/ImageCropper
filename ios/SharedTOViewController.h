#import "TOCropViewController.h"

@interface SharedTOViewController : NSObject
+ (void)setSharedTOViewController:(TOCropViewController*) newTOViewController;
+ (TOCropViewController * )getSharedTOViewController;

+ (void) setSharedImageUrl: (NSString*) imageUrl;
+ (NSString*) getSharedImageUrl;
@end
