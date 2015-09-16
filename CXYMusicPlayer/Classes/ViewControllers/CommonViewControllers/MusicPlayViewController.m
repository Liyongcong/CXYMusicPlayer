//
//  MusicPlayViewController.m
//  CXYMusicPlayer
//
//  Created by 陈向阳 on 15/8/4.
//  Copyright (c) 2015年 陈向阳. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "MusicManager.h"
typedef NS_ENUM(NSInteger,PlayType)
{
    OrderPlay, //顺序
    Random, //随机
    Single  //单曲
    
};

@interface MusicPlayViewController ()<UITableViewDataSource,UITableViewDelegate,MusicPlayingDelegate>
{
    NSInteger _currentIndex;//记录当前歌曲模型下标
}
//歌手图片
@property (weak, nonatomic) IBOutlet UIImageView *singerImageView;

@property (weak, nonatomic) IBOutlet UISlider *musicProgressSlider;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;


//枚举  播放方式（随机 单曲  顺序）

@property (assign, nonatomic)PlayType playType;
@end

@implementation MusicPlayViewController

#pragma mark - 单例创建
+(instancetype)shareInstance
{
   static MusicPlayViewController *musicPlay = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicPlay = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"musicPlay"];;
    });
    return musicPlay;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _currentIndex = -1;
    [MusicPlayHelper defaultHelper].delegate = self;
    
    //设置imageView
    [self setImageView];
    self.musicProgressSlider.continuous = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (_currentIndex == self.index) {
        return;
    }else
    {
        _currentIndex = self.index;
        [self updataUI];
    }

}

#pragma mark 更新界面

-(void)updataUI
{
    //设置音乐播放器
    [[MusicPlayHelper defaultHelper] setAVPlayerWithUrl:self.model.mp3Url];
    
    //设置navigationBar title
    for (UINavigationItem *item in self.navigationBar.items) {
        item.title = [[self model] name];
        
    }
    
    //加载歌词 刷新界面
    [[LyricManager defaultManager]formatLyricModelWithLyric:self.model.lyric];
    [self.LyricTableView reloadData];

    
    //设置图片
    [self.singerImageView sd_setImageWithURL:[NSURL URLWithString:self.model.picUrl] placeholderImage:nil];

    CGFloat duration = [self.model.duration floatValue]/1000;
    
    self.musicProgressSlider.maximumValue = duration;
    
    
}

#pragma mark 获取模型
-(MusicModel *)model
{
    
    MusicModel *musicModel = [[MusicManager shareInstance]getMusicModelWithIndex:_currentIndex];
    
    return musicModel;
}


#pragma mark - 设置ImageView
-(void)setImageView
{
    //设置圆角
    [self.singerImageView layoutIfNeeded];
    self.singerImageView.layer.cornerRadius = CGRectGetWidth(self.singerImageView.frame)/2;
    self.singerImageView.layer.masksToBounds = YES;
    
    //设置起始角度为0
    self.singerImageView.transform = CGAffineTransformMakeRotation(0);

    
}

#pragma mark -
#pragma mark 返回按钮点击事件

- (IBAction)backAction:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark 上一曲

- (IBAction)lastMusicAction:(UIButton *)sender {
    
    //先暂停播放
    [[MusicPlayHelper defaultHelper]pauseMusic];
    //获取上一首歌曲模型播放地址 并设置播放器自动播放
    _currentIndex--;
    if (_currentIndex <0) {
        _currentIndex = [[MusicManager shareInstance]musicCount]-1;
    }
    [self updataUI];
}


#pragma mark 停止/播放

- (IBAction)playOrPauseMusicAction:(UIButton *)sender {
    
    BOOL isplaying =[[MusicPlayHelper defaultHelper] playOrPauseMusic];
    if (isplaying) {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }
}

#pragma mark 下一曲

