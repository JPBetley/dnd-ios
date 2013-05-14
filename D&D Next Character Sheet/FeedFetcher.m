//
//  FeedFetcher.m
//  Reader
//
//  Created by Tony Jefferson on 4/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeedFetcher.h"


@implementation FeedFetcher
@synthesize urlString, responseData, urlConnection;
@synthesize xmlParser, itemArray, currentItemDict, currentElement, currentTitle, currentDate, currentSummary, currentLink;
@synthesize feedDelegate,alertDelegate;
#pragma mark -
#pragma mark Initialization
// Designated Initializer
- (id)initWithURL:(NSString *)value{
	self = [super init];
	if (self != nil) {
		// init ivars
		self.urlString = value;
		self.responseData = [NSMutableData data];
		self.itemArray = [NSMutableArray array];
		[self loadData];
	}
	return self;
}

- (id) init{
	[NSException raise:@"Invalid initializer" format:@"Call initWithURL: (NSString*)urlString instead!"];
	return nil;
}

#pragma mark -
#pragma mark Helper methods
- (void)loadData{
	NSURL *url = [NSURL URLWithString:self.urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
											 cachePolicy:NSURLRequestUseProtocolCachePolicy 
										 timeoutInterval:10.0];
	
	// make the connection and retrieve the data
	urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (urlConnection) {
		
	} else {
		//NSLog(@"Could not make NSURLConnection! urlConnection=%@",urlConnection);
		[self fetchFailed];
	}
	
	//NSLog(@"NSURLConnection created! urlConnection=%@",urlConnection);
	
}

- (void)fetchFailed{
	//	NSLog(@"Attempt to download %@ failed!",self.urlString);
	[urlConnection cancel];
	NSString * errorString = [NSString stringWithFormat:@"Unable to connect to %@", self.urlString];
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Connection error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
	[errorAlert show];
}


#pragma mark -
#pragma mark NSURLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	// cast NSURLResponse to NSHTTPURLResponse
	NSHTTPURLResponse * httpResponse =  (NSHTTPURLResponse *)response;
	int statusCode = [httpResponse statusCode];
	//	NSLog(@"didReceiveResponse response = %@",httpResponse);
	//	NSLog(@"status code = %d",statusCode );
	//	NSLog(@"headers = %@",[httpResponse allHeaderFields]  );
	if (statusCode == 404 || statusCode == 500 ){
		[self fetchFailed];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	//	NSLog(@"didReceiveData");
	[responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	//NSLog(@"connectionDidFinishLoading");
	[self parseData]; 
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	[self fetchFailed];
	//NSLog(@"connection=%@ didFailWithError error= %@",self.urlConnection, error);
}


#pragma mark -
#pragma mark XML parsing methods
- (void)parseData{
	NSXMLParser *newParser = [[NSXMLParser alloc] initWithData: responseData];
	newParser.delegate = self;
	newParser.shouldResolveExternalEntities = NO;
	newParser.shouldProcessNamespaces = NO;
	newParser.shouldReportNamespacePrefixes = NO;
	
	self.xmlParser = newParser;
	
	if (![self.xmlParser parse]){
		NSLog(@"error in parse method call. error=%@ lineNumber =%d",[self.xmlParser parserError],[self.xmlParser lineNumber] );
	}
}

#pragma mark -
#pragma mark NSXMLParserDelegate delegate methods 
- (void)parserDidStartDocument:(NSXMLParser *)parser{
//	NSLog(@"parserDidStartDocument");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
//	NSLog(@"parserDidEndDocument");
//	NSLog(@"itemArray =%@",self.itemArray);
	[self.feedDelegate feedFetcher:self didLoadFeed:self.itemArray];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
		NSLog(@"parseErrorOccurred parseError = %@, lineNumber=%d, columnNumber=%d",parseError,[parser lineNumber], [parser columnNumber] );
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %d ) on line %d", [parseError code],[parser lineNumber]];
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
	[errorAlert show];
}

// called when there are start tags
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
//		NSLog(@"elementName=%@",elementName);
	self.currentElement = elementName; 
	if ([elementName isEqualToString:@"item"]) { 
		// clear out our story item caches...
		//	[self.currentItemDict removeAllObjects];
		self.currentItemDict = [NSMutableDictionary dictionary];
		self.currentTitle = [NSMutableString string];
		self.currentDate = [NSMutableString string]; 
		self.currentSummary = [NSMutableString string]; 
		self.currentLink = [NSMutableString string]; 
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//	NSLog(@"found characters: %@", string); 
	// save the characters for the current item
	if ([self.currentElement isEqualToString:@"title"]) { 
		[self.currentTitle appendString:string]; 
	} else if ([self.currentElement isEqualToString:@"link"]) { 
		[self.currentLink appendString:string];
	} else if ([self.currentElement isEqualToString:@"description"]) { 
		[self.currentSummary appendString:string]; 
	} else if ([self.currentElement isEqualToString:@"pubDate"]) { 
		[self.currentDate appendString:string]; 
	} 
} 

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
//	NSLog(@"didEndElement element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array... 
		[self.currentItemDict setObject: [self flattenHTML:self.currentTitle] forKey:@"title"];
		[self.currentItemDict setObject:self.currentLink forKey:@"link"];
		[self.currentItemDict setObject:self.currentSummary forKey:@"description"]; 
		[self.currentItemDict setObject:self.currentDate forKey:@"pubDate"]; 
		NSMutableDictionary *tempDict = [self.currentItemDict copy];
		[self.itemArray addObject: tempDict]; 
		NSLog(@"adding item named: %@", self.currentTitle); 
	} 
}

// http://rudis.net/content/2009/01/21/flatten-html-content-ie-strip-tags-cocoaobjective-c
- (NSString *)flattenHTML:(NSString *)html {
	
    NSScanner *theScanner;
    NSString *text = nil;
	
    theScanner = [NSScanner scannerWithString:html];
	
    while ([theScanner isAtEnd] == NO) {
		
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
		
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
		
        // replace the found tag with nothing
        html = [html stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@>", text] withString:@""];
		
    } // while //
    
    return html;
	
}




- (void)dealloc{
	NSLog(@"*****************************");
	NSLog(@"dealloc called for %@", self);
	NSLog(@"*****************************");
	[urlConnection cancel];
	[itemArray removeAllObjects];
	
	// deallocations
	
	// "temp" ivars
}

@end
