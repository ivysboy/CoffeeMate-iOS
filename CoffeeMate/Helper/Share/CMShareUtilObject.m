//
//  CMShareUtilObject.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMShareUtilObject.h"
#import <WeiboSDK/WeiboSDK.h>
#import "CMShareUtil.h"
#import <WechatOpenSDK/WXApi.h>

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <AFNetworking/AFImageDownloader.h>
#import <objc/runtime.h>

static NSString *kShareObjecRetaintKey = @"ShareObjecRetaintKey";


@interface CMShareUtilObject ()<CMShareUtilDelegate>

@property (nonatomic , copy) NSString *stringForRetain;
@property (nonatomic , strong) UIImage *loadedImage;

@end

@implementation CMShareUtilObject

+ (CMShareUtilObject *)buildShareUtilObjectWith:(NSDictionary *)dictionary {
    CMShareUtilObject *shareUtilObject = [[CMShareUtilObject alloc] init];
    shareUtilObject.title =  dictionary[@"title"];
    shareUtilObject.desc = dictionary[@"desc"];
    shareUtilObject.image = [(NSString *)dictionary[@"image"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    shareUtilObject.url = dictionary[@"url"];
    shareUtilObject.content = dictionary[@"content"];
    
    return shareUtilObject;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _addObservers];
        _stringForRetain = @"kRetainString";
    }
    
    return self;
}


- (void)_retainSelf {
    objc_setAssociatedObject(self.stringForRetain, &kShareObjecRetaintKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)_releaseSelf {
    objc_setAssociatedObject(self.stringForRetain, &kShareObjecRetaintKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)_addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_wechatShareCallback:) name:CMWXShareCallbackNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_sinaShareCallback:) name:CMSinaShareCallBackNotification object:nil];
}

- (void)_wechatShareCallback:(NSNotification *)notification {
    SendMessageToWXResp * resp = notification.object;
    [self _callbackWith:[self _wechatShareStatus:resp.errCode] errorString:resp.errStr ? : @""];
}

- (void)_sinaShareCallback:(NSNotification *)notification {
    WBSendMessageToWeiboResponse *resp = notification.object;
    [self _callbackWith:[self _sianShareStatus:resp.statusCode] errorString:@""];
}

- (void)_callbackWith:(CMShareStatus )status errorString:(NSString *)errorString {
    if (_shareBlock != NULL) {
        _shareBlock(status , errorString);
    }
}

- (void)_removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CMWXShareCallbackNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CMSinaShareCallBackNotification object:nil];
}

- (void)dealloc {
    [self _removeObservers];
    NSLog(@"de.................................aloc");
}

- (CMShareStatus )_wechatShareStatus:(NSInteger)errorCode {
    switch (errorCode) {
        case 0:
            return CMShareSuccess;
        case -2:
            return CMShareCanceled;
        default:
            return CMShareFailed;
    }
}

- (CMShareStatus )_sianShareStatus:(NSInteger)errorCode {
    switch (errorCode) {
        case 0:
            return CMShareSuccess;
        case -1:
            return CMShareCanceled;
        default:
            return CMShareFailed;
    }
}

- (CMShareStatus )_qzoneShareStatus:(NSInteger)errorCode {
    switch (errorCode) {
        case 0:
            return CMShareSuccess;
        case -4:
            return CMShareCanceled;
        default:
            return CMShareFailed;
    }
}


- (void)shareInViewController:(CMBasicViewController *)viewController callBack:(CMShareUtilBlock )callBack {
    
    CMShareUtil *shareUtil = [[CMShareUtil alloc] init];
    shareUtil.delegate = self;
    
    if (callBack != NULL) {
        self.shareBlock = callBack;
    }
    
    if (_image.length) {
        [self _loadImage:_image];
        
        //该方法会引起崩溃
        //        [self _getThumnail:_image];
    }
    
    if(![shareUtil showShareUtil]) {
        [viewController showLongToastWith:@"请先安装微信、QQ或新浪微博APP"];
        return;
    }
    [self _retainSelf];
}

- (void)_loadImage:(NSString *)url {
    NSError *error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] returningResponse:nil error:&error];
    if ([error code] == 0)
    {
        
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            self.loadedImage = [image scaledToMaxSize:CGSizeMake(100, 100)];
            
        }
    }
}

- (void)_getThumnail:(NSString *)url {
    
    NSURL *cacheURL =[NSURL URLWithString:url];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:cacheURL];
    AFImageDownloader *downloader = [AFImageDownloader defaultInstance];
    UIImage *cachedImage = [downloader.imageCache imageforRequest:urlRequest withAdditionalIdentifier:nil];
    
    if(cachedImage) {
        return;
    }
    
    [downloader downloadImageForURLRequest:[NSURLRequest requestWithURL:cacheURL] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
        NSLog(@"cached image success");
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"cached image failure");
    }];
    
}

