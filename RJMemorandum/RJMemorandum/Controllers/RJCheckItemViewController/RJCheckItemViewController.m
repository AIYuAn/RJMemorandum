//
//  RJCheckItemViewController.m
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/21.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import "RJCheckItemViewController.h"
#import "RJMacro.h"
#import "RJItemStore.h"
#import "ZLSwipeableView.h"
#import "ItemCardView.h"
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
    [self.view setBackgroundColor:RGBCOLOR(224, 224, 224)];
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
                               constraintsWithVisualFormat:@"|-20-[swipeableView]-20-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-60-[swipeableView]-100-|"
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NewItemNotificationAction:) name:kNewItemNotification object:nil];

}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *leftNavBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
    self.tabBarController.navigationItem.leftBarButtonItem = leftNavBarButtonItem;
    UIBarButtonItem *rightNavBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
    self.tabBarController.navigationItem.rightBarButtonItem = rightNavBarButtonItem;
    [self updateRightBarButtonItem];
    self.tabBarController.navigationItem.titleView = _titleLabel;
}
- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}
-(void) dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNewItemNotification object:nil];
}
#pragma mark - ACtion
-(void) NewItemNotificationAction:(NSNotification*) aNotification{
    if ([[[RJItemStore shareStore]allItems]count] == 1) {
        for (int i = 0; i < 4; i++) {
            [self.swipeableView swipeTopViewToLeft];
        }
    }
}
-(void) leftBtnAction{
    
}
-(void) rightBarButtonItemAction{
    [self.swipeableView rewind];
    [self updateRightBarButtonItem];
}
- (void)updateRightBarButtonItem {
    NSInteger historyLength = self.swipeableView.history.count - 4;
    NSInteger count = [[[RJItemStore shareStore]allItems]count];
    historyLength = MIN(count, historyLength);
    BOOL enabled = historyLength > 0;
    self.tabBarController.navigationItem.rightBarButtonItem.enabled = enabled;
}


- (CGFloat)randomRadian {
    return (random() % 360) * (M_PI / 180.0);
}
#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    [self updateRightBarButtonItem];
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
//- (UIView *)previousViewForSwipeableView:(ZLSwipeableView *)swipeableView {
//    UIView *view = [self nextViewForSwipeableView:swipeableView];
//    [self applyRandomTransform:view];
//    return view;
//}
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {

    
    ItemCardView *view = [[ItemCardView alloc] initWithFrame:swipeableView.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [view RefreshContentWithItem:[[RJItemStore shareStore]getRandomItem]];
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
@end
