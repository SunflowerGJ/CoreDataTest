//
//  Member+CoreDataProperties.h
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/13.
//  Copyright © 2016年 GJ. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Member.h"

NS_ASSUME_NONNULL_BEGIN

@interface Member (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *age;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSManagedObject *family;

@end

NS_ASSUME_NONNULL_END
