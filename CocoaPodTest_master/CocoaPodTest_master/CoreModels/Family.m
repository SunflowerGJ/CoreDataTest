//
//  Family.m
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/13.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "Family.h"
#import "Member.h"

#import "AppDelegate.h"

@implementation Family


// Insert code here to add functionality to your managed object subclass

+(void)addNewFamilyWithName:(NSString *)name address:(NSString *)address success:(void (^)())success failure:(void(^)(NSError *error))failure{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSManagedObject *family = [NSEntityDescription insertNewObjectForEntityForName:@"Family" inManagedObjectContext:context];
    [family setValue:name forKey:@"name"];
    [family setValue:address forKey:@"address"];
    
    NSError *error = nil;
    BOOL isSuccess = [context save:&error];
    if (!isSuccess) {
        if (failure) {
            failure(error);
        }
    }else{
        if (success) {
            success();
        }
    }
}
+(void)deleteFamily:(Family *)family success:(void (^)())success failure:(void(^)(NSError *error))failure{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    [context deleteObject:family];
    
    NSError *error = nil;
    BOOL isSuccess = [context save:&error];
    if (!isSuccess) {
        if (failure) {
            failure(error);
        }
    }else{
        if (success) {
            success();
        }
    }
}
+(NSArray *)fetchFamilyLists{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    // 初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Family" inManagedObjectContext:context];
    // 设置排序（按照age降序）
    //    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    //    request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤(搜索name中包含字符串"M"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*M*)
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", @"*M*"];
    //    request.predicate = predicate;
    // 执行请求
    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    // 遍历数据
    for (NSManagedObject *obj in objs) {
        NSLog(@"name=%@", [obj valueForKey:@"name"]);
    }
    
    return objs;
}
@end
