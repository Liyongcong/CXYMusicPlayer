//
//  MusicModel.h
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/5.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject
@property (nonatomic, copy) NSString *mp3Url;   // 音乐地址
@property (nonatomic, copy) NSString *ID;       // 应为id
@property (nonatomic, copy) NSString *name;     // 歌名
@property (nonatomic, copy) NSString *picUrl;   // 图片地址
@property (nonatomic, copy) NSString *blurPicUrl;   // 模糊图片地址
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *singer;   // 歌手
@property (nonatomic, copy) NSString *duration; // 时间
@property (nonatomic, copy) NSString *artists_name; // 歌手名字
@property (nonatomic, copy) NSString *lyric;    // 歌词
@end
