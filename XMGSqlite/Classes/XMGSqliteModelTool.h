//
//  XMGSqliteModelTool.h
//  sqlite的基本封装
//
//  Created by 小码哥 on 2016/12/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    XMGSqliteModelToolRelationTypeEqual,
    XMGSqliteModelToolRelationTypeGreater,
    XMGSqliteModelToolRelationTypeLess,
    XMGSqliteModelToolRelationTypeEG,
    XMGSqliteModelToolRelationTypeEL,
    XMGSqliteModelToolRelationTypeNE,
} XMGSqliteModelToolRelationType;


typedef enum : NSUInteger {
    XMGSqliteModelToolNAONot,
    XMGSqliteModelToolNAOAnd,
    XMGSqliteModelToolNAOOr,
} XMGSqliteModelToolNAO;




@interface XMGSqliteModelTool : NSObject

// runtime 获取更多的信息, 让用户, 尽可能少的, 给我们提供信息
+ (BOOL)createTableWithModelClass: (Class)cls withUID: (NSString *)uid;


// 保存/ 已经存在, 更新
+ (BOOL)saveModel: (id)model uid: (NSString *)uid;

+ (NSArray *)queryAllModels:(Class)cls uid: (NSString *)uid;
+ (NSArray *)queryModels:(Class)cls key: (NSString *)key relation: (XMGSqliteModelToolRelationType)relation value: (id)value uid: (NSString *)uid;
+ (NSArray *)queryModels:(Class)cls keys: (NSArray *)keys relations: (NSArray *)relations values: (NSArray *)values nao: (NSArray *)naos uid: (NSString *)uid;
+ (NSArray *)queryModels:(Class)cls sql: (NSString *)sql uid: (NSString *)uid;


+ (BOOL)deleteModel: (id)model uid: (NSString *)uid;




@end
