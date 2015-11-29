//
//  EmotionKeyBoard.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "EmotionKeyBoard.h"
#import "EmotionTabBar.h"
#import "EmotionView.h"
#import "Emotion.h"
#import "MJExtension.h"

@interface EmotionKeyBoard ()<EmotionTabBarDelegate>
/** 最近表情栏 */
@property (strong, nonatomic) EmotionView *emotionRecentView;
/** 默认表情栏 */
@property (strong, nonatomic) EmotionView *emotionDefaultView;
/** Emoji表情栏 */
@property (strong, nonatomic) EmotionView *emotionEmojiView;
/** 浪小花表情栏 */
@property (strong, nonatomic) EmotionView *emotionLXHView;
/** 盛具 */
@property (weak, nonatomic) UIView *contentView;
/** 切换表情栏*/
@property (weak, nonatomic) EmotionTabBar *tabBar;
@end

@implementation EmotionKeyBoard
#pragma mark 懒加载
/**
 *  最近表情
 */
-(EmotionView *)emotionRecentView
{
    if (_emotionRecentView==nil) {
        _emotionRecentView=[[EmotionView alloc]init];
    }
    return _emotionRecentView;
}
/**
 *  默认表情
 */
-(EmotionView *)emotionDefaultView
{
    if (_emotionDefaultView==nil) {
        _emotionDefaultView=[[EmotionView alloc]init];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        NSArray *emtionArray=[Emotion mj_objectArrayWithKeyValuesArray:array];
        _emotionDefaultView.emotions=emtionArray;
    }
    return _emotionDefaultView;
}
/**
 *  Emoji表情
 */
-(EmotionView *)emotionEmojiView
{
    if (_emotionEmojiView==nil) {
        _emotionEmojiView=[[EmotionView alloc]init];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        NSArray *emtionArray=[Emotion mj_objectArrayWithKeyValuesArray:array];
        _emotionEmojiView.emotions=emtionArray;
    }
    return _emotionEmojiView;
}

/**
 *  LXH表情
 */
-(EmotionView *)emotionLXHView
{
    if (_emotionLXHView==nil) {
        _emotionLXHView=[[EmotionView alloc]init];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        NSArray *emtionArray=[Emotion mj_objectArrayWithKeyValuesArray:array];
        _emotionLXHView.emotions=emtionArray;
    }
    return _emotionLXHView;
}

#pragma mark 生命周期
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        EmotionTabBar *tabBar=[[EmotionTabBar alloc]init];
        tabBar.backgroundColor=RandomColor;
        tabBar.delegate=self;
        [self addSubview:tabBar];
        self.tabBar=tabBar;

        UIView *comtentView=[[UIView alloc]init];

        [self addSubview:comtentView];
        self.contentView=comtentView;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat tabBarW=self.width;
    CGFloat tabBarH=37;
    CGFloat tabBarX=0;
    CGFloat tabBarY=self.height-tabBarH;
    self.tabBar.frame=CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);

    CGFloat emotionW=self.width;
    CGFloat emotionH=tabBarY;
    CGFloat emotionX=0;
    CGFloat emotionY=0;
    self.contentView.frame=CGRectMake(emotionX, emotionY, emotionW, emotionH);
    
    [self.contentView.subviews lastObject].frame=self.contentView.bounds;
    
}

-(void)emotionTabBar:(EmotionTabBar *)emotionTabBar selectedButtonOfType:(EmotionTabBarButtonType)type
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (type) {
        case EmotionTabBarButtonRecent:{
            [self.contentView addSubview:self.emotionRecentView];
            break;
        }
        case EmotionTabBarButtonDefault:{
            [self.contentView addSubview:self.emotionDefaultView];
            break;
        }
        case EmotionTabBarButtonEmoji:{
            [self.contentView addSubview:self.emotionEmojiView];
            break;
        }
        case EmotionTabBarButtonLXH:{
            [self.contentView addSubview:self.emotionLXHView];
            break;
        }
        default: return;
    }
    
    [self setNeedsLayout];

}
@end
