//
//  ItemCardView.m
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/23.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import "ItemCardView.h"
#import "RJItem.h"
#import "RJMacro.h"
@interface ItemCardView()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@end
@implementation ItemCardView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // Corner Radius
    self.layer.cornerRadius = 10.0;
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 20)];
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 40, self.frame.size.width - 24, 17)];
    [self addSubview:_titleLabel];
    [self addSubview:_contentLabel];
    _titleLabel.font = RJFont(18);
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = RJFont(16);
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _contentLabel.numberOfLines = 15;
    
}
-(void) RefreshContentWithItem:(RJItem *)item{
    if(item == nil){
        _titleLabel.text = @"尚无记录";
        _contentLabel.text = @"还没有记录哦，请点击下方+添加新的记录~";
    }else{
        _titleLabel.text = item.title;
        _contentLabel.text = item.content;
    }
    [_contentLabel sizeToFit];
}
@end
