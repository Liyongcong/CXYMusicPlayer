//
//  MusicListTableViewCell.h
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/4.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//




/**
 *播放列表自定义cell
 **/

#import <UIKit/UIKit.h>
@class MusicModel;
@interface MusicListTableViewCell : UITableViewCell
//歌手图片
@property (weak, nonatomic) IBOutlet UIImageView *singerImageView;
//歌曲名称
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
//歌手名称
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;
@property (nonatomic, strong)MusicModel *musicModel;

@end
