//
//  MusicListTableViewCell.m
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/4.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import "MusicListTableViewCell.h"
@implementation MusicListTableViewCell

//重写set方法
-(void)setMusicModel:(MusicModel *)musicModel
{
    [self.singerImageView sd_setImageWithURL:[NSURL URLWithString:  musicModel.picUrl] placeholderImage:nil];
    self.singerNameLabel.text = musicModel.singer;
    self.musicNameLabel.text = musicModel.name;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
