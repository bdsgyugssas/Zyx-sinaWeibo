//
//  YXTabBar.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/11.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "YXTabBar.h"

@implementation YXTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        UIButton *plusButton=[[UIButton alloc]init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];

        [plusButton addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusButton];

    }
    return self;
}


-(void)plusBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tabBardidClickPlusButton:)]) {
        [self.delegate tabBardidClickPlusButton:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    Class UITabBarButton=NSClassFromString(@"UITabBarButton");
   
    int count=self.subviews.count-2;
    CGFloat btnWidth=self.width/count;
    int index=0;
    
    for (UIView *button in self.subviews) {
        if ([button isKindOfClass:UITabBarButton]) {
            button.width=btnWidth;
            button.x=index*btnWidth;
            index ++;
            if (index==2) {
                index++;
            }
            
        }else if ([button isKindOfClass:[UIButton class]]){

                button.centerX=self.width/2;
                button.centerY=self.height/2;
                button.size=CGSizeMake(btnWidth, self.height);
        }

    }
    
    

}
@end
