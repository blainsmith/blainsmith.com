---
date: 2018-08-03T00:00:00Z
title: Linux System Metrics with collectd
---

This tutorial assumes you have the following software installed.

* [https://collectd.org](https://collectd.org/)
* [https://www.docker.com](https://www.docker.com/)


collectd is a general purpose system metrics collection tool that supports various plugins for **reading** metrics from **sources** and **writing** results to **destinations**. Multiple sources can be read and then written to multiple destinations which makes collectd very flexible. For example, you can collect CPU, Memory, and Load information and write those results every 10ms to CSV, Redis, and RDD (we will get to that).

For this tutorial we will be collecting very basic system metrics and writing them to a few output formats. We will set up collectd to monitor and store the following metrics.

* CPU usage
* CPU temperature
* Load
* Memory (virtual and swap)
* Disk
* Battery


Each of these metrics above represent a **read plugin** in collectd and each can be configured separately. We will assume the defaults though. Then we will set up collectd to write to the following output formats.

* RDD (TL;DR efficient binary data format made for collecting time series data in a ring buffer)
* CSV

Each of these metrics above represent a **write plugin** in collectd and each can be configured separately.

There is a [full list of plugins](https://collectd.org/wiki/index.php/Table_of_Plugins) available on the collectd wiki.

## Configure collectd

The default path collectd keeps its configuration file is in `/etc/collectd/collectd.conf`. We need to edit this file to set up the plugins we want to use.

```
$ cd /etc/collectd

# Create a backup of the default configuration
$ cp collectd.conf collectd.default.conf

```

Open `/etc/collectd/collectd.conf` in your preferred editor and overwrite it with the following:

```
# This tells collectd to lookup the hostname for storing data
# in a folder with that name
FQDNLookup true

# This is the read interval in milliseconds
Interval 5000

# Load the syslog plugin
LoadPlugin syslog

# Configure the syslog plugin to log only errors
<Plugin syslog>
    LogLevel error
</Plugin>

# Load the following plugins for collectd to read/write with
LoadPlugin battery
LoadPlugin cpu
LoadPlugin csv
LoadPlugin disk
LoadPlugin load
LoadPlugin memory
LoadPlugin rrdtool
LoadPlugin swap
LoadPlugin thermal

# Configure the csv plugin
<Plugin csv>
    DataDir "/var/lib/collectd/csv"
    StoreRates true
</Plugin>

# Configure the rrdtool plugin
<Plugin rrdtool>
    DataDir "/var/lib/collectd/rrd"
</Plugin>

```

Save the file and now we have a minimal configuration.


## Running collectd

If you installed collectd via a package manager then chances are there will be a SystemD service available to use.

```
# Start the collecd system service
$ sudo systemctl start collectd

```

collectd should now be running and collecting metrics and writing data to the folders specified in the configuration file.


## Verify collectd

We set up the CSV plugin to verify we are collecting information since the RDD plugin can't be read by humans. CSV is easier to read via the command line.

```
# View some metrics
$ cd /var/lib/collectd

# List the host folders, the folder name will differ on your machine
$ ls -lah
total 12K
drwxr-xr-x  3 root root 4.0K Aug 13 11:13 ./
drwxr-xr-x  4 root root 4.0K Aug 13 11:13 ../
drwxr-xr-x 44 root root 4.0K Aug 13 11:14 pop-os.localdomain/

$ cd pop-os.localdomain
$ ls -lah
total 176K
drwxr-xr-x 44 root root 4.0K Aug 13 11:14 ./
drwxr-xr-x  3 root root 4.0K Aug 13 11:13 ../
drwxr-xr-x  2 root root 4.0K Aug 13 11:13 battery-0/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 cpu-0/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 cpu-1/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 cpu-2/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 cpu-3/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 cpu-4/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 cpu-5/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 cpu-6/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 cpu-7/
d--xrwxrwx  2 root root 4.0K Aug 13 11:15 disk-dm-0/
d--xrwxrwx  2 root root 4.0K Aug 13 11:15 disk-dm-1/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-dm-2/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-loop0/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-loop1/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-loop2/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-loop3/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-loop4/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-loop5/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-loop6/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-nvme0n1/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-nvme0n1p1/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-nvme0n1p2/
d--xrwxrwx  2 root root 4.0K Aug 13 11:15 disk-nvme0n1p3/
d--xrwxrwx  2 root root 4.0K Aug 13 11:14 disk-nvme0n1p4/
drwxr-xr-x  2 root root 4.0K Aug 13 11:13 load/
drwxr-xr-x  2 root root 4.0K Aug 13 11:13 memory/
drwxr-xr-x  2 root root 4.0K Aug 13 11:13 swap/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device0/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device1/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device2/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device3/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device4/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device5/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device6/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device7/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-cooling_device8/
drwxr-xr-x  2 root root 4.0K Aug 13 11:13 thermal-cooling_device9/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-thermal_zone0/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-thermal_zone1/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-thermal_zone2/
d--xrwxrwx  2 root root 4.0K Aug 13 11:13 thermal-thermal_zone3/

```

You can see how the metrics are actually being stored on disk. The RDD plugin has a similar folder structure under `/var/lib/collectd/pop-os.localdomain/rdd` which you can browse as well.

```
# View system load
$ cd load/

# You will have different filenames here with a different date
$ cat load-2018-08-13
epoch,shortterm,midterm,longterm
1534182073.078,0.500000,0.550000,0.430000
1534182083.078,0.660000,0.580000,0.440000
1534182093.078,0.560000,0.560000,0.440000
1534182103.078,0.550000,0.560000,0.440000
1534182113.078,0.700000,0.590000,0.450000
1534182123.078,0.830000,0.620000,0.460000
1534182133.078,0.700000,0.600000,0.460000
1534182143.078,0.670000,0.600000,0.460000
1534182153.078,0.560000,0.580000,0.450000
1534182163.078,0.480000,0.560000,0.450000
1534182173.078,0.640000,0.590000,0.460000
1534182183.078,0.540000,0.570000,0.450000
1534182193.078,0.780000,0.620000,0.470000
1534182203.079,0.660000,0.600000,0.470000
1534182213.078,0.640000,0.590000,0.470000
1534182223.078,0.540000,0.570000,0.460000

```

Now we see the load information collectd has been collecting on the interval we have specified. For this example I have 10ms specified for the interval to show more data. The corresponding RDD binary file is at `/var/lib/collectd/rdd/pop-os.localdomain/load/load.rdd` which we will use for the UI in the next section.


## Viewing collectd metrics with charts

The CSV files are all well and good, but we can actually generate charts from the raw binary RDD files with a simple docker container running Collectd Graph Panel. This web UI read RDD files from disk and displays charts for each host it has data for.

Now that you have the metrics on your local machine you can simply run the docker container to run a local web app that will allow you to browse the results.

```
# Run the container and mount a volume of the RDD data
$ docker run -v /var/lib/collectd/rrd:/var/lib/collectd/rrd -p 8080:80
konjak/cgp

```

Open a web browser and go to the following address: http://localhost:8080 and you should see something like this.

![](https://s3.amazonaws.com/dev.beautifulatlas.com/uploads/56a5df1a-939c-4915-8a9b-d1e0b6543224/ee2772f3-2467-4fab-9e97-7c90133ec31f/Screenshot%20from%202018-08-13%2014-11-21.png)

You can see I have multiple hosts so it will list every host (device) it has data for. Click on the host you want to view charts for and you should see something like this.

![](https://s3.amazonaws.com/dev.beautifulatlas.com/uploads/56a5df1a-939c-4915-8a9b-d1e0b6543224/528c0d0d-3695-48bb-819b-13ad8cd758f8/Screenshot%20from%202018-08-13%2014-12-32.png)

Oooooo charts! Now you can click on the left menu to drill down. Enjoy!