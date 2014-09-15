//
//  LinkMeStartupService.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-10.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@interface LinkMeStartupService : NSObject
AS_SINGLETON(LinkMeStartupService)

-(void)preStartup;
@end
