//
//  SendController.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/16.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "SendController.h"
#import "Account.h"
#import "AccountTool.h"
#import "PlaceholdTextView.h"
#import "AFNetworking.h"
#import "Account.h"
#import "AccountTool.h"
#import "MBProgressHUD.h"
#import "SendToolBar.h"
#import "SendPhotoView.h"
#import "EmotionKeyBoard.h"
#import "Emotion.h"
#import "EmetionAttachment.h"

@interface SendController ()<UITextViewDelegate,SendToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) PlaceholdTextView *placeholdTextView;

@property (weak, nonatomic) SendToolBar *sendToolBar;

@property (weak, nonatomic) SendPhotoView *photoView;
/**
 *  表情键盘
 */
@property (strong, nonatomic) EmotionKeyBoard *emoKeyBoard;

@property (assign, nonatomic) BOOL switchEmotionKeyBoard;

@end
@implementation SendController
#pragma mark -懒加载
-(EmotionKeyBoard *)emoKeyBoard
{
    if (_emoKeyBoard==nil) {
        _emoKeyBoard=[[EmotionKeyBoard alloc]init];
        _emoKeyBoard.width=self.view.width;
        _emoKeyBoard.height=253;
    }
    return _emoKeyBoard;
}
#pragma mark -生命周期
-(void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor redColor];
    //设置导航栏
    [self setupNav];
    //设置textView
    [self setupTextFile];
    
    [self setupSendToolBar];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.placeholdTextView becomeFirstResponder];
}
-(void)dealloc
{
    [NotificationCenter removeObserver:self];
}
#pragma mark -初始化方法
/**
 *  设置键盘上面的工具栏
 */
-(void)setupSendToolBar
{
    SendToolBar *toolbar=[[SendToolBar alloc]init];
    CGFloat toolbarH=35;
    CGFloat toolBarW=self.view.width;
    CGFloat toolBarY=self.view.height-toolbarH;
    toolbar.width=toolBarW;
    toolbar.height=toolbarH;
    toolbar.y=toolBarY;
    
    toolbar.delegate=self;
    [self.view addSubview:toolbar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.sendToolBar=toolbar;
}
/**
 *  设置textView
 */
-(void)setupTextFile
{

    PlaceholdTextView *textfile=[[PlaceholdTextView alloc]init];
    textfile.frame=self.view.bounds;
    textfile.placeholdColor=[UIColor grayColor];
    textfile.placeholdText=@"请输入微博内容";
    textfile.Font=[UIFont systemFontOfSize:32];
    textfile.delegate=self;
    textfile.alwaysBounceVertical=YES;
    [self.view addSubview:textfile];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:textfile];
    self.placeholdTextView=textfile;
    
    SendPhotoView *photoView=[[SendPhotoView alloc]init];
    photoView.y=100;
    photoView.size=self.view.size;
    photoView.backgroundColor=[UIColor redColor];
    [self.placeholdTextView addSubview:photoView];
    self.photoView=photoView;
    

    [NotificationCenter addObserver:self selector:@selector(emotionSelect:) name:@"EmotionDidSelect" object:nil];
}
/**
 *  设置导航栏
 */
-(void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendMesage)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    Account *account=[AccountTool account];
    UILabel *label=[[UILabel alloc]init];
    label.numberOfLines=0;
    label.width=100;
    label.height=44;
    label.textAlignment=NSTextAlignmentCenter
    ;
    NSString *str=[NSString stringWithFormat:@"发微博\n%@",account.name];
    
    NSRange range=[str rangeOfString:account.name];
    NSMutableAttributedString *attristr=[[NSMutableAttributedString alloc]initWithString:str];
    [attristr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:range];
    label.attributedText=attristr;
    
    self.navigationItem.titleView=label;

}

#pragma mark -监听方法
/**
 *  监听到表情被点击
 */
-(void)emotionSelect:(NSNotification *)notification
{
    Emotion *emotion=notification.userInfo[@"selectEmotion"];
    if (emotion!=nil) {
        if (emotion.code) {
            NSString *str=[emotion.code emoji];
            [self.placeholdTextView insertText:str];
        }else{

            UIImage*image=[UIImage imageNamed:emotion.png];
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]init];
            [str appendAttributedString:self.placeholdTextView.attributedText];

            EmetionAttachment *attachment=[[EmetionAttachment alloc]init];
            attachment.image=image;
            attachment.emotion=emotion;
            
            CGFloat H=self.placeholdTextView.font.lineHeight;
            attachment.bounds=CGRectMake(0, -4, H, H);
            
            NSUInteger index=self.placeholdTextView.selectedRange.location;
            NSAttributedString *att=[NSAttributedString attributedStringWithAttachment:attachment];
            [str insertAttributedString:att atIndex:index];
            [str addAttribute:NSFontAttributeName value:self.placeholdTextView.font range:NSMakeRange(0, str.length)];
            self.placeholdTextView.attributedText=str;
            self.placeholdTextView.selectedRange=NSMakeRange(index+1, 0);
            [self.placeholdTextView setNeedsDisplay];
        }
    }else{
        [self.placeholdTextView deleteBackward];
        
    }

    
}
/**
 *  键盘尺寸发生修改
 */
