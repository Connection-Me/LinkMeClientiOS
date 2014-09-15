//
//  summer_extend.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#ifndef LinkMe_summer_extend_h
#define LinkMe_summer_extend_h

#define	SUMMER_DEF_XIB(__xibName,portrait,landscape) \
-(id) init \
{ \
    static NSString * __local = nil; \
    if ( nil == __local ) \
    { \
        __local = [NSString stringWithFormat:@"%s", #__xibName]; \
    } \
    self = [self initWithNibName:__local bundle:nil]; \
    if(self) \
    { \
        self.allowedPortrait = portrait; \
        self.allowedLandscape = landscape; \
    } \
    return self;\
}

#define LINK_APP_DOCUMENT_PATH \
[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#endif

