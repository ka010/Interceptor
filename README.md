# About
Interceptor is a Growl Display that allows other Applications to receive Growl Notifications via NSDistributedNotificationCenter  
 
Basically it does two things, if a Growl notification arrives it:

1. Displays the notification using a regular display style (configurable in the settings)

2. Posts a NSNotification to the NSDistributedNotificationCenter including the notifications content encoded in JSON.  

# Usage
Here's how to receive notifications from Interceptor in another Application 
  
First, subscribe to the notification

```
/*
  Subscribe to Interceptor Notications
*/
[[NSDistributedNotificationCenter defaultCenter]addObserver:self 
                                                   selector:@selector(mwmDidReceiveNotification:) 
                                                       name:@"InterceptorGrowlNotification" 
                                                       object:nil];
```
  
Then setup a method to handle Notifications. The data is encoded in JSON and formatted like this:


```
{
	"src":"Growl",
	
	"title":"Preview",
	
	"text":"This is a preview of the Interceptor display"
}
```


Use a JSON parser to get a dictionary representation of the above.

```
-(void)mwmDidReceiveNotification:(NSNotification*)aNotification {
    NSDictionary *dict = (NSDictionary*)[parser objectWithString:[aNotification object]];
   // do something 
}
```