//
//  Member.m
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/13.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "Member.h"

#import "AppDelegate.h"

@implementation Member

// Insert code here to add functionality to your managed object subclass

+(void)addNewMemberToFamily:(Family *)family WithName:(NSString *)name age:(NSString *)age phone:(NSString *)phone success:(void (^)())success failure:(void(^)(NSError *error))failure{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    Member *member = [NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:context];
    member.name = name;
    member.age = age;
    member.phone = phone;
    member.family = family;
    
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
+(void)deleteMember:(Member *)member FromFamily:(id)family success:(void (^)())success failure:(void(^)(NSError *error))failure{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    [context deleteObject:member];
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
+(void)updateMember:(Member *)member WithName:(NSString *)name age:(NSString *)age phone:(NSString *)phone success:(void (^)())success failure:(void (^)(NSError * _Nonnull))failure{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    member.name = name;
    member.age = age;
    member.phone = phone;
    
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
+(NSArray *)fetchMemberListsWithFamily:(NSString *)familyName{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    // 初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Family" inManagedObjectContext:context];
//     设置排序（按照age降序）
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
//    request.sortDescriptors = [NSArray arrayWithObject:sort];
//     设置条件过滤(搜索name中包含字符串"M"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*M*)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"family.name like %@",familyName];
    request.predicate = predicate;
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
