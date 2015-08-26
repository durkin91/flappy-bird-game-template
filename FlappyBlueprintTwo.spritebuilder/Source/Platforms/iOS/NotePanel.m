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
    messageLabel.alignment = CCTextAlignmentCenter;
    
    NSMutableArray *individualWords = [[_note.currentNoteMessage componentsSeparatedByString:@" "] mutableCopy];
    
    CGFloat width = 260;
    NSMutableArray *allLines = [NSMutableArray array];
    
    
    while ([individualWords count] > 0) {
        
        NSMutableArray *newLine = [NSMutableArray array];
        [allLines addObject:newLine];
        
        
        for (NSString *word in individualWords) {
            
            [newLine addObject:word];
            
            messageLabel.string = [newLine componentsJoinedByString:@" "];
            
            if (messageLabel.contentSizeInPoints.width > width) {
                
                [newLine removeObject:word];
                break;
            }
        }
        
        for (NSInteger i = 1; i <= [newLine count]; i++) {
            [individualWords removeObjectAtIndex:0];
        }
    }
    
    NSLog(@"All lines: %@", allLines);
    
    //Now concatenate into a string to give the label
    NSMutableArray *allStrings = [NSMutableArray array];
    for (NSMutableArray *line in allLines) {
        
        NSString *string = [line componentsJoinedByString:@" "];
        [allStrings addObject:string];
    }
    
    NSString *finalString = [allStrings componentsJoinedByString:@"\n"];
    messageLabel.string = finalString;
    
}

@end
