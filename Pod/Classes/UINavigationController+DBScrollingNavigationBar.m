//
//  UINavigationController+DBScrollingNavigationBar.m
//
//
//  GitHub
//  https://github.com/DevonBoyer/DBScrollingNavigationBar
//
//
//  Created by Devon Boyer on 2015-06-12.
//  Copyright (c) 2014 Devon Boyer. All rights reserved.
//
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "UINavigationController+DBScrollingNavigationBar.h"

@implementation UINavigationController (DBScrollingNavigationBar)

static CGPoint previousContentOffset;

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    CGSize contentSize = scrollView.contentSize;
    
    if (contentSize.height < CGRectGetHeight(scrollView.frame)) {
        return;
    }
    
    CGRect navigationBarFrame = self.navigationBar.frame;
    
    CGFloat framePercentHidden = (20 - navigationBarFrame.origin.y) / (CGRectGetHeight(navigationBarFrame) - 1);
    [self updateBarButtonItemsPercentTransitioned:1 - framePercentHidden];
    
    CGFloat minY = CGRectGetHeight(navigationBarFrame) - 21;
    CGFloat scrollDiff = contentOffset.y - previousContentOffset.y;
    CGFloat scrollViewContentSizeHeight = contentSize.height + scrollView.contentInset.bottom;
    
    if (navigationBarFrame.origin.y == -minY && contentOffset.y >= (-scrollView.contentInset.top + CGRectGetHeight(navigationBarFrame) - 1)) {
        // If the velocity is not above threshold do not pull back down
        CGPoint velocity = [scrollView.panGestureRecognizer velocityInView:scrollView.panGestureRecognizer.view];
        if (velocity.y < 420) {
            previousContentOffset = contentOffset;
            return;
        }
    }
    
    if (contentOffset.y <= -scrollView.contentInset.top) {
        navigationBarFrame.origin.y = 20;
    } else if (contentOffset.y + CGRectGetHeight(scrollView.frame) >= scrollViewContentSizeHeight ) {
        navigationBarFrame.origin.y = -minY;
    } else {
        navigationBarFrame.origin.y = MIN(20, MAX(-minY, navigationBarFrame.origin.y - scrollDiff));
    }
    
    self.navigationBar.frame = navigationBarFrame;
    previousContentOffset = contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrolling:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndScrolling:scrollView];
    }
}

#pragma mark - Helpers

- (void)scrollViewDidEndScrolling:(UIScrollView *)scrollView
{
    CGRect navigationBarFrame = self.navigationBar.frame;
    if (navigationBarFrame.origin.y < 0) {
        
        CGFloat minY = -(navigationBarFrame.size.height - 21);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect navigationBarFrame = self.navigationBar.frame;
            scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y + (navigationBarFrame.origin.y - minY));
            
            navigationBarFrame.origin.y = minY;
            [self.navigationBar setFrame:navigationBarFrame];
            [self updateBarButtonItemsPercentTransitioned:0];
        }];
    } else {
        
        CGFloat maxY = 20;
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect navigationBarFrame = self.navigationBar.frame;
            navigationBarFrame.origin.y = maxY;
            [self.navigationBar setFrame:navigationBarFrame];
            [self updateBarButtonItemsPercentTransitioned:1];
        }];
    }
}

- (void)updateBarButtonItemsPercentTransitioned:(CGFloat)percentTransitioned
{
    [self.topViewController.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = percentTransitioned;
    }];
    [self.topViewController.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = percentTransitioned;
    }];
    self.topViewController.navigationItem.titleView.alpha = percentTransitioned;
    self.navigationBar.tintColor = [self.navigationBar.tintColor colorWithAlphaComponent:percentTransitioned];
    
    // Does not animate when scrolling ends. Recommendation is to use a titleView.
    NSMutableDictionary *titleTextAttributes;
    titleTextAttributes = [self.navigationBar.titleTextAttributes mutableCopy] ?: [NSMutableDictionary dictionary];
    titleTextAttributes[NSForegroundColorAttributeName] = [titleTextAttributes[NSForegroundColorAttributeName]  ?: [UIColor blackColor] colorWithAlphaComponent:percentTransitioned];
    self.navigationBar.titleTextAttributes = titleTextAttributes;
}

@end
