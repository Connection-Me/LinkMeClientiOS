//
//  UserModel.h
//  LinkMe
//
//  Created by Summer Wu on 14-10-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibModel.h"

@interface UserModel : LibModel

@property(nonatomic,strong) NSString       *uid;
@property(nonatomic,strong) NSString       *userName;
@property(nonatomic,strong) NSDate         *registerTime;
@property(nonatomic,strong) NSString       *weibo;
@property(nonatomic,strong) NSString       *wechat;
@property(nonatomic,strong) NSString       *profile;
@property(nonatomic,strong) NSString       *nickName;
@property(nonatomic,strong) NSDate         *lastLoginTime;
@property(nonatomic,strong) NSDate         *lastLogoutTime;
@property(nonatomic,strong) NSArray        *groupList;
@property(nonatomic,strong) NSArray        *activityList;

@end
