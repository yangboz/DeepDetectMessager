//
//  ChatAsyncPhoto.h
//  DeepDetectChatBots
//
//  Created by yangboz on 31/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "JSQPhotoMediaItem.h"
@interface ChatAsyncPhoto : JSQPhotoMediaItem
@property (nonatomic, strong) UIImageView *asyncImageView;
- (instancetype)initWithURL:(NSURL *)URL isUserSend:(BOOL)isUserSend imageData:(NSData *)imageData isSuccess:(BOOL)isSuccess;
@end



