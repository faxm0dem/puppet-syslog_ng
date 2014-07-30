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
### Configuration syntax
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

As I mentioned, there are strings and hashed in an option. In case of hashed, they
must contain only one key. This key will identify the name of the parameter and its
value must be an array of strings. If that would contain only one item, the value can
be simply just a string.


## Setup

### What syslog_ng affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with syslog_ng

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
