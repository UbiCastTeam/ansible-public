# Benchmarking

This documentation explains how to benchmark a MediaServer to get the maximum viewers that can be handled.
The benchmarking tool is based on Locust.


## Prerequisite

- Ansible and ansible-public repository.
- An SSH access to the machines that will be used to make requests on MediaServer (you can use the workers for that).
- A video on demand or a live stream to test. To create a live stream for the test, please read the section `Prepare a live page` of this documentation.

Note that the machines used by the benchmarker must have an access to UbiCast packages (to get the `ubicast-benchmark` package).


## Hardware requirements

To be able to test a server, the benchmarking tool must use systems with enough CPU, RAM and bandwidth.

You can calculate the required CPU and RAM by extrapolating the following data:

* A 20 threads CPU @ 3.0GHz is required for the benchmark worker to test a hatch rate up to 50.
* A 20 threads CPU @ 3.0GHz is required for the benchmark worker to test up to 3000 viewers.
* 6 GB of RAM is required for the benchmark worker to test up to 3000 viewers.
* A maximum of 5000 viewers can be tested on a single for the benchmark worker system (due to ephemeral ports limit).
* The benchmark server will use approximately 25% of the CPU allocated to workers (for example, if the benchmark worker has 4 CPU, the benchmark server must have 1 CPU at the same speed).


## Prepare a live page

If you want to benchmark the video on demand playback, ignore this section.

This section explains how to get a live page to get an `oid` for the bench.
This live page can be used for the bench even if no video stream is sent to the server when the `bench_dl_streams` is set to `false`.

Steps:

* Login in MediaServer
* Click on the `Add content` button
* Click on `advanced`
* Click on `Add a live stream`
* Click on `For UbiCast or other recorders`
* Set a title, for example `live bench`
* Click on `Add live stream`
* Click on `Edit`
* Check `published`
* Set `live status` to `ongoing`
* Click on `Save changes`
* Open the `Permissions` tab
* Set the access to `yes` for `Non authenticated users`
* Click on `Save changes`
* Open the `Resources` tab
* Click on `Get encoder settings`
* Use the `oid` value in the page url (for example `l125f58fbb8c655nth76`) in your `bench_oid` setting.


## Inventory

Create a new inventory with following configuration.


### Hosts file

This file should be located in `<your inventory>/hosts`.

```
[bench_server]
worker1.test.com

[bench_worker]
worker2.test.com
```

The system targetted with `bench_server` will host the Locust server. This system must be unique.

The systems targetted with `bench_worker` will host the Locust workers. Multiple workers can be used.


### Group vars

This file should be located in `<your inventory>/group_vars/all.yml`.

```
bench_server: <The benchmark server IP or host name>
bench_host: <MediaServer URL. Example: "msauto.ubicast.net">
bench_oid: <Media OID. Example: "l125f58fbb8c655nth76">
bench_user: <MediaServer account username. Can be empty if the media access is not protected. Example: "test">
bench_password: <MediaServer account password. Can be empty if the media access is not protected. Example: "pwd">
bench_host_api_key: <MediaServer master API key>
bench_dl_streams: <Download video streams or not ("true" or "false", "false" is default)>
```


## Install the benchmarker

```
# ansible-playbook -i inventories/<your inventory> playbooks/bench.yml
```
This playbook will install everything you need: benchmark server and benchmark workers.


## Start the benchmarker

Disable anti-ddos in Nginx configuration if any (usually in `/etc/nginx/conf.d/limits.conf`).

If the server hosting the bench server is using a firewall, disable it to be able to access the locust interface. For example, if `ferm` is installed: `systemctl ferm stop`.

If you want to test with a video stream, you can start it with using the docker container:
`cd /usr/share/ms-testing-suite && make run_live`

Or directly by hand:
`/usr/share/ms-testing-suite/ms_live_streamer.py /etc/mediaserver/bench-streaming.conf`

Go with your browser on `http://<bench_server>:8089`. You might have to use an SSH tunnel to access this port.

Set the number of viewers and the hatch rate (usually the hatch rate is 0.25% of the viewers count to reach 30% of the total count in 2 minutes) and start the bench.

Watch for `/var/log/error.log` and `/var/log/access.log` (warning: this file is buffered by default, you can disable buffer in `nginx.conf`).


## Restart Locust server & workers

If you need to restart both server & workers, you can launch the playbook with the tag `prepare-bench`:
```
# ansible-playbook -i inventories/<your inventory> playbooks/bench.yml -t prepare-bench
```


## /!\ EXPERIMENTAL : Elasticsearch + Kibana + metricbeat

Kibana + metricbeat allows you to monitor and display statistics about the infrastructure. This feature is experimental.

First you need to add a new group to your hosts files:
```
[elastic]
elastic1.test.com
```

Then launch the playbook `bench-monitoring` which will install both the elastic suite on the elastic host, and metricbeat on mediaserver & postgres servers.

```
# ansible-playbook -i inventories/<your inventory> playbooks/bench-monitoring.yml
```

Your kibana instance will be accessible at `http://elastic1.test.com:5601`.
