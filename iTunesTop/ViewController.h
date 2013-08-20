//
//  ViewController.h
//  iTunesTop
//
//  Created by Диана Корсак on 08.08.13.
//  Copyright (c) 2013 Диана Корсак. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate> {
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array; 
}

@end
