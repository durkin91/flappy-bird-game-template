//
//  Note.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Note.h"
#import "Defaults.h"
#import "Data.h"

@implementation Note {
    NSMutableArray *_notesAwaitingDisplay;
}


- (void) setIsActive:(BOOL)isActive {
    
    _isActive = isActive;
    
    if (isActive) {
        NSArray *notesAwaitingDisplayImmutable = [[NSUserDefaults standardUserDefaults] objectForKey:NOTES_AWAITING_DISPLAY];
        
        if (notesAwaitingDisplayImmutable) {
            _notesAwaitingDisplay = [notesAwaitingDisplayImmutable mutableCopy];
        }
        else {
            _notesAwaitingDisplay = [NSMutableArray array];
        }
        
        if ([_notesAwaitingDisplay count] == 0) {
            _notesAwaitingDisplay = [[Data notesData] mutableCopy];
        }
        
        //Pick a random note
        NSInteger randomIndex = arc4random_uniform([_notesAwaitingDisplay count]);
        NSDictionary *currentNote = _notesAwaitingDisplay[randomIndex];
        
        [_notesAwaitingDisplay removeObjectAtIndex:randomIndex];
        
        _currentNoteMessage = [currentNote objectForKey:NOTE_MESSAGE_KEY];
        _currentNoteNumber = [[currentNote objectForKey:NOTE_NUMBER_KEY] integerValue];
        
        [[NSUserDefaults standardUserDefaults] setObject:[_notesAwaitingDisplay copy] forKey:NOTES_AWAITING_DISPLAY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



@end
