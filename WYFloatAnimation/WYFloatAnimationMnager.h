//
//  WYFloatAnimationMnager.h
//  WYFloatAnimation
//
//  Created by wyan assert on 2017/1/2.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WYFloatAnimationMnager : NSObject

- (instancetype)initWithAssoicatedView:(UIView *)associatedView;

- (void)startAnimation;
- (void)stopAnimation;

- (void)changeImage;

@property (nonatomic, assign) CGPoint hungPoint;
@property (nonatomic, assign) CGSize  hungSize;

@end
