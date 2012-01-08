Benchmarking of WSGI servers
============================

Web site performance can be measured at many levels using a range of
different performance indicators. Athough these may target either business
or technical objectives, they still all relate to some extent. If a
bottleneck in the performance of your underlying WSGI server is preventing
you from handling requests efficiently and causing the user to be
disatisfied in some way, it will ultimately impact on the business level
performance indicators.

Determining how well a WSGI server and the WSGI application running on top
of it is performing, and the capacity it has for handling an increasing
number of visitors, is usually determined through benchmarking of the web
server in a development or staging environment.

Unfortunately, the inexperienced user's idea of benchmarking is usually to
point a load testing tool at a WSGI server and go full throttle, saturating
the WSGI server with requests. This is not a realitistic test, it is a
denial of service attack.

Even when a more conservative approach is taken of incrementally ramping up
the number of concurrent users and monitoring metrics for such things as
throughput, response times, cpu load and memory usage, testing is more
often than not performed with a single host operating system and WSGI server
configuration, and with nothing more than a simple 'Hello World'
application.

Simple tests like this also fall short in that they don't simulate properly
the reality that users are located in diverse locations with different
network connection speeds and use a range of web browsers that behave
differently.

Such benchmarks are therefore still arbitrary and do nothing to help one
understand the true dynamics of how a WSGI server and application stack
behaves in a production setting under different types of traffic loads
and for different types of tasks.

The ideal scenario is to employ production monitoring tools to continuously
monitor various performance metrics of your actual deployed production site.
This needs to range from tracking time spent dealing with databases,
external web services, the application itself, right back to the end user
through real user monitoring using in browser analytics.

Even then, the issue is how does one interpret the data from such
monitoring tools and how do you know what effect a change to the WSGI
server configuration or architecture may have before you deploy it.

You therefore in some respects have no choice but to undertake some
benchmarking in a development or staging environment, but this cannot be
used as some sort of absolute measure. The best you can do is use it to
better understand how what you have works and based on that knowledge
more easily infer what is going on with your production application.

This part of the 'WSGI Guide' intends to go beyond these simplistic
benchmarks, and for a range of WSGI servers, try and come up with
suggestions for some more targeted tests which can help you to explore the
performance characteristics of different WSGI hosting solutions.

In practice one shouldn't perhaps even refer to these tests as benchmarks
as they aren't intended to provide a way of peforming direct comparisons
between different solutions. As mentioned they are instead intended to help
you understand how what you have works and whether how it behaves is
suitable for your specific application. This could then lead you to
adjusting the configuration of the host operating system or WSGI server
being used, or if necessary, see you move to an alternate solution that
does have the characteristics you need.

Topics covered in this section:

.. toctree::
   :maxdepth: 2

   premature-optimisation

   performance-factors
   performance-metrics

   server-architectures

   process-memory-usage
   process-startup-costs
