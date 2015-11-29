//
//  SendPhotoView.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "SendPhotoView.h"

@interface SendPhotoView () <UIGestureRecognizerDelegate>

@end

@implementation SendPhotoView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _photos=[NSMutableArray array];
    }
    return self;
}

-(void)addPhoto:(UIImage *)photo
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=photo;
    imageView.userInteractionEnabled=YES;
    UILongPressGestureRecognizer *reg=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(remove:)];
    [imageView addGestureRecognizer:reg];
    [self addSubview:imageView];
    [self.photos addObject:photo];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count=self.subviews.count;
    int maxCloumn=4;
    CGFloat imageMargin=10;
    CGFloat imageW=(self.width-5*imageMargin)/4;
    CGFloat imageH=imageW;

    for (int i=0; i<count; i++) {
        UIImageView *image=self.subviews[i];
        CGFloat imageX=(i%maxCloumn)*(imageW+imageMargin)+imageMargin;
        CGFloat imageY=(i/maxCloumn)*(imageH+imageMargin)+imageMargin;;
        image.frame=CGRectMake(imageX, imageY, imageW, imageH);
    }


}

-(void)remove:(UILongPressGestureRecognizer *)reg
{
    
    if (reg.state==UIGestureRecognizerStateEnded) {
    
       UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:nil cancelButtonTitle:@"返回" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
        [sheet showInView:self.superview];

    }
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    YXLog(@"%@",NSStringFromCGPoint(point));

}

#pragma mark - UIGestureRecognizerDelegate


@end
