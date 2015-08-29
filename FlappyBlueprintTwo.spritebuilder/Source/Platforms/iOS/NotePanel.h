//
//  NotePanel.h
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Note.h"

@protocol NotePanelDelegate <NSObject>

@required

- (void)closeNotePanel;

@end

@interface NotePanel : CCNode

@property (weak, nonatomic) id <NotePanelDelegate> delegate;

@property (strong, nonatomic) Note *note;

- (void)displayNoteMessage;
- (void)saveToViewedNotes;

@end
