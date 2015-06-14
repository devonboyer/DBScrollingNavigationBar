//
//  UITabBarController+DBScrollingTabBar.h
//  Pods
//
//  Created by Devon Boyer on 2015-06-13.
//
//

#import <UIKit/UIKit.h>

@interface UITabBarController (DBScrollingTabBar)

// Forward these calls from desired scroll view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
