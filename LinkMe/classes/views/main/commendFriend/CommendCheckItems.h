//
//  CommendCheckItems.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@interface CommendCheckItems : NSObject

AS_SINGLETON(CommendCheckItems)

-(NSMutableArray*) checkedItems;
-(BOOL)isCheckItems:(NSObject*)item;
-(void)clear;
-(void)addToCheckItems:(NSObject*)item;
-(void)addToUnCheckItems:(NSObject*)item;

@end
