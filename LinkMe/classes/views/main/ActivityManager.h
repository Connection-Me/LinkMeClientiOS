//
//  ActivityManager.h
//  LinkMe
//
//  Created by ChaoSo on 14-10-29.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"
#import "AddActivityVC.h"
@interface ActivityManager : NSObject
AS_SINGLETON(ActivityManager)

-(void)setAddPageTextFieldImage:(AddActivityVC *)addPage;
@end
