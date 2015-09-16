//
//  MusicPlayViewController.h
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/4.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong)MusicModel *model;
@property (nonatomic, assign)NSInteger index;
@property (weak, nonatomic) IBOutlet UITableView *LyricTableView;

#pragma mark 单例
+(instancetype)shareInstance;



@end
