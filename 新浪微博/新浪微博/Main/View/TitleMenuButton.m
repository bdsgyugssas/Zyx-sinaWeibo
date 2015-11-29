//
//  TitleMenuButton.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/13.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "TitleMenuButton.h"

@implementation TitleMenuButton


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
    
        
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
  
    
    }
    return self;
}



-(void)layoutSubviews
{

    [super layoutSubviews];
    for ( int i=0; i<0; i++) {
        self.titleLabel.x=self.imageView.x;
        self.imageView.x=CGRectGetMaxX(self.titleLabel.frame);
    }
    
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];

}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{

    [super setTitle:title forState:state];
    
    [self sizeToFit];
}
@end
