//
//  RJItem.m
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/21.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import "RJItem.h"

@implementation RJItem
@synthesize content;
@synthesize title;
@synthesize timeStamp;
@synthesize itemId;
-(instancetype) initWithTitle:(NSString *)aTitle content:(NSString *)aContent timeStamp:(long)aTimeStamp  itemId:(NSInteger)aItemId{
    self = [super init];
    if (self) {
        title = aTitle;
        content = aContent;
        timeStamp = aTimeStamp;
        itemId = aItemId;
    }
    return self;
}
@end
