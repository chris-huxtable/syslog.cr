# syslog.cr
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://chris-huxtable.github.io/syslog.cr/)
[![GitHub release](https://img.shields.io/github/release/chris-huxtable/syslog.cr.svg)](https://github.com/chris-huxtable/syslog.cr/releases)
[![Build Status](https://travis-ci.org/chris-huxtable/syslog.cr.svg?branch=master)](https://travis-ci.org/chris-huxtable/syslog.cr)


Adds syslog functionality to crystal.


## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  syslog:
    github: chris-huxtable/syslog.cr
```


## Usage

Requiring:

```crystal
require "syslog"
```

Basic Usage:

```crystal
Syslog.emergency("This is a notice message")
Syslog.alert("This is a notice message")
Syslog.critical("This is a notice message")
Syslog.error("This is a notice message")
Syslog.warning("This is a notice message")
Syslog.notice("This is a notice message")
Syslog.info("This is a info message")
Syslog.debug("This is a debug message")
```

Facility Usage:

```crystal
Syslog.info("This is a info message sent to the LOCAL0 Facility", Syslog::Facility::Local0)
```


## Contributing

1. Fork it (<https://github.com/chris-huxtable/syslog.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Contributors

- [Chris Huxtable](https://github.com/chris-huxtable) - creator, maintainer
