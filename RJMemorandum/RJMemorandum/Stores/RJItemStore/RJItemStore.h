//
//  RJItemStore.h
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/21.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RJItem;
@interface RJItemStore : NSObject
+(RJItemStore*) shareStore;
-(NSArray*) allItems;
-(RJItem*) getRandomItem;
-(void) creatNewRJItemWith:(NSString*) title content:(NSString*) content;
@end
