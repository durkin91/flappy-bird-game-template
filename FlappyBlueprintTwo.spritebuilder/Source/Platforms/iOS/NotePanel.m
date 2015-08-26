//
//  NotePanel.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "NotePanel.h"
#import "Defaults.h"

@implementation NotePanel {
    CCScrollView *_scrollView;
}

- (void) continueButtonTapped {
    
    [self.delegate closeNotePanel];
    
}

- (void) setNote:(Note *)note {
    
    _note = note;
    
    [self displayNoteMessage];
    
    [self saveToViewedNotes];

    
}

- (void)displayNoteMessage {
    
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
    
    //Now concatenate into a string to give the label
    NSMutableArray *allStrings = [NSMutableArray array];
    for (NSMutableArray *line in allLines) {
        
        NSString *string = [line componentsJoinedByString:@" "];
        [allStrings addObject:string];
    }
    
    NSString *finalString = [allStrings componentsJoinedByString:@"\n"];
    messageLabel.string = finalString;
    
}

- (void)saveToViewedNotes {
    NSArray *viewedNotesImmutable = [[NSUserDefaults standardUserDefaults] objectForKey:NOTES_ALREADY_VIEWED];
    NSMutableArray *viewedNotes = [viewedNotesImmutable mutableCopy];
    BOOL needsSaving = YES;
    
    for (NSNumber *number in viewedNotes) {
        if ([number integerValue] == _note.currentNoteNumber) {
            needsSaving = NO;
            break;
        }
    }
    
    if (needsSaving) {
        [viewedNotes addObject:[NSNumber numberWithInteger:_note.currentNoteNumber]];
        viewedNotesImmutable = viewedNotes;
        [[NSUserDefaults standardUserDefaults] setObject:viewedNotesImmutable forKey:NOTES_ALREADY_VIEWED];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSLog(@"Notes already viewed: %@", viewedNotesImmutable);
    
}

@end
