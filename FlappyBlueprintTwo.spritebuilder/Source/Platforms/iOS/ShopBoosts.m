//
//  ShopBoosts.m
//  FlappyBlueprintTwo
/*
 * Copyright (c) 2014 Rebeloper. All rights reserved.
 *
 *      http://www.rebeloper.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either expressed or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "ShopBoosts.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "InsufficientFundsException.h"
#import "Defaults.h"
#import "ProgressHUD.h"
#import "Options.h"

@implementation ShopBoosts {
    
    CCLabelBMFont *_allCoinsLabel;
    NSUInteger allCoins;
    NSUInteger manualyRefreshedAllCoins;
    NSString *allCoinsString;
    
    CCLabelBMFont *_headStartLabel;
    NSUInteger headStarts;
    NSString *headStartsString;
    
    CCLabelTTF *_headStartPackLabel;
    NSUInteger headStartPacks;
    NSString *headStartPacksString;
    
    CCLabelBMFont *_superHeadStartLabel;
    NSUInteger superHeadStarts;
    NSString *superHeadStartsString;
    
    CCLabelBMFont *_finalBlastLabel;
    NSUInteger finalBlasts;
    NSString *finalBlastString;
    
    NSString *confirmAlertMessage;
}

- (void)didLoadFromCCB {
    
    [self refreshAllCoinsBalance];
    [self refreshHeadStartsBalance];
    [self refreshSuperHeadStartsBalance];
    [self refreshFinalBlastBalance];
    
    [self addCoinsLabel];
    [self addBoostsCountLabels];
    
}

- (void) addCoinsLabel {
    _allCoinsLabel = [CCLabelBMFont labelWithString:allCoinsString fntFile:@"MyAwesomeBMFont.fnt"];
    _allCoinsLabel.anchorPoint = ccp(1.0, 0.5);
    _allCoinsLabel.position = ccp(280, 500);
    _allCoinsLabel.scale = 0.7f;
    
    [self addChild:_allCoinsLabel];
}

- (void) addBoostsCountLabels {
    _headStartLabel = [CCLabelBMFont labelWithString:headStartsString fntFile:@"MyAwesomeBMFont.fnt"];
    _headStartLabel.anchorPoint = ccp(0.5, 0.5);
    _headStartLabel.position = ccp(108, 251);
    _headStartLabel.scale = 0.2;
    
    [self addChild:_headStartLabel];
    
    _superHeadStartLabel = [CCLabelBMFont labelWithString:superHeadStartsString fntFile:@"MyAwesomeBMFont.fnt"];
    _superHeadStartLabel.anchorPoint = ccp(0.5, 0.5);
    _superHeadStartLabel.position = ccp(205, 251);
    _superHeadStartLabel.scale = 0.2;
    
    [self addChild:_superHeadStartLabel];
    
    _finalBlastLabel = [CCLabelBMFont labelWithString:finalBlastString fntFile:@"MyAwesomeBMFont.fnt"];
    _finalBlastLabel.anchorPoint = ccp(0.5, 0.5);
    _finalBlastLabel.position = ccp(301, 251);
    _finalBlastLabel.scale = 0.2;
    
    [self addChild:_finalBlastLabel];
}

- (void) boost01Tapped {
    [Options playTapSound];
    
    confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_HEAD_START_NAME, (long)BOOSTS_HEAD_START_PRICE, VIRTUAL_CURRENCY_NAME];
    [self showConfirmPurchaseAlertWithTag:1];
}

- (void) boost02Tapped {
    [Options playTapSound];
    
    confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_SUPER_HEAD_START_NAME, (long)BOOSTS_SUPER_HEAD_START_PRICE, VIRTUAL_CURRENCY_NAME];
    [self showConfirmPurchaseAlertWithTag:2];
}

- (void) boost03Tapped {
    [Options playTapSound];
    
    confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_SAVE_ME_NAME, (long)BOOSTS_FINAL_BLAST_PRICE, VIRTUAL_CURRENCY_NAME];
    [self showConfirmPurchaseAlertWithTag:3];
}

- (void) boost04Tapped {
    [Options playTapSound];
    
    confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_HEAD_START_PACK_NAME, (long)BOOSTS_HEAD_START_PACK_PRICE, VIRTUAL_CURRENCY_NAME];
    [self showConfirmPurchaseAlertWithTag:4];
}

- (void) boost05Tapped {
    [Options playTapSound];
    
    confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_SUPER_HEAD_START_PACK_NAME, (long)BOOSTS_SUPER_HEAD_START_PACK_PRICE, VIRTUAL_CURRENCY_NAME];
    [self showConfirmPurchaseAlertWithTag:5];
}

- (void) boost06Tapped {
    [Options playTapSound];
    
    confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_SAVE_ME_PACK_NAME, (long)BOOSTS_FINAL_BLAST_PACK_PRICE, VIRTUAL_CURRENCY_NAME];
    [self showConfirmPurchaseAlertWithTag:6];
}

- (void) shopCoinsTapped {
    [Options playTapSound];
    
    CCScene *shopCoinsScene = [CCBReader loadAsScene:@"ShopCoins"];
    [[CCDirector sharedDirector] replaceScene:shopCoinsScene];
}

- (void) backButtonTapped {
    [Options playTapSound];
    
    CCScene *shopScene = [CCBReader loadAsScene:@"ShopMenu"];
    [[CCDirector sharedDirector] replaceScene:shopScene];
}

- (void) showInsuficientFundsAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:INSUFICIENT_FUNDS_ALERT_TITLE
                                                    message:INSUFICIENT_FUNDS_ALERT_DESCRIPTION
                                                   delegate:self
                                          cancelButtonTitle:INSUFICIENT_FUNDS_ALERT_NO_BUTTON
                                          otherButtonTitles:INSUFICIENT_FUNDS_ALERT_YES_BUTTON, nil];
    alert.tag = 100;
    [alert show];
}

- (void) showConfirmPurchaseAlertWithTag:(int) tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CONFIRM_PURCHASE_ALERT_TITLE
                                                    message:confirmAlertMessage
                                                   delegate:self
                                          cancelButtonTitle:CONFIRM_PURCHASE_ALERT_NO_BUTTON
                                          otherButtonTitles:CONFIRM_PURCHASE_ALERT_YES_BUTTON, nil];
    alert.tag = tag;
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ((alertView.tag == 1) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:HEAD_START_GOOD_ITEM_ID andPayload:@"headStart"];
            
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
            [self refreshHeadStartsBalance];
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 2) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:SUPER_HEAD_START_GOOD_ITEM_ID andPayload:@"superHeadStart"];
            
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
            [self refreshSuperHeadStartsBalance];
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 3) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:FINAL_BLAST_GOOD_ITEM_ID andPayload:@"finalBlast"];
            
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
            [self refreshFinalBlastBalance];
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 4) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:HEAD_START_PACK_GOOD_ITEM_ID andPayload:@"headStartPack"];
            
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
            [self refreshHeadStartsBalance];
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];;
        }
        
        
    }
    
    if ((alertView.tag == 5) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:SUPER_HEAD_START_PACK_GOOD_ITEM_ID andPayload:@"superHeadStartPack"];
            
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
            [self refreshSuperHeadStartsBalance];
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 6) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:FINAL_BLAST_PACK_GOOD_ITEM_ID andPayload:@"finalBlastPack"];
            
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
            [self refreshFinalBlastBalance];
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    
    // going to shop coins view
    if ((alertView.tag == 100) & (buttonIndex == 1)){
        
        CCScene *shopScene = [CCBReader loadAsScene:@"ShopCoins"];
        [[CCDirector sharedDirector] pushScene:shopScene];
    }
}

- (void) refreshAllCoinsBalance {
    // getting the number of all coins
    allCoins = [StoreInventory getItemBalance:COINS_CURRENCY_ITEM_ID];
    allCoinsString = [NSString stringWithFormat:@"%li",(long)allCoins];
    _allCoinsLabel.string = allCoinsString;
    
}

- (void) refreshHeadStartsBalance {
    // getting the number of all the head starts
    headStarts = [StoreInventory getItemBalance:HEAD_START_GOOD_ITEM_ID];
    headStartsString = [NSString stringWithFormat:@"%li",(long)headStarts];
    _headStartLabel.string = headStartsString;
}

- (void) refreshSuperHeadStartsBalance {
    // getting the number of all the head starts
    superHeadStarts = [StoreInventory getItemBalance:SUPER_HEAD_START_GOOD_ITEM_ID];
    superHeadStartsString = [NSString stringWithFormat:@"%li",(long)superHeadStarts];
    _superHeadStartLabel.string = superHeadStartsString;
}

- (void) refreshFinalBlastBalance {
    // getting the number of all the head starts
    finalBlasts = [StoreInventory getItemBalance:FINAL_BLAST_GOOD_ITEM_ID];
    finalBlastString = [NSString stringWithFormat:@"%li",(long)finalBlasts];
    _finalBlastLabel.string = finalBlastString;
}



@end
