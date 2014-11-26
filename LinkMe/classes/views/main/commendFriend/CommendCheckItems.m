//
//  CommendCheckItems.m
//  LinkMe
//
//  Created by Summer Wu on 14-11-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "CommendCheckItems.h"

@implementation CommendCheckItems
{
    NSMutableArray * _checkedItems;
    NSMutableArray * unCheckedItems;
}
DEF_SINGLETON(CommendCheckItems)

-(id)init
{
    self = [super init];
    if(self)
    {
        _checkedItems = [NSMutableArray array];
        unCheckedItems = [NSMutableArray array];
    }
    return  self;
}

-(NSMutableArray*) checkedItems
{
    return _checkedItems;
}

-(BOOL)isCheckItems:(NSObject*)item
{
    return [_checkedItems containsObject:item];
}

-(void)clear
{
    [_checkedItems removeAllObjects];
    [unCheckedItems removeAllObjects];
}

-(void)addToCheckItems:(NSObject*)item
{
    if([unCheckedItems containsObject:item])
    {
        [unCheckedItems removeObject:item];
    }
    if(![_checkedItems containsObject:item])
    {
        [_checkedItems addObject:item];
    }
}

-(void)addToUnCheckItems:(NSObject*)item
{
    if([_checkedItems containsObject:item])
    {
        [_checkedItems removeObject:item];
    }
    if(![unCheckedItems containsObject:item])
    {
        [unCheckedItems addObject:item];
    }
}
@end
