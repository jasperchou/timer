# timer
定时器,倒计时管理.周期执行，超时处理。服务器时间同步。

###Feature
* 只维持一个定时器来实现：所有需要循环定时的操作；
* 支持超时之后的处理；
* 支持自动移除超时的obj；
* 支持设置服务器时间,同步，
	* 需要你实现定时校对，可避免本地时间被修改导致倒计时不准确的问题；
	* 设置服务器时间后可以对服务器时钟进行本地模拟
	* 快慢时钟，模拟用的是10秒一次的低频率时钟（即，一分钟定时器只执行6次来更新服务器时间），当有obj才使用高频率时钟


todo：
* I dont know now....Please give me some ideas.

```objc
    /*
     *可以网络获取服务器时间对manager进行设置先。
     *当有设置服务器时间的时候会按照10秒一次的时间进行时钟，避免不必要的执行
     */
    NSTimeInterval delayInterval = [[NSDate date] timeIntervalSince1970] + 20;
    [[JPTimeTickManager shareTickManager]addTimeTickLabel:self.timeL withExpiresTime:delayInterval prefix:@"我在倒计时: " withExpiresHandler:^(JPTimeTickObj *obj) {
        NSLog(@"我是handler, obj:%@", obj);
    }];
```

##License

The MIT License (MIT)

Copyright (c) 2014 Jasper @Jasper

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.