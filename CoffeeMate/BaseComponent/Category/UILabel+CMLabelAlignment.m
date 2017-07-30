//
//  UILabel+CMLabelAlignment.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "UILabel+CMLabelAlignment.h"

@implementation UILabel (CMLabelAlignment)
- (void)alignTop {
    self.text = [self.text stringByAppendingString:@"\n \n \n \n \n "];
}
- (void)alignBottom {

}
@end
