//
//  NotePanel.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "NotePanel.h"

@implementation NotePanel {
    CCScrollView *_scrollView;
}

- (void) continueButtonTapped {
    
    [self.delegate closeNotePanel];
    
}

- (void) setNote:(Note *)note {
    
    _note = note;

    CCLabelBMFont *messageLabel = (CCLabelBMFont *)[_scrollView.contentNode getChildByName:@"message" recursively:YES];
    
    NSMutableArray *individualWords = [[_note.currentNoteMessage componentsSeparatedByString:@" "] mutableCopy];
    NSLog(@"%@", individualWords);
    
    float width = 220;
    NSString *oneLineMessage;
    while ([individualWords count] > 0) {
        
        for (NSString *string in individualWords) {
            messageLabel.string = [NSString stringWithFormat:@"%@ %@", oneLineMessage, string];
            
            if (messageLabel.contentSizeInPoints.width > width) {
                messageLabel.string = oneLineMessage;
            }
        }
        
    }
    
    
    messageLabel.string = _note.currentNoteMessage;
    messageLabel.alignment = CCTextAlignmentCenter;
    [messageLabel setWidth:220.0];

}

@end
