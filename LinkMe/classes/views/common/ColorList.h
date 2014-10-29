//
//  ColorList.h
//  LinkMe
//
//  Created by ChaoSo on 14-10-28.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#define OPAQUE_COLOR(R, G, B) \
([UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:1])


//黑色
#define COLOR_HEADER OPAQUE_COLOR(39,39,39)

//背景黑色
#define COLOR_BACK_GROUND OPAQUE_COLOR(39,39,39)

//控件背景颜色
#define COLOR_COMPONENT_BACKGROUND OPAQUE_COLOR(78,90,105)

//高基红
#define COLOR_LIGHT_RED OPAQUE_COLOR(245,132,133)
//高基绿
#define COLOR_LIGHT_GREEN OPAQUE_COLOR(29,159,73)
//高基黄
#define COLOR_LIGHT_YELLOW OPAQUE_COLOR(254,198,130)

#define COLOR_LIGHT_GRAY OPAQUE_COLOR(153,153,153)
@interface ColorList : NSObject


@end
