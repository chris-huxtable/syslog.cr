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

lib LibC
  LOG_EMERG   = 0 # system is unusable
  LOG_ALERT   = 1 # action must be taken immediately
  LOG_CRIT    = 2 # critical conditions
  LOG_ERR     = 3 # error conditions
  LOG_WARNING = 4 # warning conditions
  LOG_NOTICE  = 5 # normal but significant condition
  LOG_INFO    = 6 # informational
  LOG_DEBUG   = 7 # debug-level messages

  LOG_KERN     = (0 << 3)  # kernel messages
  LOG_USER     = (1 << 3)  # random user-level messages
  LOG_MAIL     = (2 << 3)  # mail system
  LOG_DAEMON   = (3 << 3)  # system daemons
  LOG_AUTH     = (4 << 3)  # security/authorization messages
  LOG_SYSLOG   = (5 << 3)  # messages generated internally by syslogd
  LOG_LPR      = (6 << 3)  # line printer subsystem
  LOG_NEWS     = (7 << 3)  # network news subsystem
  LOG_UUCP     = (8 << 3)  # UUCP subsystem
  LOG_CRON     = (9 << 3)  # clock daemon
  LOG_AUTHPRIV = (10 << 3) # security/authorization messages (private)
  LOG_FTP      = (11 << 3) # ftp daemon

  LOG_LOCAL0 = (16 << 3) # reserved for local use
  LOG_LOCAL1 = (17 << 3) # reserved for local use
  LOG_LOCAL2 = (18 << 3) # reserved for local use
  LOG_LOCAL3 = (19 << 3) # reserved for local use
  LOG_LOCAL4 = (20 << 3) # reserved for local use
  LOG_LOCAL5 = (21 << 3) # reserved for local use
  LOG_LOCAL6 = (22 << 3) # reserved for local use
  LOG_LOCAL7 = (23 << 3) # reserved for local use

  LOG_PID    = 0x01 # log the pid with each message
  LOG_CONS   = 0x02 # log on the console if errors in sending
  LOG_ODELAY = 0x04 # delay open until first syslog() (default)
  LOG_NDELAY = 0x08 # don't delay open
  LOG_NOWAIT = 0x10 # don't wait for console forks: DEPRECATED
  LOG_PERROR = 0x20 # log to stderr as well

  fun syslog(priority : Int, message : Char*, ...) : Void
  fun openlog(ident : Char*, logopt : Int, facility : Int) : Void
  fun closelog : Void
  fun setlogmask(maskpri : Int) : Int

  # {% if flag?(:openbsd) || flag?(:freebsd) %}
  #  struct SyslogData
  #    log_stat : Int
  #    log_tag : Char*
  #    log_fac : Int
  #    log_mask : Int
  #  end
  #
  #  fun syslog_r(priority : Int, data : SyslogData*, message : Char*, ...) : Void
  #  fun openlog_r(ident : Char*, logopt : Int, facility : Int, data : SyslogData*) : Void
  #  fun closelog_r(data : SyslogData*) : Void
  #  fun setlogmask_r(maskpri : Int, data : SyslogData*) : Int
  # {% end %}
end
