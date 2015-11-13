//
//  NewfeatureController.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/12.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "NewfeatureController.h"
#import "MainViewController.h"

#define numberOfPicInNewFeature 4
#define screenW self.view.width
#define screenH self.view.height


@interface NewfeatureController () <UIScrollViewDelegate>
@property (strong, nonatomic) UIPageControl *pageControl;


@end

@implementation NewfeatureController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    scrollView.frame=self.view.bounds;
    scrollView.contentSize=CGSizeMake(numberOfPicInNewFeature*screenW, 0);
    scrollView.pagingEnabled=YES;
    scrollView.bounces=NO;
    scrollView.showsHorizontalScrollIndicator=NO;

    
    for (int i=0; i<numberOfPicInNewFeature; i++) {
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.height=screenH;
        imageView.width=screenW;
        imageView.x=i*screenW;
        NSString *iconName=[NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image=[UIImage imageNamed:iconName];
        if (i==numberOfPicInNewFeature-1) {
            [self setupLastImageView:(UIImageView *)imageView];
        }
        
        [scrollView addSubview:imageView];
    }
    
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    
    UIPageControl *pageControl=[[UIPageControl alloc]init];
    

    pageControl.centerX=screenW/2;
    pageControl.y=screenH-50;
    

    pageControl.numberOfPages=numberOfPicInNewFeature;
    pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    pageControl.pageIndicatorTintColor=[UIColor colorWithRed:189 green:189 blue:189 alpha:1.0];
 
    self.pageControl=pageControl;
    [self.view addSubview:pageControl];
    

}
/**
 *  设置最后一个imageview中的按钮
 */
-(void)setupLastImageView:(UIImageView *)imageView
{
    NSString *title=@"分享给大家";
    
    UIButton *shareButton=[[UIButton alloc]init];
    [shareButton setTitle:title forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    shareButton.width=200;
    shareButton.height=30;
    shareButton.centerX=screenW*0.5;
    shareButton.centerY=screenH*0.7;
    shareButton.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);

    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];

    [imageView addSubview:shareButton];
    
    
    UIButton *skipButton=[[UIButton alloc]init];
    
    [skipButton setTitle:@"进入微博" forState:UIControlStateNormal];
    [skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [skipButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [skipButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    skipButton.size=skipButton.currentBackgroundImage.size;
    skipButton.centerX=screenW*0.5;
    skipButton.centerY=screenH*0.8;

    [skipButton addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:skipButton];
    
    imageView.userInteractionEnabled=YES;
    
}

#pragma mark - skip
-(void)skip:(UIButton *)button
{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[MainViewController alloc]init];
    
}

#pragma mark -share
-(void)share:(UIButton *)button
{
    button.selected=!button.isSelected;
    
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffSetX=scrollView.contentOffset.x;
    self.pageControl.currentPage=(int)((double)contentOffSetX/screenW+0.5);

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
