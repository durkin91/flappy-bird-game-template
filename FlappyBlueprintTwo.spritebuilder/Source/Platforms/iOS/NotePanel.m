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
    NSMutableArray *lines = [NSMutableArray array];
    
    while ([individualWords count] > 0) {
        
        for (NSString *word in individualWords) {
            
        }
    }
    
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        CCLabelBMFont *label = [CCLabelBMFont labelWithString:@"" fntFile:messageLabel.fntFile];
//        label.position = CGPointMake(messageLabel.position.x, messageLabel.position.y - 50);
//        label.scale = messageLabel.scale;
//        [self addChild:label];
//        
//        for (NSString *string in individualWords) {
//            label.string = [NSString stringWithFormat:@"%@ %@", oneLineMessage, string];
//            
//            if (label.contentSizeInPoints.width > width) {
//                label.string = oneLineMessage;
//                messageLabel = label;
//                break;
//            }
//            
//            else {
//                oneLineMessage = [NSString stringWithFormat:@"%@ %@", oneLineMessage, string];
//                [individualWords removeObject:string];
//            }
    
    }
    
    
    messageLabel.string = _note.currentNoteMessage;
    messageLabel.alignment = CCTextAlignmentCenter;
    [messageLabel setWidth:220.0];

}

@end
