Factors influencing performance
===============================

There are various factors which come into play and which can influence the
performance of specific WSGI servers and the WSGI application running on
top of it. These do not always act in isolation but instead combine with
other factors to dictate what you can do to make your overall system
perform better.

Host operating system
---------------------

It is probably safe to say that the most popular operating system used when
deploying Python web applications is Linux [#django-sites-stats]_. This is
the case for a variety of reasons, including performance and cost. Other
lessor used options are UNIX operating systems such as FreeBSD, OpenBSD,
Solaris, HP/UX, IBM/AIX and Mac OSX.

Windows is also obviously an option, but the choice of production quality
WSGI servers capable of running on the Windows operating system is much
more limited. Restrictions on process forking also limit how web servers
can be architected resulting in a reliance on multi threaded server
configurations over multi process configurations. Overall, as a server
solution Windows is simply not a particularly good choice for hosting a
production Python web application.

Since Linux is likely to be the operating system chosen, there will be no
attempt here to try to compare it to other choices and look at what factors
deriving from the operating system can impact performance of the WSGI
server and WSGI application. Trying to identify such factors is also
complicated anyway where the operating system isn't deployed direct to
hardware, but a virtualised system of some form is instead being used to
host the operating system instance.

.. [#django-sites-stats] `Django deployment statistics - djangosites.org
                         <http://www.djangosites.org/stats/>`_

Hardware configuration
----------------------

More and faster processors, more main memory, more cache memory, faster
network interfaces and faster disks are nearly always going to boost
performance. Better hardware, although it may allow you to scale vertically
will ultimately be a costly exercise. The use of bigger and better systems
needs to be balanced against the use of cheaper hardware and scaling
horizontally.

Ignoring the issues of horizontal versus vertical scaling, the main factors
related to the hardware which influence choice of WSGI hosting solution and
how it is configured is the number of processors and the amount of memory
available.

The number of processors available influences how many tasks can be run
concurrently. Because of how the Python global interpreter lock works,
multiple threads within a single process executing Python code can not
however run at the same time. For I/O bound tasks this is not usually an
issue, but for CPU bound tasks it can be. Depending on what tasks the
WSGI application is performing, better concurrency can therefore be
achieved by using processes over threads.

Memory then though becomes an issue because dynamic web applications
implemented in Python, especially those using one of the larger Python web
frameworks, can have a large memory footprint. How much memory you have
available will dictate how big your application can grow, but also how many
instances of the web application you can have running. As you find the right
balance for the type of tasks being run, this will control how many
processes can be used in preference to using more threads with less
processes.

This is all made more complicated due to design problems in the global
interpreter lock thread scheduling mechanisms in Python 2.X. Although adding
more processors should technically allow more work to be done concurrently,
the design problems actually result in reduced performance when using
multithreading and many CPU bound tasks within the one process.

Performance of the network
--------------------------

Although you may be able to control the bandwidth available and latency of
the network within your data centre and also choose which network provider
you use to connect to the greater Internet, you have no control over how
your users connect to the Internet.

A users connection could use a range of technologies including optical
fibre, cable, ADSL, 3G or satellite. These have varying real world
characteristics for bandwidth and latency. Slow speed and high latency
connections are especially problematic as they can result in a connection
needing to be held between the client and server for a longer period of
time.

Depending on the server architecture used and how the WSGI server is
implemented or configured, slow clients can result in processes and/or
threads being tied up waiting for a slow client. Where it is expected that
many slow clients will need to be served, for example mobile clients, if it
isn't possible to increase the number of processes/threads available to
handle requests on a single system due to memory constraints, then the
number of concurrent users that can be supported will be reduced with an
effective reduction of overall request throughput achievable.

WSGI server architecture
------------------------

The WSGI specification defines an API which requires the WSGI server to be
able to handle an application blocking while handling a specific request.
This means that in order to be able to handle concurrent requests, the WSGI
server must use either multiple processes or multiple threads within a
single process.

These aren't the only two choices however. A WSGI server may use multiple
processes but where each process still makes use of multiple threads to
handle requests. In place of threads a WSGI server may also achieve
concurrency with a single process through coperative multitasking,
implemented using coroutines.

Each different approach results in subtle and not so subtle differences as
far as how much memory is used and how much true parallelism is achieved.

For multiprocess architectures, where multiple processes are listening on
the same socket connection for incoming requests, different approaches are
taken to mediate which process handles the next request. Some of these are
better than others as far as avoiding processes unnessarily being woken up
to potentially handle a request, and of ensuring that a process only
accepts a request when it has the resources to handle it.

For some WSGI server architecures there is in effect always a front end by
which requests are proxied and this can also affect the overall way
requests are handled and the behaviour of the system as a whole. For
others, although a front end isn't required, it is recommended because of
the way the WSGI server is designed. Don't use a front end in those cases
and performance may be affected for certain use cases.

The characteristics of each WSGI server architecture is probably the least
understood and most poorly documented thing about the different WSGI
hosting solutions. Yet, understanding the nuances of the WSGI server
architecture being used can be important when it comes to setting it up
properly such that it will perform at its best. This is especially the case
when situations arise outside of the norm.

WSGI application design
-----------------------

Which WSGI hosting solution you can use, or how one is configured can also
be dictated by the design of the WSGI application running on top of it.

The prime example of where this can occur is where the WSGI application has
not been designed and implemented such that it is thread safe. In not being
thread safe it will not be possible to use a WSGI hosting solution or
configuration which makes use of multithreading.

One consequence for this specific case is that more overall memory can end
up being used. This is due to requiring more instances of the WSGI
application when needing to handle a high number of concurrent requests.

This sort of issue can be exacerbated where a WSGI application keeps a
connection open for a long time due to requests taking a long time to
process, or because the WSGI application is handling large file uploads or
downloads.

So, as much as it is important to understand the WSGI server architecture
to be able to set up the WSGI server correctly, you first need to understand
what requirements your WSGI application places on it.

The need to understand this is why trying to optimise the performance of
the WSGI server before you have written your web application, or before you
have undertaken to perform any performance monitoring of your site, is in
part a pointless task.
