//
//  EmotionView.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "EmotionView.h"
#import "OneEmotionView.h"

#define MAXEmotionInOnepage  20

@interface EmotionView () <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;

@property (weak, nonatomic) UIPageControl *pageControl;
@end
@implementation EmotionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.pagingEnabled=YES;
        scrollView.delegate=self;
        scrollView.bounces=NO;
        [self addSubview:scrollView];
        self.scrollView=scrollView;
        
        UIPageControl *pageControl=[[UIPageControl alloc]init];
        pageControl.pageIndicatorTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_normal"]];
        pageControl.currentPageIndicatorTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_selected"]];
        pageControl.backgroundColor=RandomColor;
        pageControl.enabled=NO;
        [self addSubview:pageControl];
        
        self.pageControl=pageControl;
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions=emotions;
    int count=(self.emotions.count+MAXEmotionInOnepage-1)/MAXEmotionInOnepage;
    //  1、设置页数
    self.pageControl.numberOfPages=count;
    NSLog(@"%@",self.pageControl.backgroundColor);
    
    //  2、设置滚动视图
    for (int i=0; i<count; i++) {
        OneEmotionView *view=[[OneEmotionView alloc]init];
        view.backgroundColor=RandomColor;
        
        NSRange range;
        range.location=i*MAXEmotionInOnepage;
        
        if (emotions.count-range.location<20) {
            range.length=emotions.count-range.location;
        }else{
            range.length=MAXEmotionInOnepage;
        }

        view.emotions=[emotions subarrayWithRange:range];
        [self.scrollView addSubview:view];
    }
    
    

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count=(self.emotions.count+MAXEmotionInOnepage-1)/MAXEmotionInOnepage;
    CGFloat pageControlW=self.width;
    CGFloat pageControlH=35;
    CGFloat pageControlX=0;
    CGFloat pageControlY=self.height-pageControlH;
    self.pageControl.frame=CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    CGFloat scrollViewW = self.width;
    CGFloat scrollViewH=pageControlY;
    CGFloat scrollViewX=0;
    CGFloat scrollViewY=0;
    self.scrollView.frame=CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    
    for (int i=0; i<count; i++) {
        UIView *vive=self.scrollView.subviews[i];
        vive.width=self.width;
        vive.height=self.scrollView.height;
        vive.x=i*self.width;
    }
    
    self.scrollView.contentSize=CGSizeMake(count*self.width, 0);
    

}
#pragma mark -uiscrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    int pagecount=(int)((double)self.scrollView.contentOffset.x/self.width+0.5);
    self.pageControl.currentPage=pagecount;

}
@end
