//
//  CMShareUtilObject.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMShareUtil.h"
#import "CMBasicViewController.h"

typedef NS_ENUM(NSInteger, CMShareStatus) {
    CMShareSuccess,
    CMShareFailed,
    CMShareCanceled
};

typedef void (^CMShareUtilBlock)(CMShareStatus status, NSString * errorString);

@protocol CMShareObjectDelegate <NSObject>

@optional
- (void)shareViewToLearnMore;
- (void)shareViewToInvitationHistory;
- (void)shareViewToTopRank;

@end

@interface CMShareUtilObject : NSObject

@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *desc;
@property (nonatomic , copy) NSString *image;
@property (nonatomic , copy) NSString *url;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , assign) CMShareType shareType;
@property (nonatomic , copy) CMShareUtilBlock shareBlock;




/**
 * @prama dictionary ,分享需要的内容键值对.title:分享的标题;desc:分享的描述;image:分享的图片URL,如果没有则会用旺管家icon;url:分享出去的URL;content,暂时没有用到
 * @return CMShareUtilObject
 */

+ (CMShareUtilObject *)buildShareUtilObjectWith:(NSDictionary *)dictionary;

- (void)shareInViewController:(CMBasicViewController *)viewController callBack:(CMShareUtilBlock )callBack;

@property (nonatomic , weak) id<CMShareObjectDelegate> delegate;

@end
