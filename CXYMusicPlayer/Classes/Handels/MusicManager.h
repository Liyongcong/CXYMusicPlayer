//
//  MusicManager.h
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/5.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicModel;
@interface MusicManager : NSObject


#pragma mark - 单例
+(MusicManager *)shareInstance;

/*
 **根据url请求数据
 **@param url 接口
 **@param result 请求完成后会执行此block
 **@param dataArray 返回请求到的数据
 */
-(void)requestAllDataDidFinish:(void(^)(NSMutableArray * dataArray))result;

/*
 **根据下标返回模型
 **@param index 下标
 */
-(MusicModel *)getMusicModelWithIndex:(NSInteger)index;

/*
 **返回数组个数
 **
 */
-(NSInteger)musicCount;
@end
