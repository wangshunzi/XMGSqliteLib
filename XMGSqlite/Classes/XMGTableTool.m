//
//  XMGTableTool.m
//  sqlite的基本封装
//
//  Created by 王顺子 on 16/12/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTableTool.h"
#import "XMGSqliteTool.h"

@implementation XMGTableTool


/**
 判断表格是否已经存在(注意容错大小写)
 */
+ (BOOL)isTableExists: (NSString *)tableName uid: (NSString *)uid {

    NSString *sql = @"select name from sqlite_master";
    NSArray <NSDictionary *>*resultSet = [XMGSqliteTool querySql:sql withUID:uid];
    __block BOOL isTableExists = NO;
    [resultSet enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj[@"name"] lowercaseString] isEqualToString:[tableName lowercaseString]]) {
            isTableExists = YES;
        }
    }];
    return isTableExists;

}
/**
 获取表格里面所有的字段
 */
+ (NSArray *)getTableAllColumnNames: (NSString *)tableName uid: (NSString *)uid {

    NSString *sql = [NSString stringWithFormat:@"select * from sqlite_master where type = 'table' and name = '%@'", tableName];

    NSArray *resultSet = [XMGSqliteTool querySql:sql withUID:uid];

    NSString *createSql = resultSet.firstObject[@"sql"];

    //    CREATE TABLE XMGStu(age integer,num integer,score real,name text,xxx text, primary key(num))

    NSArray *sqlArray = [createSql componentsSeparatedByString:@"("];

    if (sqlArray.count >= 2) {
        // age integer,num integer,score real,name text,xxx text, primary key
        NSString *columnStr = sqlArray[1];

        NSArray *columnNameTypeArray = [columnStr componentsSeparatedByString:@","];

        NSMutableArray *columnNames = [NSMutableArray array];
        for (NSString *columnNameType in columnNameTypeArray) {
            if ([columnNameType containsString:@"primary"]) {
                continue;
            }
            //            age integer
            // 去除首尾空格, 并按空格进行划分
            NSString *columnName = [[columnNameType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsSeparatedByString:@" "].firstObject;
            [columnNames addObject:columnName];

        }

        return columnNames;

    }

    return nil;

}






@end
