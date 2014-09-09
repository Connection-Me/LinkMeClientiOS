//
//  ImageDownloader.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-9.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

-(void)startDownloadImage:(NSString *)imageUrl andLoadImage:(LoadImage)loadImage
{
    self.imageUrl = imageUrl;
    
    // 先判断本地沙盒是否已经存在图像，存在直接获取，不存在再下载，下载后保存
    // 存在沙盒的Caches的子文件夹DownloadImages中
    UIImage  * image = [self loadLocalImage:imageUrl];
    if (image == nil) {
        
        // 沙盒中没有，下载
        // 异步下载,分配在程序进程缺省产生的并发队列
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // 多线程中下载图像--->方便简洁写法
            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            // 缓存图片
            [imageData writeToFile:[self imageFilePath:imageUrl] atomically:YES];
            
            // 回到主线程完成UI设置
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage * image = [UIImage imageWithData:imageData];
                
                /**
                 *  ............  进行UI设置
                 *  ............  imageView.image = image;
                 *  也可以利用blcok,将image对象传到别处去
                 */
                loadImage(image);
                
            });
        });
    }
    else
    {
        loadImage(image);
    }
}

#pragma mark - 加载本地图像
- (UIImage *)loadLocalImage:(NSString *)imageUrl
{
    
    self.imageUrl = imageUrl;
    
    // 获取图像路径
    NSString * filePath = [self imageFilePath:self.imageUrl];
    
    UIImage * image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image != nil) {
        return image;
    }
    
    return nil;
    
}

#pragma mark - 获取图像路径
- (NSString *)imageFilePath:(NSString *)imageUrl
{
    // 获取caches文件夹路径
    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSLog(@"caches = %@",cachesPath);
    
    // 创建DownloadImages文件夹
    NSString * downloadImagesPath = [cachesPath stringByAppendingPathComponent:@"DownloadImages"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:downloadImagesPath]) {
        
        [fileManager createDirectoryAtPath:downloadImagesPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
#pragma mark 拼接图像文件在沙盒中的路径,因为图像URL有"/",要在存入前替换掉,随意用"_"代替
    NSString * imageName = [imageUrl stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString * imageFilePath = [downloadImagesPath stringByAppendingPathComponent:imageName];
    
    return imageFilePath;
}

@end
