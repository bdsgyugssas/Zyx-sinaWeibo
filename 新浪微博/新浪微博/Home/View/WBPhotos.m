//
//  WBPhotos.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/15.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "WBPhotos.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"

#define photoMargin 10
#define photoWH  75
#define maxCloumn ((count==4)?2:3)

@implementation WBPhotos


+(CGSize)sizeWithCount:(int)count
{
    
    int columns=maxCloumn;
    
    if (count<maxCloumn) {
        columns=count;
    }
    
    int rows=count/maxCloumn;
    
    if (count % maxCloumn) {
        rows=count/maxCloumn+1;
    }
    
    CGFloat width=columns*(photoWH+photoMargin);
    CGFloat height=rows*(photoWH+photoMargin);
    
    return CGSizeMake(width, height);
}

-(void)setPhotos:(NSArray *)photos
{
    _photos=photos;
    
    while (self.subviews.count<photos.count) {
        UIImageView *imageView=[[UIImageView alloc]init];
        [self addSubview:imageView];
    }
    
    int count=self.subviews.count;
    for (int i=0; i<count; i++) {
        UIImageView *imageView=self.subviews[i];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds=YES;
        if (i<photos.count) {
            Photo *photo=photos[i];
            imageView.hidden=NO;
            NSLog(@"%@",photo.thumbnail_pic);
            [imageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }else{
            imageView.hidden=YES;
        }

    }

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count=self.photos.count;
    
    for (int i=0; i<count; i++) {
        
        UIImageView *imageView=self.subviews[i];
        CGFloat  rectX=(i%maxCloumn)*(photoMargin+photoWH);
        CGFloat  rectY=(i/maxCloumn)*(photoWH+photoMargin);
        imageView.frame=CGRectMake(rectX,rectY, photoWH ,photoWH);
 
        NSLog(@"%@",NSStringFromCGRect(imageView.frame));
        
    }

}

@end
