# syslog_ng

[![Build Status](https://travis-ci.org/ihrwein/puppet-syslog_ng.png?branch=master)](https://travis-ci.org/ihrwein/puppet-syslog_ng)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with syslog_ng](#setup)
    * [What syslog_ng affects](#what-syslog_ng-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with syslog_ng](#beginning-with-syslog_ng)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview
This module lets you generate syslog-ng configuration from puppet. It supports
all kind of statements, such as sources, destinations, templates, and so on. After
defining them, you can combine them into a log path. This module also cares about
installing syslog-ng, or reloading it after a configuration file change.

It works well with the following Puppet versions:
  * 2.7.9
  * 2.7.13
  * 2.7.17
  * 3.1.0
  * 3.2.3
  * 3.3.1
  * 3.3.2
  * 3.4.0
  * 3.4.3

Tested Ruby version:
  * 1.8.7
  * 1.9.2

*NOTE*: The module was tested with Travis with these versions. It may work well of
other Puppet or Ruby version. If that's so, please hit me up.

## Module Description
This module integrates with syslog-ng. It supports it's configuration model and
able to generate configurations. You can create new sources and destinations as
Puppet resources, under the hood they are just defined resource types.

The supported statements:
 * options
 * template
 * rewrite
 * parser
 * filter
 * source
 * destination
 * log
 * +1: config, wich lets you insert a premade configuration snippet.

Each type is under the `syslog_ng::` namespace, so you can use them like this:
```
syslog_ng::source { 's_gsoc':
    params => {
        'type' => 'tcp',
        'options' => [
            {'ip' => "'127.0.0.1'"},
            {'port' => 1999}
        }]
    }
}
```
### <a name="statement_syntax"></a> Configuration syntax
Every statement has the same layout. They can accept a `params` parameter, which
can be a hash or an array of hashed. Each hash should have a `type` and `options`
key.

The value of the `type` represents the type of the statements, in case of
sources this can be `file`, `tcp` and so on.

The value of the `options` is an array of strings and hashes. You have to take care
of the quotation when using strings. The inner quotation must be a single quote, and
the outer one a double, like `"'this string'"`. By using this convention, the module
will generate correct configuration files. If the option array is empty, it generates
nothing.

As I mentioned, there are strings and hashed in an option. In case of hashes, they
must contain only one key. This key will identify the name of the parameter and its
value must be an array of strings. If that would contain only one item, the value can
be simply just a string.

You can find a lot of examples under the `tests` and `spec` directories.
## Setup

### Puppet Forge
Currently this module has not been published on Puppet Forge yet.
### Installing from source


To install it, follow the steps:
 0. Make sure you have the required dependencies:
  * rake
  * ruby
  * TODO
 1. Clone its source code into a directory:
 ```
 $ git clone git@github.com:ihrwein/puppet-syslog_ng.git
 ```
 2. Make sure you are on master branch:
 ```
 $ git checkout master
 ```
 3. Build a package:
 ```
 $ rake build
 ```
 This will create a `tar.gz` under a `pkg` directory. Now you should be able to install
 the module:
 ```
 # puppet puppet module install -f ihrwein-syslog_ng-VERSION.tar.gz
 ```

### What syslog_ng affects

* It installs the `syslog-ng` or `syslog-ng-core` package
  * that creates the necessary directories on your system, including `/etc/syslog-ng`
  * if other `syslog` daemon was installed, it will be removed by your package manager
* It purges the content of `/etc/syslog-ng/syslog-ng.conf`



### Beginning with syslog_ng
If you are not familiar with `syslog-ng`, I suggest you to take a look at the
[Syslog-ng Admin Guide](http://www.balabit.com/sites/default/files/documents/syslog-ng-ose-3.5-guides/en/syslog-ng-ose-v3.5-guide-admin/html-single/index.html)  which contains all the necessary information to use this
software. You can also get help on the [syslog-ng mailing list](syslog-ng@lists.balabit.hu).

Before you use this module, please read the part of the documentation, which covers the basics of  [syslog-ng.conf](http://www.balabit.com/sites/default/files/documents/syslog-ng-ose-3.5-guides/en/syslog-ng-ose-v3.5-guide-admin/html/syslog-ng.conf.5.html).

## Usage

There is a `concat::fragment` resource in every class or defined type which represents a statement. Because statements needs to be defined before referenced in the configuration, I use an automatic ordering system. Each type has its own order value, which determines its position in the configuration file. The less an order value is, the more likely it will be at the beginning of the file. These interval of these values starts with `0` and are `strings`. Here is a table, which contains the default order values:
<a name="order_table"></a>

| Name                   | Order |
|------------------------|-------|
| syslog_ng::config      | 5     |
| syslog_ng::destination | 70    |
| syslog_ng::filter      | 50    |
| syslog_ng::log         | 80    |
| syslog_ng::options     | 10    |
| syslog_ng::parser      | 40    |
| syslog_ng::rewrite     | 30    |
| syslog_ng::source      | 60    |
| syslog_ng::template    | 20    |


### Classes and defined types



####Class: `syslog_ng`
The main class of this module, by including it you get an installed `syslog-ng` with default configuration on your system.

**Parameters within `syslog_ng`:**

#####`config_file`
Configures the config file path. Defaults to `/etc/syslog-ng/syslog-ng.conf` on all systems.
#####`sbin_path`
Configures the path, where `syslog-ng` and `syslog-ng-ctl` binaries can be found. Defaults to `/usr/sbin`.
#####`purge_syslog_ng_conf`
TODO
#####`user`
Configures `syslog-ng` to run as `user`.
#####`group`
Configures `syslog-ng` to run as `group`.

####Defined type: `syslog_ng::config`

There is a part of the syslog-ng DSL, which is not supported by this module (mostly the boolean operators in filters) or you want to keep some configuration snippets in their original form. This type lets you write texts into the configuration without any parsing or processing.

Every configuration file begins with a `@version: <version>` line. You can use this type to write this line into the configuration, make comments or use existing snippets.

```puppet
syslog_ng::config {'version':
    content => '@version: 3.6',
    order => '0'
}
```

**Parameters within `syslog_ng::config`:**
#####`content`
Configures the text which must be written into the configuration file. A newline character is automatically appended to its end.

#####`order`
Sets the order of this snippet in the configuration file. See [Orders](#order_table). If you want to write the version line, the `order => '0'` is suggested.

####Defined type: `syslog_ng::destination`
Creates a destination in your configuration.
```puppet
syslog_ng::destination { 'd_udp':
    params => {
        'type' => 'udp',
        'options' => [
            "'127.0.0.1'",
            {'port' => '1999'},
            {'localport' => '999'}
        ]
    }
}
```
**Parameters within `syslog_ng::destination`:**
#####`params`
An array of hashes or a single hash. It uses the syntax which is described [here](#statement_syntax).

####Defined type: `syslog_ng::filter`
Creates a filter in your configuration. It **does not support binary operators**, such as `and` or `or`. Please, use a `syslog_ng::config` if you need these functionality.

```puppet
syslog_ng::filter {'f_tag_filter':
    params => {
        'type' => 'tags',
        'options' => [
            '".classifier.system"'
        ]
    }
}

```
**Parameters within `syslog_ng::filter`:**
#####`params`
An array of hashes or a single hash. It uses the syntax which is described [here](#statement_syntax).

####Defined type: `syslog_ng::log`
Creates log paths in your configuration. It can create `channels`, `junctions` and reference already defined `sources`, `destinations`, etc.  The syntax is a little bit different that you already met at statements...

```puppet
syslog_ng::log {'l':
    params => [
        {'source' => 's_external'},
        {'destination' => 'd_udp'}
    ]
}
```
**Parameters within `syslog_ng::log`:**
#####`params`
The syntax is a little bit different.


####Defined type: `syslog_ng::options`
Creates a global options statement.

```puppet
syslog_ng::options { "global_options":
    options => {
        'bad_hostname' => "'no'"
    }
}
```
**Parameters within `syslog_ng::options`:**
#####`options`
A hash containing string keys and string values. In the generated configuration the keys will appear in alphabetical order.


####Class: `syslog_ng::params`
Contains some basic constants which are used during the configuration generation. It is the base class of `syslog_ng`. You should not use this class directly, it is part of the inner working.

####Defined type: `syslog_ng::parser`
Creates a parser statement in your configuration.

```puppet
syslog_ng::parser {'p_hostname_segmentation':
    params => {
        'type' => 'csv-parser',
        'options' => [
            {'columns' => [
                "'HOSTNAME.NAME'",
                "'HOSTNAME.ID'"
            ]},
            {'delimiters' => "'-'"},
            {'flags' => 'escape-none'},
            {'template' => '"${HOST}"'}
        ]
    }
}
```
**Parameters within `syslog_ng::parser`:**
#####`params`
An array of hashes or a single hash. It uses the syntax which is described [here](#statement_syntax).


####Class: `syslog_ng::reload`
Contains a logic, which is able to reload `syslog-ng`. You should not use this class directly, it is part of the inner working.

####Defined type: `syslog_ng::rewrite`
Creates one or more rewrite rules in your configuration.

```puppet
syslog_ng::rewrite{'r_rewrite_subst':
    params => {
        'type' => 'subst',
        'options' => [
            '"IP"',
            '"IP-Address"',
            {'value' => '"MESSAGE"'},
            {'flags' => '"global"'}
        ]
    }
}
```
**Parameters within `syslog_ng::rewrite`:**
#####`params`
An array of hashes or a single hash. It uses the syntax which is described [here](#statement_syntax).


####Defined type: `syslog_ng::source`
Creates a source in your configuration.

```puppet
syslog_ng::source { 's_gsoc':
    params => {
        'type' => 'tcp',
        'options' => [
            {'ip' => "'127.0.0.1'"},
            {'port' => 1999}
        }]
    }
}

syslog_ng::source {'s_external':
    params => [
        { 'type' => 'udp',
          'options' => [
            {'ip' => ["'127.0.0.1'"]},
            {'port' => [514]}
            ]
        },
        { 'type' => 'tcp',
          'options' => [
            {'ip' => ["'127.0.0.1'"]},
            {'port' => [514]}
            ]
        },
        {
          'type' => 'syslog',
          'options' => [
            {'flags' => ['no-multi-line', 'no-parse']},
            {'ip' => ["'127.0.0.1'"]},
            {'keep-alive' => ['yes']},
            {'keep_hostname' => ['yes']},
            {'transport' => ['udp']}
            ]
        }
    ]
}
```
**Parameters within `syslog_ng::source`:**
#####`params`
An array of hashes or a single hash. It uses the syntax which is described [here](#statement_syntax).




####Defined type: `syslog_ng::template`
Creates one or more templates in your configuration.

```puppet
syslog_ng::template {'t_demo_filetemplate':
    params => [
        {
            'type' => 'template',
            'options' => [
                '"$ISODATE $HOST $MSG\n"'
            ]
        },
        {
            'type' => 'template_escape',
            'options' => [
                'no'
            ]
        }
    ]
}
```
**Parameters within `syslog_ng::template`:**
#####`params`
An array of hashes or a single hash. It uses the syntax which is described [here](#statement_syntax).


## Inner working
The module heavily uses the `concat` and `concat::fragment` types. An order is assigned to each statement (`source`, `destination`, `rewrite`, etc.) which determines their order in the generated configuration file.

The config generation is done by the `generate_statement()` function in most cases. It is just a wrapper around my `statement.rb` Ruby module, which does the hard work. You may think, that the `require` part is quite ugly in this part, but it works well.


## Limitations

The module was only tested on Ubuntu Linux (14.04 LTS), but it should work on Debian as well. I you use it on an other platform, please let me know about it!

## Development

I am open to accept any pull request, either it comes to bug fixes or feature developments. I do not want to state the significance of tests, so please, write some spec test and update the documentation as well according to your modification.

**Note for commiters:**

The `master` branch is a sacred place, do not commit to it directly. We should touch it only by pull requests or rebasing our modifications on the top of its head.

## Release Notes/Contributors/Etc **Optional**
###  Contributors
Tibor Benke - main author

###  Changelog
