//
//  RJCheckItemViewController.m
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/21.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import "RJCheckItemViewController.h"
#import "RJMacro.h"
#import "ZLSwipeableView.h"
@interface RJCheckItemViewController()<ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>{
    UILabel *_titleLabel;
    
}
@property (nonatomic, strong) ZLSwipeableView *swipeableView;

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;
@end
@implementation RJCheckItemViewController
#pragma makr - Life cycle
-(void) viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor purpleColor]];
    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
    self.swipeableView = swipeableView;
    [self.view addSubview:self.swipeableView];
    
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
    
    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *metrics = @{};
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-50-[swipeableView]-50-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-120-[swipeableView]-100-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];

    self.swipeableView.numberOfHistoryItem = NSUIntegerMax;
    self.swipeableView.allowedDirection = ZLSwipeableViewDirectionAll;
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    _titleLabel.font = RJFont(18);
    _titleLabel.textColor = RGBACOLOR(0, 0, 0, 0.64);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"随便看看";
    self.swipeableView.numberOfHistoryItem = NSUIntegerMax;
    self.swipeableView.allowedDirection = ZLSwipeableViewDirectionAll;
    

}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *leftNavBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
    self.tabBarController.navigationItem.leftBarButtonItem = leftNavBarButtonItem;
    UIBarButtonItem *rightNavBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
    self.tabBarController.navigationItem.rightBarButtonItem = rightNavBarButtonItem;
    self.tabBarController.navigationItem.titleView = _titleLabel;
}
- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}
#pragma mark - ACtion
-(void) leftBtnAction{
    
}
-(void) rightBarButtonItemAction{
    [self.swipeableView rewind];
}
- (UIView *)previousViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    UIView *view = [self nextViewForSwipeableView:swipeableView];
    [self applyRandomTransform:view];
    return view;
}
- (void)applyRandomTransform:(UIView *)view {
    CGFloat width = self.swipeableView.bounds.size.width;
    CGFloat height = self.swipeableView.bounds.size.height;
    CGFloat distance = MAX(width, height);
    
    CGAffineTransform transform = CGAffineTransformMakeRotation([self randomRadian]);
    transform = CGAffineTransformTranslate(transform, distance, 0);
    transform = CGAffineTransformRotate(transform, [self randomRadian]);
    view.transform = transform;
}

- (CGFloat)randomRadian {
    return (random() % 360) * (M_PI / 180.0);
}
#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y,
          translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {

    
    UIView *view = [[UIView alloc] initWithFrame:swipeableView.bounds];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
@end
