#import "ChatAsyncPhoto.h"
#import "UIColor+JSQMessages.h"
#import "JSQMessagesMediaPlaceholderView.h"
#import "UIImageView+WebCache.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"
@implementation ChatAsyncPhoto
- (instancetype)init
{
    return [self initWithMaskAsOutgoing:YES];
}
- (instancetype)initWithURL:(NSURL *)URL isUserSend:(BOOL)isUserSend imageData:(NSData *)imageData isSuccess:(BOOL)isSuccess{
    self = [super init];
    if (self) {
        CGSize size = [self mediaViewDisplaySize];
        self.asyncImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        self.asyncImageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        self.asyncImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.asyncImageView.clipsToBounds = YES;
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:self.asyncImageView isOutgoing:isUserSend];
        UIView *activityIndicator = [JSQMessagesMediaPlaceholderView viewWithActivityIndicator];
        activityIndicator.frame = self.asyncImageView.frame;
        [self.asyncImageView addSubview:activityIndicator];
        if (imageData==nil) {
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:URL.absoluteString];
            if(image == nil)
            {
                [self.asyncImageView sd_setImageWithURL:URL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (error == nil) {
                        [self.asyncImageView setImage:image];
                        [activityIndicator removeFromSuperview];
                    } else {
                        NSLog(@"Image downloading error: %@", [error localizedDescription]);
                    }
                }];
            } else {
                [self.asyncImageView setImage:image];
                [activityIndicator removeFromSuperview];
            }
        }else{
            if (!isSuccess) {
                [self.asyncImageView setImage:[UIImage imageWithData:imageData]];
                [activityIndicator removeFromSuperview];
            }
        }
    }
    return self;
}
#pragma mark - JSQMessageMediaData protocol
- (UIView *)mediaView
{
    return self.asyncImageView;
}
#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"init coder has not been implemented");
    return self;
}
@end
