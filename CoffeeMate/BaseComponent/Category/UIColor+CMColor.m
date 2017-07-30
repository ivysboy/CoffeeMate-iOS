//
//  UIColor+CMColor.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "UIColor+CMColor.h"
#import "UIColor+util.h"

@implementation UIColor (CMColor)

+ (UIColor *)viewBackgroundColor {
    return [UIColor colorWithHexString:@"#f0f0f0"];
}

+ (UIColor *)titleGreenColor {
    return [UIColor colorWithRed:36/255.0 green:200/255.0 blue:60/255.0 alpha:1.0];
}

+ (UIColor *)titleBlueColor {
    return [UIColor colorWithRed:11/255.0 green:179/255.0 blue:252/255.0 alpha:1.0];
}

+ (UIColor *)highlightedColor {
    return [UIColor colorWithRed:251/255.0 green:69/255.0 blue:116/255.0 alpha:1.0];
}

+ (UIColor *)darkBlueColor {
    return [UIColor colorWithRed:4/255.0 green:50/255.0 blue:74/255.0 alpha:1.0];
}

+ (UIColor *)coverViewColor {
    return [UIColor colorWithRed:(20)/255.0 green:(20)/255.0 blue:(20)/255.0 alpha:0.2];
}
@end
