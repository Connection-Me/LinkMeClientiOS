//
//  GroupModel.h
//  LinkMe
//
//  Created by Summer Wu on 14-10-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibModel.h"

@interface GroupModel : LibModel
@property(nonatomic,strong) NSString       *gid;
@property(nonatomic,strong) NSString       *type;
@property(nonatomic,strong) NSString       *description;
@property(nonatomic,strong) NSArray        *pictures;

@property(nonatomic)        NSInteger            memberNumber;
@property(nonatomic,strong) NSArray        *memberList;
@property(nonatomic,strong) NSDate         *foundTime;

@property(nonatomic,strong) NSString       *activityId;

@end
