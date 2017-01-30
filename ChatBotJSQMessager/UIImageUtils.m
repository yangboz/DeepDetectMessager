//
//  UIImageUtils.m
//  DeepDetectChatBots
//
//  Created by yangboz on 30/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "UIImageUtils.h"

@implementation UIImageUtils
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
