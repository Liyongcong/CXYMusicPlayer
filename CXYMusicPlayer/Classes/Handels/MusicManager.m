//
//  MusicManager.m
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/5.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import "MusicManager.h"
#import "MusicHeader.h"

@interface MusicManager ()
{
    
}
//存放所有模型
@property (nonatomic, strong)NSMutableArray *allModelsArray;

@end

@implementation MusicManager

#pragma mark - 单例
+(instancetype)shareInstance
{
    static MusicManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MusicManager new];
    });
    
    return manager;
}
#pragma mark - 请求数据 并返回
//requestAllDataDidFinish方法的实现
-(void)requestAllDataDidFinish:(void(^)(NSMutableArray * detaArray))result
{
    NSURL *url = [NSURL URLWithString:kMusicUrl];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //同步请求 所以要添加子线程
        NSArray *array = [NSArray arrayWithContentsOfURL:url];
        //拆解数据 封装模型
        for (NSDictionary *item in array) {
            MusicModel *model = [MusicModel new];
            [model setValuesForKeysWithDictionary:item];
            [self.allModelsArray addObject:model];
        }
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用block
            result(self.allModelsArray);
        });
        
    });
    
}
#pragma mark - 根据下标返回模型
-(MusicModel *)getMusicModelWithIndex:(NSInteger)index
{
    NSError *error = nil;
    NSLog(@"function == %s  line == %d  error == %@",__FUNCTION__,__LINE__,error);
    
    MusicModel *model = [self.allModelsArray objectAtIndex:index];
    return model;
}
//懒加载
-(NSMutableArray *)allModelsArray
{

    if (!_allModelsArray) {
        _allModelsArray = [NSMutableArray array];
    }
    
    return _allModelsArray;
}

//重写musicCount  get方法
-(NSInteger)musicCount{
    
    return self.allModelsArray.count;
}
@end
