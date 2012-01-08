Is performance even an issue?
=============================

Many developers get overly concerned with performance too early in the
design and development of their web application. Reality is that for most
people, unless they really stuff things up, it will not matter what WSGI
hosting solution they choose or how they configure it.

This is because most sites will never get enough traffic to warrant needing
to tune the server to the specific task at hand. That said, the defaults
for some WSGI server architectures aren't the best choices for memory
hungry Python web applications. So there are some basic things that one
should avoid, but more often that not, going beyond that will not make any
real difference.

Some developers will use the argument when asking what is the best way of
setting up a WSGI hosting solution, before they have even written their web
application, that they would rather simply get that bit right first. This is
flawed thinking and will usually only result in them wasting time when they
could be developing their web application instead.

This is more so the case due to the fact that most of the time it isn't
going to be the WSGI hosting mechanism which is the bottleneck. Instead it
is going to be the performance of web pages when rendered by the browser,
the performance of the database, or the time consumed talking to back end
web services.

Before launching into trying to improve the performance of your WSGI
hosting solution you are much better off focusing on implementing a
permanent monitoring solution for your production web application. With
monitoring in place you will be able to properly identify where you really
need to devote time in order to improve the overall performance of your web
site and how the user experiences it.

So, assuming you have done that and have fixed all those other poor
performing parts of your overall system, now you might start trying to get
the most possible out of the WSGI hosting solution.
