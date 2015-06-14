//
//  UITabBarController+DBScrollingTabBar.h
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

#import <UIKit/UIKit.h>

@interface UITabBarController (DBScrollingTabBar)

// Forward these calls from desired scroll view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
