//
//  UIImageResize.h
//  My Paper v3
//
//  Created by Harry Slotwiner on 1/28/14.
//  Copyright (c) 2014 Harry Slotwiner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageFunctions)

- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)scaleProportionalToSize:(CGSize)size;

@end
