//
//  SqootJSQMessagesCollectionViewCellOutgoing.m
//  DeepDetectChatBots
//
//  Created by yangboz on 14/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "SqootJSQMessagesCollectionViewCellOutgoing.h"

@implementation SqootJSQMessagesCollectionViewCellOutgoing

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.messageBubbleTopLabel setTextAlignment:NSTextAlignmentRight];
    [self.cellBottomLabel setTextAlignment:NSTextAlignmentRight];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"SqootJSQMessagesCollectionViewCellOutgoing" bundle:nil];
}

+ (NSString *)cellReuseIdentifier {
    return @"SqootJSQMessagesCollectionViewCellOutgoing";
}
@end
