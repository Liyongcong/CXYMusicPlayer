//
//  MusicModel.m
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/5.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID  = value;
    }
}
@end
