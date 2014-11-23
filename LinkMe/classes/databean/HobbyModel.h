//
//  HobbyModel.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-21.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibModel.h"

@interface HobbyModel : LibModel

@property(nonatomic) NSInteger  hid;
@property(strong,nonatomic) NSString  *name;
@property(strong,nonatomic) NSString  *desc;

@end
