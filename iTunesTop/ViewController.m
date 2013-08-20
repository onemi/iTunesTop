//
//  ViewController.m
//  iTunesTop
//
//  Created by Диана Корсак on 08.08.13.
//  Copyright (c) 2013 Диана Корсак. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *topSongs;
- (IBAction)refreshButton:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self topSongs] setDelegate:self];
    [[self topSongs] setDataSource:self];
    array = [[NSMutableArray alloc] init];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webData setLength:0];

}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webData appendData:data];

}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"fail with error");


}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *allDataDictinary  = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSDictionary *feed = [allDataDictinary objectForKey:@"feed"];
    NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
    for (NSDictionary *diction in arrayOfEntry) {
        NSDictionary *title = [diction objectForKey:@"title"];
        NSString *label = [title objectForKey:@"label"];

        [array addObject:label];

    }

    [self.topSongs reloadData]; 

}



- (IBAction)refreshButton:(id)sender {

    [array removeAllObjects];

    NSString *number = @"20";
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/topalbums/limit=%d/json", [number intValue]];
    NSURL *url = [NSURL URLWithString:urlStr];


   
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    connection = [NSURLConnection connectionWithRequest:request delegate:self];

    if (connection) {
        webData = [[NSMutableData alloc] init];

    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [array count]; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell; 
}

@end
