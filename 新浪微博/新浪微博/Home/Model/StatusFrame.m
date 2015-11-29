//
//  StatusFrame.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/14.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "Photo.h"
#import "NSString+Extension.h"
#import "WBPhotos.h"

#define  cellBorder  10
#define CellW [UIScreen mainScreen].bounds.size.width


@interface StatusFrame()

@end

@implementation StatusFrame



-(void)setStatus:(Status *)status
{
    _status=status;
    
    [self setOriginalView:status];
    
    if (status.retweeted_status) {
       [self setRetweeeView:status];
        [self setToolBarViewFrame];
    }else{
       [self setToolBarViewFrame];
    }

    
    
}


/**
 *  获得工具条尺寸
 */
-(void)setToolBarViewFrame
{
    
    CGFloat toolBarX=0;
    
    CGFloat toolBarY=0;
    if (self.status.retweeted_status) {
      toolBarY=CGRectGetMaxY(self.retweetViewFrame);
    }else{
      toolBarY=CGRectGetMaxY(self.originalViewFrame)+1;
    }
    CGFloat toolBarW=CellW;
    CGFloat toolBarH=35;
    self.toolBarFrame=CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    self.cellHeight=CGRectGetMaxY(self.toolBarFrame);
    
}
/**
 *  获得转发微博尺寸
 */
-(void)setRetweeeView:(Status *)status
{
    Status *retweeted_status=status.retweeted_status;

        /**   转发微博内容   */
        NSString *retweetText=[NSString stringWithFormat:@"@%@ :%@",retweeted_status.user.name,retweeted_status.text];
        CGFloat retweetTextFrameX=cellBorder;
        CGFloat retweetTextFrameY=cellBorder;
        CGSize  retweetTextSize=[retweetText sizeWithfont:retweetTextFont MaxW:[UIScreen mainScreen].bounds.size.width-2*cellBorder];
        self.retweetTextFrame=CGRectMake(retweetTextFrameX, retweetTextFrameY, retweetTextSize.width, retweetTextSize.height);
        
        CGFloat retweetViewFrameH=0;
    
        if (((Photo *)[retweeted_status.pic_urls firstObject]).thumbnail_pic!=nil) {
            /**   转发微博配图   */
            CGFloat retweetPhotoViewFrameX=cellBorder;
            CGFloat retweetPhotoViewFrameY=CGRectGetMaxY(self.retweetTextFrame)+cellBorder;
            CGSize retweetPhotoViewSize=[WBPhotos sizeWithCount:retweeted_status.pic_urls.count];
            self.retweetPhotoViewFrame=CGRectMake(retweetPhotoViewFrameX,retweetPhotoViewFrameY, retweetPhotoViewSize.width, retweetPhotoViewSize.height);
            retweetViewFrameH=CGRectGetMaxY(self.retweetPhotoViewFrame)+cellBorder;
        }else{
            retweetViewFrameH=CGRectGetMaxY(self.retweetTextFrame)+cellBorder;
        }
        
        CGFloat cellW=[UIScreen mainScreen].bounds.size.width;
        CGFloat retweetViewFrameX=0;
        CGFloat retweetViewFrameY=CGRectGetMaxY(self.originalViewFrame);
        CGFloat retweetViewFrameW=cellW;
        self.retweetViewFrame=CGRectMake(retweetViewFrameX, retweetViewFrameY, retweetViewFrameW, retweetViewFrameH);
    
    
        self.cellHeight=CGRectGetMaxY(self.retweetViewFrame);
}
/**
 *  获得原创微博尺寸
 */
-(void)setOriginalView:(Status *)status
{
    User *user=status.user;
    

    
    /**   微博头像   */
    CGFloat iconX=cellBorder;
    CGFloat iconY=cellBorder;
    CGFloat iconW=35;
    CGFloat iconH=35;
    self.iconViewFrame=CGRectMake(iconX, iconY, iconW, iconH);
    
    /**   微博昵称   */
    CGFloat nameX=CGRectGetMaxX(self.iconViewFrame)+cellBorder;
    CGFloat nameY=cellBorder;
    CGSize nameSize=[user.name sizeWithfont:NameFont];
    self.nameFrame=CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    /**   微博VIP   */
    if (user.isVIP) {
        CGFloat VIPViewX=CGRectGetMaxX(self.nameFrame);
        CGFloat VIPViewY=cellBorder;
        CGFloat VIPViewW=30;
        CGFloat VIPViewH=nameSize.height;
        self.VIPViewFrame=CGRectMake(VIPViewX, VIPViewY, VIPViewW, VIPViewH);
    }
    
    /**   微博创建时间   */
    CGFloat create_timeX=nameX;
    CGFloat create_timeY=CGRectGetMaxY(self.nameFrame);
    CGSize  create_nameSize=[status.created_at sizeWithfont:CreateTimeFont];
    self.create_timeFrame=CGRectMake(create_timeX, create_timeY, create_nameSize.width, create_nameSize.height);
    
    /**   微博来源   */
    CGFloat sourceX=CGRectGetMaxX(self.create_timeFrame)+cellBorder;
    CGFloat sourceY=create_timeY;
    CGSize  sourceSize=[status.source sizeWithfont:CreateTimeFont];
    self.sourceFrame=CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    /**   微博内容   */
    CGFloat MaxW=CellW-2*cellBorder;
    CGFloat textX=iconX;
    CGFloat textY=MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.create_timeFrame))+cellBorder;
    CGSize  textSize=[status.text sizeWithfont:TextFont MaxW:MaxW];
    self.textFrame=(CGRect){{textX,textY},textSize};
    
    /**   微博配图   */
    CGFloat originalViewH=0;
    if (status.pic_urls.count) {
        CGFloat photoViewX=cellBorder;
        CGFloat photoViewY=CGRectGetMaxY(self.textFrame)+cellBorder;
        CGSize  photoViewSize=[WBPhotos sizeWithCount:status.pic_urls.count];
        self.photoViewFrame=CGRectMake(photoViewX, photoViewY, photoViewSize.width, photoViewSize.height);
        originalViewH=CGRectGetMaxY(self.photoViewFrame)+cellBorder;
    }else{
        originalViewH=CGRectGetMaxY(self.textFrame)+cellBorder;
        
        
    }
    /**  原创微博全部内容  */
    CGFloat originalViewX=0;
    CGFloat originalViewY=cellBorder;
    CGFloat originalViewW=[UIScreen mainScreen].bounds.size.width;
   
    self.originalViewFrame=CGRectMake(originalViewX, originalViewY, originalViewW,originalViewH);
    


}

@end
