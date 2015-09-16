//
//  MusicListTableViewController.m
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/4.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import "MusicListTableViewController.h"
#import "MusicListTableViewCell.h"
#import "MusicPlayViewController.h"
#import "MusicManager.h"
@interface MusicListTableViewController ()
@property(nonatomic, strong)NSArray *musicArray;
@end

@implementation MusicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicListTableViewCell" bundle:nil]
    forCellReuseIdentifier:@"cell"];
    
  [[MusicManager shareInstance] requestAllDataDidFinish:^(NSMutableArray *dataArray) {
      
      self.musicArray = dataArray;
      
      [self.tableView reloadData];
      
  }];
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.musicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    //获取每行对应的音乐模型
    MusicModel *model = [[MusicManager shareInstance]getMusicModelWithIndex:indexPath.row];
    
    cell.textLabel.highlighted = YES;
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    
    //给cell上的控件赋值
    cell.musicModel = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MusicPlayViewController * musicPlayVC = [MusicPlayViewController shareInstance];
 
    musicPlayVC.modalTransitionStyle = 1;
    musicPlayVC.index = indexPath.row;
    [self.navigationController presentViewController:musicPlayVC animated:YES completion:nil];
    
}

#pragma mark -懒加载
-(NSArray *)musicArray
{
    if (!_musicArray) {
        _musicArray = [NSArray array];
    }
    return _musicArray;
}

@end