- (IBAction)nextMusicAction:(UIButton *)sender {
    
    /**
     *先暂停播放
     *下标加1
     *获取音乐播放地址
     *切换歌曲播放
     *更新界面信息
     **/
    [[MusicPlayHelper defaultHelper]pauseMusic];
    _currentIndex++;
    if (_currentIndex > [[MusicManager shareInstance]musicCount]-1) {
        _currentIndex = 0;
    }
    [self updataUI];
}


#pragma mark 时间滑竿拖动事件  从指定时间播放

- (IBAction)timeSliderAction:(UISlider *)sender {
    
    CGFloat duration = [[self.model duration]floatValue]/1000;
    if (sender.value >= duration) {
        [[MusicPlayHelper defaultHelper]pauseMusic];
        return;
    }
    [[MusicPlayHelper defaultHelper]seekToTimePlay:sender.value];
}


#pragma mark - 播放模式
#pragma mark 随机
- (IBAction)randomPlay:(UIButton *)sender {
    
    self.playType = Random;
    
    _currentIndex = arc4random()%[[MusicManager shareInstance] musicCount] - 1;
    
    
    if (_currentIndex<0) {
        _currentIndex = [[MusicManager shareInstance] musicCount] - 1;
    }else if (_currentIndex > [[MusicManager shareInstance] musicCount] - 1){
        _currentIndex = 0;
    }
   // 开启立即生效
//    [self updataUI];
    
}

#pragma mark 单曲
- (IBAction)singlePlay:(UIButton *)sender {
    
    self.playType = Single;
    
    //开启立即生效
//    [self updataUI];
}


#pragma mark 顺序
- (IBAction)orderPlay:(UIButton *)sender {
    
    self.playType = OrderPlay;
    _currentIndex++;
    if (_currentIndex<0) {
        _currentIndex = [[MusicManager shareInstance] musicCount] - 1;
    }else if (_currentIndex > [[MusicManager shareInstance] musicCount] - 1){
        _currentIndex = 0;
    }
    
    //更新歌曲信息  开启立即生效
//    [self updataUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LyricManager defaultManager]countOfAllLyricModelsArray];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lyricCell" forIndexPath:indexPath];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.textLabel.text = [[LyricManager defaultManager]lyricAtIndex:indexPath.row];
    
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectedView;
    
    cell.highlighted = YES;
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random() % 256/256.0) blue:(arc4random() % 256/256.0) alpha:1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat time = [[LyricManager defaultManager] progressAtIndex:indexPath.row];
    
    [[MusicPlayHelper defaultHelper]seekToTimePlay:time];
    
}



#pragma mark - MusicPlayHelper 代理方法
#pragma mark 播放过程中执行

-(void)playingWithProgress:(CGFloat)progress
{
    
    //1.图片旋转
    self.singerImageView.transform = CGAffineTransformRotate(self.singerImageView.transform, M_1_PI/180);
    
    
    //2.进度条
    self.musicProgressSlider.value = progress;
    
    //当期播放时间
    self.currentTimeLabel.text =[self changeFormatWithTime:progress];
    
    //剩余时间
    CGFloat duration = [[self.model duration] floatValue]/1000;
    self.durationLabel.text = [self changeFormatWithTime:duration-progress];
    
    
    //获取下标
    NSInteger index = [[LyricManager defaultManager]indexOftime:progress];
    
    //组拼indexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [self.LyricTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}


#pragma mark 播放结束

-(void)playDidToEnd
{
    switch (self.playType) {
        case Random:
        {
            //随机
            [self randomPlay:nil];
            
            break;
        }
           case OrderPlay:
        {
            //顺序
            [self orderPlay:nil];
            break;
        }
            case Single:
        {
            //单曲
            [self singlePlay:nil];
            break;
        }
        default:
            break;
    }
    
    [self updataUI];
    
}


#pragma mark - 转换时间格式

-(NSString *)changeFormatWithTime:(CGFloat)time
{
    //计算分钟
    int minute = time/60;
    //计算秒
    int seconds = (int)time%60;
    
    NSString *timeFormat = [NSString stringWithFormat:@"%02d:%02d",minute,seconds];
    return timeFormat;
}

@end