-(void)keyboardFrameChange:(NSNotification *)notification
{
    if (self.switchEmotionKeyBoard) return;
    
    NSDictionary *userInfo=notification.userInfo;
    CGRect afterChangeKeyBoardF=[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duartion=[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duartion animations:^{
        self.sendToolBar.y=afterChangeKeyBoardF.origin.y-self.sendToolBar.height;
    }];
    

    

}
/**
 *  textView 内容改变
 */
-(void)textChange
{
    self.navigationItem.rightBarButtonItem.enabled=self.placeholdTextView.hasText;
}
/**
 *  发送信息
 */
-(void)sendMesage
{
    if (self.photoView.photos.count) {
        [self uploadPhotoAndText]; //有图片
    }else{
        [self uploadText]; //无图
    
    }

}
/**
 *  取消操作
 */
-(void)cancel
{
    [self.placeholdTextView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
}

#pragma mark -UITextViewDelegate
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.view endEditing:YES];
}

#pragma mark -sendToolBarDelegate
-(void)buttonClickOfSendToolBar:(SendToolBar *)sendToolBar withButtonType:(sendToolBarButtonItemType)type
{
    switch (type) {
        case sendToolBarButtonItemCamera:
            [self openCamera];
            break;
        
        case sendToolBarButtonItemPicture:
            [self openPicture];
            break;
            
        case sendToolBarButtonItemMention:
            
            break;
            
        case sendToolBarButtonItemKeyboard:
            
            break;
            
        case sendToolBarButtonItemEmoticon:
            [self openEmotionKeyBoard];
            break;
          
            
        default: return;
            
    }

}

#pragma mark -UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    [self.photoView addPhoto:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma 私有方
/**
 *  打开自定义表情栏
 */
-(void)openEmotionKeyBoard
{
    if (self.placeholdTextView.inputView==nil) {
        self.placeholdTextView.inputView=self.emoKeyBoard;
        self.sendToolBar.showEmotionButton=NO;
    }else{
        self.placeholdTextView.inputView=nil;
        self.sendToolBar.showEmotionButton=YES;

    }

    
    self.switchEmotionKeyBoard=YES;
   
    [self.view endEditing:YES];
    [self.placeholdTextView becomeFirstResponder];
    
    self.switchEmotionKeyBoard=NO;

    
}
/**
 *  打开照相机
 */
-(void)openCamera
{

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *pick=[[UIImagePickerController alloc]init];
    pick.sourceType=UIImagePickerControllerSourceTypeCamera;
    pick.delegate=self;
    [self presentViewController:pick animated:YES completion:nil];
}
/**
 *  打开系统相册
 */
-(void)openPicture
{
    UIImagePickerController *pick=[[UIImagePickerController alloc]init];
    pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    pick.delegate=self;

    [self presentViewController:pick animated:YES completion:nil];
}
/**
 *  上传照片和文字
 */
-(void)uploadPhotoAndText
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    Account *account=[AccountTool account];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"access_token"]=account.access_token;
    parameter[@"status"]=self.placeholdTextView.text;
    
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data=UIImageJPEGRepresentation([self.photoView.photos lastObject], 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"123.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.labelText=@"已完成";
        hud.mode=MBProgressHUDModeCustomView;
        hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
        [hud hide:YES afterDelay:1.0];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    [self dismissViewControllerAnimated:YES completion:nil];


}
/**
 *  仅上传文字
 */
-(void)uploadText
{
    //    //https://api.weibo.com/2/statuses/update.json
    //    //POST
        Account *account=[AccountTool account];
    
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        dict[@"access_token"]=account.access_token;
        dict[@"status"]=[self achieveTextViewTest];
    
        [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText=@"已完成";
            hud.mode=MBProgressHUDModeCustomView;
            hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
            [hud hide:YES afterDelay:1.0];
    
    
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            YXLog(@"%@",error);
        }];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];

}

-(NSString *)achieveTextViewTest
{
 
    NSAttributedString *attstr=self.placeholdTextView.attributedText;
    NSMutableString *string=[NSMutableString string];
    [attstr enumerateAttributesInRange:NSMakeRange(0, self.placeholdTextView.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        if (attrs[@"NSAttachment"]) {
            EmetionAttachment *attach=attrs[@"NSAttachment"];
            [string appendString:attach.emotion.chs];
        }else{
            [string appendString:[attstr attributedSubstringFromRange:range].string];
        
        }
        
    }];
    
    return string;
}
@end
