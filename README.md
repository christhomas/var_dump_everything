# var_dump_everything
Sometimes you need a docker container that you can quickly drop-in as a replacement for your PHPFPM to debug issues. 

The main reason why I created this container is that I was having problems developing a PHP application that I wanted to deploy on AWS ECS using AWS API Gateway and I was unable to debug an issue where the API Gateway was sending requests to the application which I didn't understand.

So I created this container so I can quickly "drop-in" as a replacement for the application's normal phpfpm so I can see the entire request, all the superglobals, server variables, headers, etc. And quickly understand the request and then make alterations to API Gateway to make it work in the desired fashion.

The problem is that if API Gateway doesn't work in the way you expect, there is very little debugging that you can do, since the logs are sparse, the request information appears to be lacking some information you'd find useful, etc, etc. All conspired to make API Gateway quite hard to debug.

This will show you in a very easy and simple to use HTML Page all the request data and then you can finally understand what you need to change and make those adjustments.

You're welcome, future Chris Thomas ;)
