//
//  RJItemListViewController.m
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/23.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import "RJItemListViewController.h"
#import "RJMacro.h"
@implementation RJItemListViewController
#pragma makr - Life cycle 
-(void) viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:RGBCOLOR(224, 224, 224)];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"全部记录";
}
@end
