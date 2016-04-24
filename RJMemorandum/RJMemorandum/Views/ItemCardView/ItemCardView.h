//
//  ItemCardView.h
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/23.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJItem;
@interface ItemCardView : UIView
-(void) RefreshContentWithItem:(RJItem*) item;
@end
