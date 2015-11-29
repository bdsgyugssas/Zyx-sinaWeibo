//
//  StatusTool.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/16.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "StatusTool.h"
#import "FMDatabase.h"
#import <sqlite3.h>

@implementation StatusTool
static FMDatabase *_db;

+(void)initialize
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *DBpath=[path stringByAppendingPathComponent:@"status.db"];
    _db=[FMDatabase databaseWithPath:DBpath];
    [_db open];
    
    NSString *sql=@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY ,status blob NOT NULL,idstr test NOT NULL)";
    [_db executeUpdate:sql];
}

+(NSArray *)statusWithParameter:(NSDictionary *)parameter
{
    NSString *sql=nil;
    if (parameter[@"since_id"]) {
       sql=[NSString stringWithFormat:@"SELECT status FROM t_status WHERE idstr>%@  ORDER BY idstr DESC LIMIT 20",parameter[@"since_id"]];
    }else if (parameter[@"max_id"]){
       sql=[NSString stringWithFormat:@"SELECT status FROM t_status WHERE idstr<%@  ORDER BY idstr DESC LIMIT 20",parameter[@"max_id"]];
    }else{
       sql=@"SELECT status FROM t_status ORDER BY idstr DESC LIMIT 20";
    }
    
     FMResultSet *set=[_db executeQuery:sql];
    NSMutableArray *array=[NSMutableArray array];
    while (set.next) {
        NSData *data=[set objectForColumnName:@"status"];
        NSDictionary *dict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:dict];
    }
    
    return array;
    
}

+(void)saveStatus:(NSArray *)statuses;
{
    
    for (NSDictionary *dict in statuses) {
        
        NSData *date=[NSKeyedArchiver archivedDataWithRootObject:dict];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status (status,idstr) VALUES (%@,%@)",date,dict[@"idstr"]];
        NSLog(@"saveStatus");
    }

}
@end
