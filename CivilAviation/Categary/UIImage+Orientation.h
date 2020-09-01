//
//  UIImage+Orientation.h
//  SchoolChat_Parent_iOS
//
//  Created by easyto on 2019/11/11.
//  Copyright © 2019 liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Orientation)

+ (UIImage*)fixOrientation:(UIImage*)image;

@end

NS_ASSUME_NONNULL_END
