//
//  HobbyService.m
//  LinkMe
//
//  Created by Summer Wu on 14-11-21.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HobbyService.h"
#import "HobbyModel.h"

@implementation HobbyService

-(NSArray *)getHobbies
{
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"hobby" ofType:@"json"];
    //==Json数据
    NSData *data=[NSData dataWithContentsOfFile:path];
    //==JsonObject
    
    id jsonString=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *hobbyDic = (NSDictionary*)jsonString;
    NSMutableArray  *hobbyArray = [[NSMutableArray alloc]init];
    for (int i = 1 ; i<= hobbyDic.count ; i++) {
        NSString* key = [NSString stringWithFormat:@"%d",i];
        NSDictionary *dic = [hobbyDic objectForKey:key];
        HobbyModel *hobbyModel = [HobbyModel modelWithJson:dic];
        [hobbyArray addObject:hobbyModel];
    }
    return hobbyArray;
}

@end
