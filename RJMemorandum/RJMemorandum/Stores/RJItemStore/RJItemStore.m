//
//  RJItemStore.m
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/21.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import "RJItemStore.h"
#import "RJItem.h"
static RJItemStore* itemStoreInstance = nil;
@interface RJItemStore()
@property (nonatomic,strong) NSMutableArray<RJItem*>* items;
@end
@implementation RJItemStore
-(instancetype) initPrivate{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc]init];
    }
    return self;
}
-(instancetype) init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use [RJItemStore shareStore]" userInfo:nil];
    return nil;
}
+(RJItemStore*) shareStore{
    if (!itemStoreInstance) {
        itemStoreInstance = [[RJItemStore alloc]initPrivate];
    }
    return itemStoreInstance;
}
-(NSArray*) allItems{
    return _items;
}
-(RJItem*) getRandomItem{
    if (![_items count]) {
        return _items[arc4random()%[_items count]];
    }
    return nil;
}
-(void) creatNewRJItemWith:(NSString *)title content:(NSString *)content{
    long timeStamp = [[NSDate date]timeIntervalSince1970];
    NSInteger itemId = [_items count]>0 ? [_items lastObject].itemId + 1 : 0;
    RJItem* item = [[RJItem alloc]initWithTitle:title content:content timeStamp:timeStamp itemId:itemId];
    [_items addObject:item];
}
@end
