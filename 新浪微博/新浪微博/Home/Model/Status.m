//
//  Status.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/13.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "Status.h"
#import "MJExtension.h"
#import "Photo.h"
@implementation Status

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls":[Photo class]};
}

-(NSString *)created_at
{

    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdate=[formatter dateFromString:_created_at];
    NSDate *dateNow=[NSDate date];
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *cmp=[calendar components:unit fromDate:createdate toDate:dateNow options:0];
    
    NSDateComponents *cmpCreate=[calendar components:unit fromDate:createdate];
    NSDateComponents *cmpNow=[calendar components:unit fromDate:dateNow];

    
    
    if (cmpCreate.year==cmpNow.year) {//今年
        if (cmpCreate.month==cmpNow.month) {//当月
            if (cmpCreate.day==cmpNow.day) {//当天
                if (cmp.hour<3) {
                    if (cmp.hour<2) {
                        if(cmp.hour<1){
                            if (cmp.minute<1) {
                                formatter.dateFormat=[NSString stringWithFormat:@"刚刚"];
                            }else{
                                formatter.dateFormat=[NSString stringWithFormat:@"%d分钟前",cmp.minute];
                            }
                        }else{
                            formatter.dateFormat=@"1小时前";
                        }
                    }else{
                        formatter.dateFormat=@"2小时前";
                    }
                }else{
                formatter.dateFormat=@"今天 HH:mm";
                }
            }else if(cmpCreate.day+1==cmpCreate.day){//昨天
                formatter.dateFormat=@"昨天 HH:mm";
            }else{
                formatter.dateFormat=@"MM-dd HH:mm";
            }
            
        }else{//当月以前
            formatter.dateFormat=@"MM-dd HH-mm";
        }
        
    }else{//今年以前
    
        formatter.dateFormat=@"yyyy-MM-dd HH-mm";
    }
    
    
    
    NSString *createTime=[formatter stringFromDate:createdate];
    
    return createTime;
}
-(void)setSource:(NSString *)source
{

    NSRange range;
    range.location=[source rangeOfString:@">"].location+1;
    range.length=[source rangeOfString:@"</"].location-range.location;
    
    NSString *newsource=[NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
    
    _source=newsource;
}
@end
