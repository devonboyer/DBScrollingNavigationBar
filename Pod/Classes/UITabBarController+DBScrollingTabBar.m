//
//  UITabBarController+DBScrollingTabBar.m
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

#import "UITabBarController+DBScrollingTabBar.h"

@implementation UITabBarController (DBScrollingTabBar)

static CGPoint previousContentOffset;

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;
    CGSize contentSize = scrollView.contentSize;
    CGRect tabBarFrame = self.tabBar.frame;
    
    CGFloat minY = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(tabBarFrame);
    CGFloat maxY = CGRectGetHeight(self.view.bounds);
    CGFloat scrollDiff = contentOffset.y - previousContentOffset.y;
    CGFloat scrollViewContentSizeHeight = contentSize.height + scrollView.contentInset.bottom;
    
    // TODO: Add support for a threshold velocity in order to pull tabBar back up
    
    if (contentOffset.y <= -scrollView.contentInset.top) {
        tabBarFrame.origin.y = minY;
    } else if (contentOffset.y + CGRectGetHeight(scrollView.frame) >= scrollViewContentSizeHeight) {
        tabBarFrame.origin.y = minY;
    } else if (tabBarFrame.origin.y > minY && contentOffset.y + CGRectGetHeight(scrollView.frame) >= (scrollViewContentSizeHeight - CGRectGetHeight(tabBarFrame))) {
        tabBarFrame.origin.y = MAX(minY, MIN(maxY, tabBarFrame.origin.y - scrollDiff));
    }  else {
        tabBarFrame.origin.y = MAX(minY, MIN(maxY, tabBarFrame.origin.y + scrollDiff));
    }
    
    self.tabBar.frame = tabBarFrame;
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
    CGRect tabBarFrame = self.tabBar.frame;
    CGFloat maxY = CGRectGetHeight(self.view.bounds);
    CGFloat minY = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(tabBarFrame);

    if (tabBarFrame.origin.y == minY || tabBarFrame.origin.y == maxY) {
        return;
    }
    
    if (tabBarFrame.origin.y < maxY && tabBarFrame.origin.y > (minY + 20)) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect tabBarFrame = self.tabBar.frame;
            tabBarFrame.origin.y = maxY;
            [self.tabBar setFrame:tabBarFrame];
        }];
    } else  {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect tabBarFrame = self.tabBar.frame;
            tabBarFrame.origin.y = minY;
            [self.tabBar setFrame:tabBarFrame];
        }];
    }
}

@end
