//
//  LyricManager.m
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/7.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import "LyricManager.h"

@interface LyricManager ()

//存放一首歌的歌词模型
@property(nonatomic, strong) NSMutableArray *allLyricModelsArray;

@end
@implementation LyricManager

#pragma mark - 单例创建

+(instancetype)defaultManager
{
    static LyricManager *lyricManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
     
        lyricManager = [LyricManager new];
        
        //初始化数组
        lyricManager.allLyricModelsArray = [NSMutableArray array];
    });
    
    return lyricManager;
}


#pragma mark - 格式化歌词

-(void)formatLyricModelWithLyric:(NSString *)lyric
{
    //先移除数组中的数据
    [self.allLyricModelsArray removeAllObjects];
    
    //切分每一行歌词 根据换行符"\n"
    NSArray *conentArray = [lyric componentsSeparatedByString:@"\n"];
    
    //遍历歌词数组 格式化歌词 组装模型 并存放进数组
    for (int i = 0; i < conentArray.count - 1; i++) {
        
        //获得每行歌词源数据
        NSString *sourceStr = conentArray[i];
    
        //歌词数据源：[00:4532 如果能重来] 根据"]"拆分时间和歌词
        NSArray *lyricArray = [sourceStr componentsSeparatedByString:@"]"];
        
        //如果字符串长度小于1 直接跳出
        if ([lyricArray.firstObject length] < 1) {
            break;
        }
        
        //时间 lyricArray.firstObject格式为"[00:4523" 所以需要从1开始获取
        NSString *timeStr = [lyricArray.firstObject substringFromIndex:1];
        
        //time格式为 00：4523 所以需要去掉":"
        NSArray *timeArray = [timeStr componentsSeparatedByString:@":"];
        
        //算出总时间 以秒为单位
        CGFloat timeTotal = [timeArray.firstObject floatValue] * 60 + [timeArray.lastObject floatValue];
        
        //歌词
        NSString *lyricStr = lyricArray.lastObject;
        
        //初始化歌词模型
        LyricModel *lyricModel = [LyricModel new];
        
        //歌词时间
        lyricModel.time = timeTotal;
        
        //歌词
        lyricModel.lytric = lyricStr;
        
        //将模型存放进数组
        [self.allLyricModelsArray addObject:lyricModel];
        
    }
    
}


#pragma mark 根据下标返回歌词
-(NSString *)lyricAtIndex:(NSInteger)index
{
    LyricModel *lyricModel = [self.allLyricModelsArray objectAtIndex:index];
    
    return lyricModel.lytric;
}


#pragma mark 根据时间返回下标
-(NSInteger)indexOftime:(CGFloat)time
{
    NSInteger index = 0;
    for (int i = 0; i < self.allLyricModelsArray.count -1; i++) {
        
        LyricModel *lyricModel = self.allLyricModelsArray[i];
        if ( lyricModel.time > time) {
            
            index = i-1 > 0 ? i-1 : 0;
            break;
        }
    }
    
    return index;
}


#pragma mark 根据下标返回播放时间
-(CGFloat)progressAtIndex:(NSInteger)index
{
    LyricModel *lyricModel = self.allLyricModelsArray[index];
    
    CGFloat time = lyricModel.time;
    
    return time;
}

#pragma mark 返回数组个数
-(NSInteger)countOfAllLyricModelsArray
{
    return self.allLyricModelsArray.count;
}



@end
