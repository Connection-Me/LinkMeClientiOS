//
//  ActivityModel.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibModel.h"

@interface ActivityModel :LibModel

@property(nonatomic) NSInteger           joinPeople;
@property(strong,nonatomic) NSString   * imagePath;
@property(strong,nonatomic) NSDate     * startTime;

@end
