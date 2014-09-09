//
//  ImageDownloader.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-9.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^LoadImage)(id data);

@interface ImageDownloader : NSObject
@property(strong,nonatomic) NSString   * imageUrl;

//开始下载图像
-(void)startDownloadImage:(NSString*)imageUrl andLoadImage:(LoadImage)loadImage;

//从本地加载图像
-(UIImage *)loadLocalImage:(NSString*)imageUrl;

@end
