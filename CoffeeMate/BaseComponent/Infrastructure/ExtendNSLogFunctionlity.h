//
//  ExtendNSLogFunctionlity.h
//  Jupiter
//
//  Created by NikoTung on 9/11/15.
//  Copyright (c) 2015 edjyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);
