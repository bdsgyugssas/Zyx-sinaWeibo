//
//  WBStatusCell.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/14.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "WBStatusCell.h"
#import "Status.h"
#import "StatusFrame.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "Photo.h"
#import "ToolBal.h"
#import "NSString+Extension.h"
#import "WBPhotos.h"

@interface WBStatusCell ()

/**    原创微博     */
@property (weak, nonatomic) UIView *originalView;
/**    微博头像     */
@property (weak, nonatomic) UIImageView *iconView;
/**    微博图片     */
@property (weak, nonatomic) WBPhotos *photos;
/**    微博VIP图片     */
@property (weak, nonatomic) UIImageView *VIPView;
/**    微博作者     */
@property (weak, nonatomic) UILabel *name;
/**    微博发布时间     */
@property (weak, nonatomic) UILabel *create_time;
/**    微博内容     */
@property (weak, nonatomic) UILabel *text;
/**    微博来源     */
@property (weak, nonatomic) UILabel *source;
//转发微博
/**    转发微博     */
@property (weak, nonatomic) UIView *retweetView;
/**    转发微博内容+昵称     */
@property (weak, nonatomic) UILabel *retweetText;
/**    转发微博图片     */
@property (weak, nonatomic) WBPhotos *retweetPhotoView;
/**  工具条  */
/**    工具条    */
@property (weak, nonatomic)  ToolBal *toolBar;

@end

@implementation WBStatusCell

+(WBStatusCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier=@"Cell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[WBStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        /**    原创微博     */
         UIView *originalView=[[UIView alloc]init];
        [self addSubview:originalView];
        self.originalView=originalView;
        self.originalView.backgroundColor=[UIColor whiteColor];

        
        /**    微博头像     */
        UIImageView *iconView=[[UIImageView alloc]init];
        [originalView addSubview:iconView];
        self.iconView=iconView;

        /**    微博图片     */
        WBPhotos *photoView=[[WBPhotos alloc]init];
//        photoView.backgroundColor=[UIColor redColor];
        [originalView addSubview:photoView];
        self.photos=photoView;

        /**    微博VIP图片     */
        UIImageView *VIPView=[[UIImageView alloc]init];
        VIPView.contentMode=UIViewContentModeCenter;
        [originalView addSubview:VIPView];
        self.VIPView=VIPView;

        /**    微博作者     */
        UILabel *name=[[UILabel alloc]init];
        [originalView addSubview:name];
        self.name=name;

        /**    微博发布时间     */
        UILabel *create_time=[[UILabel alloc]init];
        create_time.textColor=[UIColor orangeColor];
        [originalView addSubview:create_time];
        self.create_time=create_time;

        /**    微博内容     */
        UILabel *text=[[UILabel alloc]init];
        text.numberOfLines=0;
        [originalView addSubview:text];
        self.text=text;
        
        /**    微博来源     */
        UILabel *source=[[UILabel alloc]init];
        [originalView addSubview:source];
        self.source=source;
        
        /**  转发微博  */
        UIView *retweetView=[[UIView alloc]init];
        [self addSubview:retweetView];
        self.retweetView=retweetView;
        retweetView.backgroundColor=[UIColor colorWithRed:(double)247/256 green:(double)247/256 blue:(double)247/256 alpha:1];
        
        /**    转发微博内容     */
        UILabel *retweetText=[[UILabel alloc]init];
        retweetText.numberOfLines=0;
        [retweetView addSubview:retweetText];
        self.retweetText=retweetText;
        
        /**    转发微博图片     */
        WBPhotos *retweetPhotoView=[[WBPhotos alloc]init];
//        retweetPhotoView.backgroundColor=[UIColor redColor];
        [retweetView addSubview:retweetPhotoView];
        self.retweetPhotoView=retweetPhotoView;
        
        [self setToolbarView];

    }
    
    return self;

}


-(void)setToolbarView
{
    ToolBal *toolBal=[[ToolBal alloc]init];

    [self addSubview:toolBal];
    self.toolBar=toolBal;

}


-(void)setStatusfarme:(StatusFrame *)statusfarme
{
    _statusfarme=statusfarme;
    
    User *user=statusfarme.status.user;
    Status *status=statusfarme.status;
    
    self.originalView.frame=statusfarme.originalViewFrame;
    //* 微博头像  */
    self.iconView.frame=statusfarme.iconViewFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];

    //* 微博用户昵称  */
    self.name.frame=statusfarme.nameFrame;
    self.name.text=user.name;
    self.name.font=NameFont;
    
    if (user.isVIP) {
        self.VIPView.hidden=NO;
        self.VIPView.frame=statusfarme.VIPViewFrame;
        NSString *vipRank=[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.VIPView.image=[UIImage imageNamed:vipRank];
        self.name.textColor=[UIColor orangeColor];
    }else{
        self.name.textColor=[UIColor blackColor];
        self.VIPView.hidden=YES;
    }
    
    /**   微博创建时间   */
    CGFloat create_timeX=self.name.x;
    CGFloat create_timeY=CGRectGetMaxY(self.name.frame);
    CGSize  create_nameSize=[status.created_at sizeWithfont:CreateTimeFont];
    self.create_time.frame=CGRectMake(create_timeX, create_timeY, create_nameSize.width, create_nameSize.height);
    
    /**   微博来源   */
    CGFloat sourceX=CGRectGetMaxX(self.create_time.frame)+cellBorder;
    CGFloat sourceY=create_timeY;
    CGSize  sourceSize=[status.source sizeWithfont:CreateTimeFont];
    self.source.frame=CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    //* 微博创建时间  */

    self.create_time.text=status.created_at;
    self.create_time.font=CreateTimeFont;
    
    //* 微博来源  */

    self.source.text=status.source;
    self.source.font=CreateTimeFont;
   
    //* 微博内容  */
    self.text.frame=statusfarme.textFrame;
    self.text.text=status.text;
    self.text.font=TextFont;
    
    //* 微博配图  */
    if (status.pic_urls.count) {
        self.photos.hidden=NO;
        self.photos.frame=statusfarme.photoViewFrame;
        self.photos.photos=status.pic_urls;
        //NSLog(@"%@",status.pic_urls.firstObject);
    }else{
    
        self.photos.hidden=YES;
    }
    
    /**  微博原创部分全部内容 */
    self.originalView.frame=statusfarme.originalViewFrame;
    

    
    Status *retweetStatus=status.retweeted_status;
    /**  转发微博 */
    if (retweetStatus) {
        NSString *retweetText=[NSString stringWithFormat:@"@%@ :%@",retweetStatus.user.name,retweetStatus.text];

        self.retweetView.hidden=NO;
        self.retweetText.frame=statusfarme.retweetTextFrame;
        self.retweetText.text=retweetText;
        self.retweetText.font=retweetTextFont;
        
        NSString *urlstr=((Photo *)[retweetStatus.pic_urls firstObject]).thumbnail_pic;
        if (urlstr!=nil) {
            self.retweetPhotoView.hidden=NO;
            self.retweetPhotoView.frame=statusfarme.retweetPhotoViewFrame;
            self.retweetPhotoView.photos=retweetStatus.pic_urls;
        }else{
            self.retweetPhotoView.hidden=YES;
        }
        
        self.retweetView.frame=statusfarme.retweetViewFrame;
    }else{
        
        self.retweetView.hidden=YES;
    }
    
    
    /**  工具条 */
    
    self.toolBar.frame=statusfarme.toolBarFrame;
    self.toolBar.status=status;

}



















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
