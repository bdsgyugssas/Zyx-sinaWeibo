//
//  MenuView.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/11.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "MenuView.h"
@interface MenuView()
@property (strong, nonatomic) UIImageView *menuView;
@property (strong, nonatomic) UIWindow *window;

@end

@implementation MenuView

-(UIImageView *)menuView
{
    if (_menuView==nil) {
        
        _menuView=[[UIImageView alloc]init];
        _menuView.image=[UIImage imageNamed:@"popover_background"];
        _menuView.userInteractionEnabled=YES;
        [self addSubview:_menuView];

    }
    return _menuView;

}


+(instancetype)menu
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}

-(void)setContentController:(UIViewController *)ContentController
{
    
    _ContentController=ContentController;
    
    CGFloat insetx=10;
    CGFloat insety=15;


    self.menuView.height=ContentController.view.height+25;
    self.menuView.width=CGRectGetMaxX(ContentController.view.frame)+2*insetx;
    
    ContentController.view.x=insetx;
    ContentController.view.y=insety;
    
    
    [self.menuView addSubview:ContentController.view];
    
        
}

-(void)showfrom:(UIButton *)from
{
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];

 
    
    self.frame=window.bounds;
    
    CGRect newRect=[from.superview convertRect:from.frame toView:nil];
    
    self.menuView.y=CGRectGetMaxY(newRect);
    self.menuView.centerX=CGRectGetMidX(newRect);
    
    [window addSubview:self];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self dismiss];
}

-(void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(menuViewDidMiss:)]) {
        [self.delegate menuViewDidMiss:self];
    }
}
@end
