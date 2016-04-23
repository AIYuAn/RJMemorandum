//
//  CYLPlusButtonSubclass.m
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/21.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//


#import "CYLPlusButtonSubclass.h"
#import "CYLTabBarController.h"
@implementation CYLPlusButtonSubclass

+ (void)load {
  [super registerSubclass];
}
+ (instancetype)plusButton {
  UIImage *buttonImage = [UIImage imageNamed:@"btn_addpost.png"];
  UIImage *highlightImage = [UIImage imageNamed:@"btn_addpost_pressed.png"];
  CYLPlusButtonSubclass *button =  [CYLPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
  button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
  button.frame =  CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
  [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
  [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
  return button;
}
- (void)clickPublish {

}
@end
