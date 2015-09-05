//
//  GiftInfo.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GiftInfo.h"
#import "Options.h"
#import "Data.h"

@implementation GiftInfo {
    
    CCLabelBMFont *_messageLabel;
    CCNodeGradient *_gradientNode;
}

- (void)didLoadFromCCB {
    
    _messageLabel.alignment = CCTextAlignmentCenter;
    
    _gradientNode.startColor = [Data startColorForGradientNode];
    _gradientNode.endColor = [Data endColorForGradientNode];
    
}

- (void) homeButtonTapped {
    
    [Options playTapSound];
    
    CCScene *homeScene = [CCBReader loadAsScene:@"MainMenu"];
    [[CCDirector sharedDirector] replaceScene:homeScene];

}

@end
