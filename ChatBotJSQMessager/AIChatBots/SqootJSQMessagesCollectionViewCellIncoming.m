//
//  SqootJSQMessagesCollectionViewCellIncoming.m
//  DeepDetectChatBots
//
//  Created by yangboz on 14/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "SqootJSQMessagesCollectionViewCellIncoming.h"

@implementation SqootJSQMessagesCollectionViewCellIncoming

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.messageBubbleTopLabel setTextAlignment:NSTextAlignmentLeft];
    [self.cellBottomLabel setTextAlignment:NSTextAlignmentLeft];
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"SqootJSQMessagesCollectionViewCellIncoming" bundle:nil];
}

+ (NSString *)cellReuseIdentifier {
    return @"SqootJSQMessagesCollectionViewCellIncoming";
}
@end
