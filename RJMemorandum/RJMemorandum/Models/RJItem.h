//
//  RJItem.h
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/21.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJItem : NSObject
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* content;
@property (nonatomic) long timeStamp;
@property (nonatomic) NSInteger itemId;
-(instancetype) initWithTitle:(NSString*) aTitle content:(NSString*)aContent timeStamp:(long) aTimeStamp itemId:(NSInteger) aItemId;
@end
