//
//  LyricManager.h
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/7.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

/**
 *歌词管理类
 * @since <#1.0#>
 */

#import <Foundation/Foundation.h>

@interface LyricManager : NSObject
/**
 * 单例声明
 * @return instancetype LyricManager 唯一对象
 * @since <#1.0#>
 */

+(instancetype)defaultManager;

/**
 * 格式化歌词 创建歌词模型 并存放进数组
 * @param NSString lyric 歌词数据
 * @since <#1.0#>
 */

-(void)formatLyricModelWithLyric:(NSString *)lyric;


/**
 * 返回数组个数
 *
 * @return NSInterger 数组个数
 * @since <#1.0#>
 */

-(NSInteger)countOfAllLyricModelsArray;


/**
 * 根据下标返回歌词
 * @param index 下标
 * @return NSString 格式化后的歌词
 */

-(NSString *)lyricAtIndex:(NSInteger)index;


/**
 * 根据时间返回下标
 * @param time  播放的时间
 * return index 应该显示的歌词的下标
 */

-(NSInteger)indexOftime:(CGFloat)time;


/**
 * 根据下标指定播放时间
 * @return CGFloat 指定的播放时间
 * @since <#1.0#>
 */

-(CGFloat)progressAtIndex:(NSInteger)index;

@end