#pragma mark --- CMShareUtilDelegate


- (void)shareUtil:(CMShareUtil *)shareUtil didSelectType:(CMShareType)shareType {
    self.shareType = shareType;
    switch (shareType){
        case  CMShareTypeWXSession :
        case CMShareTypeWXTimeline :
            [self shareToWeChat:shareType];
            break;
        case CMShareTypeSinaTimeline :
            [self shareToSinaTimeline];
    }
    [self _releaseSelf];
    
}

- (void)shareUtil:(CMShareUtil *)shareUtil cancelShare:(BOOL)canceled {
    [self _callbackWith:CMShareCanceled errorString:@""];
    [self _releaseSelf];
}


- (void)gotoLearnMoreDetail {
    if([_delegate respondsToSelector:@selector(shareViewToLearnMore)]) {
        [_delegate shareViewToLearnMore];
    }
}

- (void)gotoInvitationHitory {
    if([_delegate respondsToSelector:@selector(shareViewToInvitationHistory)]) {
        [_delegate shareViewToInvitationHistory];
    }
}

- (void)gotoTopRank {
    if([_delegate respondsToSelector:@selector(shareViewToTopRank)]) {
        [_delegate shareViewToTopRank];
    }
}

- (NSData *)defaultThumbnailData {
    return UIImagePNGRepresentation([UIImage imageNamed:@"Icon"]);
}

- (void)shareToSinaTimeline {
    WBMessageObject *wbMessageObject = [WBMessageObject message];
    wbMessageObject.text = [self _descriptionToShare];
    
    WBWebpageObject *wbWebpageObject = [WBWebpageObject object];
    wbWebpageObject.objectID = @"com.ningtech.edjyun";
    wbWebpageObject.title = [self _titleToShare];
    wbWebpageObject.description = [self _descriptionToShare];
    NSData *thumnailData = UIImagePNGRepresentation([self _imageToShare]);
    wbWebpageObject.thumbnailData = [thumnailData length] / 1024 > 32 ? [self defaultThumbnailData] : thumnailData;
    wbWebpageObject.webpageUrl = [self _urlToShare];
    wbMessageObject.mediaObject = wbWebpageObject;
    
    WBSendMessageToWeiboRequest *weiboRequest = [WBSendMessageToWeiboRequest requestWithMessage:wbMessageObject];
    [WeiboSDK sendRequest:weiboRequest];
    
}

- (void)shareToWeChat:(CMShareType)type {
    WXMediaMessage *msg = [WXMediaMessage message];
    msg.title = [self _titleToShare];
    msg.description = [self _descriptionToShare];
    [msg setThumbImage:[self _imageToShare]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [self _urlToShare];
    
    msg.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = msg;
    req.scene = type;
    
    [WXApi sendReq:req];
}


#pragma mark ---- Share content
- (NSString *)_titleToShare {
    
    if(![_title isKindOfClass:[NSString class]] || _title == nil) {
        return @"";
    }
    return _title;
}

- (NSString *)_urlToShare {
    
    if(![_url isKindOfClass:[NSString class]] || _url == nil) {
        return @"";
    }
    
    return _url;
}

- (NSString *)_descriptionToShare {
    
    if(![_desc isKindOfClass:[NSString class]] || _desc == nil) {
        return @"";
    }
    return _desc;
}

- (UIImage *)_imageToShare {
    UIImage *image = [UIImage imageNamed:@"Icon"];
    if (!_image.length || ![_image isKindOfClass:[NSString class]]) {
        return image;
    }
    if (self.loadedImage) {
        return self.loadedImage;
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_image]];
    
    AFImageDownloader *downloader = [AFImageDownloader defaultInstance];
    NSURLCache *urlCache = downloader.sessionManager.session.configuration.URLCache;
    NSCachedURLResponse *cacheResponse = [urlCache cachedResponseForRequest:urlRequest];
    
    UIImage *cachedImage = [UIImage imageWithData:cacheResponse.data];
    
    if (!cachedImage) {
        cachedImage = image;
    }
    
    if([UIImagePNGRepresentation(cachedImage) length] / 1024 > 32) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), YES, 0.0);
        [cachedImage drawInRect:CGRectMake(0, 0 , 100 , 100)];
        
        UIImage *compressImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return compressImage;
    }
    
    return cachedImage;
}




@end
