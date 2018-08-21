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


	# MARK: - Defaults

	@@facility : Facility = Facility::User
	class_property facility : Facility

	def self.mask=(mask : Int) : Nil
		LibC.setlogmask(mask)
	end


	# MARK: - Generics

	# Initializes the log file for special processing.
	# The use of this method is optional.
	#
	# NOTE: This API may be replaced in a future version.
	def self.open(prefix : String, facility : Facility = @@facility, *options : Option) : Nil
		@@facility = facility
		options = options.reduce(0) { |acc, elm| (acc|elm.value) }
		LibC.openlog(prefix, options, facility)

#		syslog_data = syslog_data_init()
#		LibC.openlog_r(prefix, options, facility, pointerof(syslog_data))
	end

	# :ditto:
	def self.open(prefix : String, facility : Facility = @@default_facility) : Nil
		LibC.openlog(prefix, 0, facility)

#		syslog_data = syslog_data_init()
#		LibC.openlog_r(prefix, 0, facility, pointerof(syslog_data))
	end

	# Writes a message with a priority and facility.
	def self.log(priority : Priority, facility : Facility, message : String) : Nil
		LibC.syslog(priority.value|facility.value, message)

#		syslog_data = syslog_data_init()
#		LibC.syslog_r(priority.value|facility.value, pointerof(syslog_data), message)
	end

	# Closes the descriptor being used to write to the system logger, clearing special options.
	# The use of this method is optional.
	#
	# NOTE: This API may be replaced in a future version.
	def self.close() : Nil
		@@facility = Facility::User
		LibC.closelog()

#		syslog_data = syslog_data_init()
#		LibC.closelog_r(pointerof(syslog_data))
	end


	# MARK: - Log By Level

	# Writes an emergency *syslog* message with an optional facility.
	def self.emergency(message : String, facility : Facility = @@facility) : Nil
		log(Priority::Emergency, facility, message)
	end

	# Writes an alert *syslog* message with an optional facility.
	def self.alert(message : String, facility : Facility = @@facility) : Nil
		log(Priority::Alert, facility, message)
	end

	# Writes an critical *syslog* message with an optional facility.
	def self.critical(message : String, facility : Facility = @@facility) : Nil
		log(Priority::Critical, facility, message)
	end

	# Writes an error *syslog* message with an optional facility.
	def self.error(message : String, facility : Facility = @@facility) : Nil
		log(Priority::Error, facility, message)
	end

	# Writes an warning *syslog* message with an optional facility.
	def self.warning(message : String, facility : Facility = @@facility) : Nil
		log(Priority::Warning, facility, message)
	end

	# Writes an notice *syslog* message with an optional facility.
	def self.notice(message : String, facility : Facility = @@facility) : Nil
		log(Priority::Notice, facility, message)
	end

	# Writes an info *syslog* message with an optional facility.
	def self.info(message : String, facility : Facility = @@facility) : Nil
		log(Priority::Info, facility, message)
	end

	# Writes an debug *syslog* message with an optional facility.
	def self.debug(message : String, facility : Facility = @@facility) : Nil
		log(Priority::Debug, facility, message)
	end


	# MARK: - Enums

	enum Facility
		Authorization	= LibC::LOG_AUTH
		Privilage		= LibC::LOG_AUTHPRIV
		Cron			= LibC::LOG_CRON
		Daemon			= LibC::LOG_DAEMON
		FTP				= LibC::LOG_FTP
		Kernal			= LibC::LOG_KERN
		LPR				= LibC::LOG_LPR
		Mail			= LibC::LOG_MAIL
		News			= LibC::LOG_NEWS
		Syslog			= LibC::LOG_SYSLOG
		User			= LibC::LOG_USER
		UUCP			= LibC::LOG_UUCP
		Local0			= LibC::LOG_LOCAL0
		Local1			= LibC::LOG_LOCAL1
		Local2			= LibC::LOG_LOCAL2
		Local3			= LibC::LOG_LOCAL3
		Local4			= LibC::LOG_LOCAL4
		Local5			= LibC::LOG_LOCAL5
		Local6			= LibC::LOG_LOCAL6
		Local7			= LibC::LOG_LOCAL7
	end

	enum Priority
		Emergency	= LibC::LOG_EMERG
		Alert		= LibC::LOG_ALERT
		Critical	= LibC::LOG_CRIT
		Error		= LibC::LOG_ERR
		Warning		= LibC::LOG_WARNING
		Notice		= LibC::LOG_NOTICE
		Info		= LibC::LOG_INFO
		Debug		= LibC::LOG_DEBUG
	end

	enum Options
		Console		= LibC::LOG_CONS
		NoDelay		= LibC::LOG_NDELAY
		Delay		= LibC::LOG_ODELAY
		PrintError	= LibC::LOG_PERROR
		PID			= LibC::LOG_PID
	end


	# MARK: - Utilities

#	macro syslog_data_init()
#		LibC::SyslogData.new(log_stat: 0, log_tag: "", log_fac: LibC::LOG_USER, log_mask: 0xff)
#	end

end
