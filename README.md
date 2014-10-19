#dns-check                                                                                                                                                                                                                                   

[![Code Climate](https://codeclimate.com/github/alouche/dns-check.png)](https://codeclimate.com/github/alouche/dns-check)
[![Dependency Status](https://gemnasium.com/alouche/dns-check.png)](https://gemnasium.com/alouche/dns-check)
[![Gem Version](https://badge.fury.io/rb/dns-check.png)](http://badge.fury.io/rb/dns-check)

CLI base DNS check propagation tool

![Image](http://farm9.staticflickr.com/8086/8521646535_3c2b6376cd_b_d.jpg)

### Note

* While the tool works - it was hacked in an hour or so with the only purpose in mind to get some work done. That being said, there are still a couple of TODO/FIXME lurking in the code and likely a couple of refactoring needed... and of course, some test units. I am releasing it in the hope it is useful to someone else.

## Requirements

Ruby 1.9.3

## Getting started

* gem install dns-check
* dns-check --update

## Usage
Usage: dns-check [options] [domain]
```bash
    Options:
    -l, --location   [name]          Location can either be a country or city
    -t, --timeout    [sec]           DNS Query timeout (Default: 5s)
        --records    [size]          Number of nameservers to select (default: 10)
        --sep        [sep]           Set separator (default: |)
        --show-ns                    Show nameservers
        --update                     Perform indice update
        --no-recursion               Disable recursion
        --debug
    -v, --version                    Show version
    -h, -?, --help                   Show this message
```
### Examples
```bash
    $ dns-check google.com --records 5
    Hong Kong/Central District|74.125.128.100
    Taiwan/NN|74.125.31.138
    Saudi Arabia/NN|173.194.35.96
    Afghanistan/NN|173.194.72.139
    Guatemala/El Salvador|74.125.137.139
```

```bash
    $ dns-check google.com --location Berlin --show-ns
    Berlin|173.194.70.101|194.77.8.1
    Berlin|173.194.70.138|alhazred.hsd.de
    Berlin|173.194.70.113|192.166.192.2
```

```bash
    $ dns-check google.com --records 5 --location US --show-ns
    Longmont|74.125.225.195|209.97.224.3
    Burlington|74.125.226.228|64.17.101.12
    Romney|74.125.140.138|resolve01.rmny.wv.frontiernet.net
    Deerfield Beach|74.125.229.238|216.242.0.15
    North Attleboro|173.194.34.102|207.180.2.6
```

```bash
    $ dns-check google.com --records 5 --location US
    El Paso|173.194.46.5
    Atlanta|74.125.228.34
    Greenville|74.125.227.128
    Newark|74.125.228.64
    Baltimore|74.125.228.34
```

```bash
    $ dns-check google.com --records 2 --location Atlanta --show-ns
    Atlanta|173.194.37.67|ns.echina.com
    Atlanta|74.125.137.100|64.94.1.1
```
