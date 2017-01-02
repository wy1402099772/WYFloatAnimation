//
//  WYFloatAnimationMnager.m
//  WYFloatAnimation
//
//  Created by wyan assert on 2017/1/2.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "WYFloatAnimationMnager.h"
#import "WYFloatAnimationImageView.h"

static NSInteger const InitPosiValue = -1;

@interface WYFloatAnimationMnager ()

@property (nonatomic, strong) UIView *associatedView;
@property (nonatomic, strong) WYFloatAnimationImageView *hungImageView;

@property (nonatomic, assign) CGFloat spinAngle;
@property (nonatomic, assign) CGFloat scaleRate;

@end

@implementation WYFloatAnimationMnager

- (instancetype)initWithAssoicatedView:(UIView *)associatedView {
    if(self = [super init]) {
        _associatedView = associatedView;
        _hungPoint = CGPointMake(InitPosiValue, InitPosiValue);
        _hungSize = CGSizeMake(InitPosiValue, InitPosiValue);
        
        _spinAngle = 0;
        _scaleRate = 1;
        
        [self configureHungImage];
    }
    return self;
}

#pragma mark - Public
- (void)stopAnimation {
    //remove from super view
    
    self.associatedView = nil;
}

#pragma mark - Private
- (void)configureHungImage {
    if(!self.associatedView) {
        return ;
    }
    [self.associatedView addSubview:self.hungImageView];
    
}

- (CGRect)calHungImageInitFrame {
    return CGRectMake(self.hungPoint.x - self.hungSize.width / 2, self.hungPoint.y - self.hungSize.height, self.hungSize.width, self.hungSize.height * 2);
}


#pragma mark - Getter
- (CGPoint)hungPoint {
    if(_hungPoint.x == InitPosiValue && _hungPoint.y == InitPosiValue) {
        return CGPointMake([UIScreen mainScreen].bounds.size.width * 0.8, [UIScreen mainScreen].bounds.size.height * 0.2);
    } else {
        return _hungPoint;
    }
}

- (CGSize)hungSize {
    if(_hungSize.height == InitPosiValue && _hungSize.width == InitPosiValue) {
        return CGSizeMake(50, 50);
    } else {
        return _hungSize;
    }
}

- (WYFloatAnimationImageView *)hungImageView {
    if(!_hungImageView) {
        _hungImageView = [[WYFloatAnimationImageView alloc] initWithFrame:[self calHungImageInitFrame]];
    }
    return _hungImageView;
}

@end
