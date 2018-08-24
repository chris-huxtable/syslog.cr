# Copyright (c) 2018 Christian Huxtable <chris@huxtable.ca>.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

require "./syslog/*"

module Syslog
  @@prefix : String = PROGRAM_NAME
  @@facility : Facility = Facility::User
  @@options : Options = Options::None
  @@mask : UInt16 = 0xff_u16

  # Sets the string to be prefixed to log messages.
  def self.prefix=(prefix : String) : Nil
    @@prefix = prefix
    LibC.openlog(prefix, @@options.value, @@facility.value)
  end

  # Returns the string to be prefixed to log messages.
  def self.prefix : String
    @@prefix
  end

  # Sets the loggers default facility.
  def self.facility=(facility : Facility) : Nil
    @@facility = facility
    LibC.openlog(@@prefix, @@options.value, @@facility.value)
  end

  # Returns the loggers default facility.
  def self.facility : Facility
    return @@facility
  end

  # Sets the loggers options.
  def self.options=(options : Options) : Nil
    @@options = options
    LibC.openlog(@@prefix, @@options.value, @@facility.value)
  end

  # Returns the loggers options.
  def self.options : Options
    return @@options
  end

  # Sets the loggers mask.
  def self.mask=(mask : Int) : Nil
    raise "Invalid mask given #{mask.inspect}" if 0 > mask > 255
    @@mask = mask.to_u16
    LibC.setlogmask(mask)
  end

  # Returns the loggers mask.
  def self.mask : UInt16
    return @@mask
  end

  # Sets all the loggers options at once.
  # This is more efficient when changing many settings.
  def self.setup(prefix : String, facility : Facility, options : Options, mask : Int) : Nil
    @@prefix = prefix
    @@facility = facility
    @@options = options
    LibC.openlog(@@prefix, @@options.value, @@facility.value)

    self.mask = mask
  end

  # Resets all the loggers options to their defaults.
  def self.reset_defaults : Nil
    setup(PROGRAM_NAME, Facility::User, Options::None, 0xff)
  end

  # Closes the current logger.
  # Useful for shard libraries where the prefix may be unloaded.
  def self.close : Nil
    LibC.closelog
  end

  # Writes a message with a priority and facility.
  def self.log(priority : Priority, message : String, facility : Facility? = nil) : Nil
    if facility
      LibC.syslog(priority.value | facility.value, message)
    else
      LibC.syslog(priority.value, message)
    end
  end

  # Writes an emergency *syslog* message with an optional facility.
  def self.emergency(message : String, facility : Facility? = nil) : Nil
    log(Priority::Emergency, message, facility)
  end

  # Writes an alert *syslog* message with an optional facility.
  def self.alert(message : String, facility : Facility? = nil) : Nil
    log(Priority::Alert, message, facility)
  end

  # Writes an critical *syslog* message with an optional facility.
  def self.critical(message : String, facility : Facility? = nil) : Nil
    log(Priority::Critical, message, facility)
  end

  # Writes an error *syslog* message with an optional facility.
  def self.error(message : String, facility : Facility? = nil) : Nil
    log(Priority::Error, message, facility)
  end

  # Writes an warning *syslog* message with an optional facility.
  def self.warning(message : String, facility : Facility? = nil) : Nil
    log(Priority::Warning, message, facility)
  end

  # Writes an notice *syslog* message with an optional facility.
  def self.notice(message : String, facility : Facility? = nil) : Nil
    log(Priority::Notice, message, facility)
  end

  # Writes an info *syslog* message with an optional facility.
  def self.info(message : String, facility : Facility? = nil) : Nil
    log(Priority::Info, message, facility)
  end

  # Writes an debug *syslog* message with an optional facility.
  def self.debug(message : String, facility : Facility? = nil) : Nil
    log(Priority::Debug, message, facility)
  end

  enum Facility
    Authorization = LibC::LOG_AUTH
    Privilage     = LibC::LOG_AUTHPRIV
    Cron          = LibC::LOG_CRON
    Daemon        = LibC::LOG_DAEMON
    FTP           = LibC::LOG_FTP
    Kernal        = LibC::LOG_KERN
    LPR           = LibC::LOG_LPR
    Mail          = LibC::LOG_MAIL
    News          = LibC::LOG_NEWS
    Syslog        = LibC::LOG_SYSLOG
    User          = LibC::LOG_USER
    UUCP          = LibC::LOG_UUCP
    Local0        = LibC::LOG_LOCAL0
    Local1        = LibC::LOG_LOCAL1
    Local2        = LibC::LOG_LOCAL2
    Local3        = LibC::LOG_LOCAL3
    Local4        = LibC::LOG_LOCAL4
    Local5        = LibC::LOG_LOCAL5
    Local6        = LibC::LOG_LOCAL6
    Local7        = LibC::LOG_LOCAL7
  end

  enum Priority
    Emergency = LibC::LOG_EMERG
    Alert     = LibC::LOG_ALERT
    Critical  = LibC::LOG_CRIT
    Error     = LibC::LOG_ERR
    Warning   = LibC::LOG_WARNING
    Notice    = LibC::LOG_NOTICE
    Info      = LibC::LOG_INFO
    Debug     = LibC::LOG_DEBUG
  end

  @[Flags]
  enum Options
    Console    = LibC::LOG_CONS
    NoDelay    = LibC::LOG_NDELAY
    Delay      = LibC::LOG_ODELAY
    PrintError = LibC::LOG_PERROR
    PID        = LibC::LOG_PID
  end

  # {% if flag?(:openbsd) || flag?(:freebsd) %}
  #   macro syslog_data_init
  #     LibC::SyslogData.new(log_stat: 0, log_tag: "", log_fac: LibC::LOG_USER, log_mask: 0xff)
  #   end
  # {% end %}
end
