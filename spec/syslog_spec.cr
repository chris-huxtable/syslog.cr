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

require "./spec_helper"

describe "Syslog" do
  it "logs" do
    typeof(Syslog.emergency("test message"))
    typeof(Syslog.alert("test message"))
    typeof(Syslog.critical("test message"))
    typeof(Syslog.error("test message"))
    typeof(Syslog.warning("test message"))
    typeof(Syslog.notice("test message"))
    typeof(Syslog.info("test message"))
    typeof(Syslog.debug("test message"))
  end

  it "logs to a non-default facility" do
    typeof(Syslog.emergency("test message", Syslog::Facility::Daemon))
    typeof(Syslog.alert("test message", Syslog::Facility::Daemon))
    typeof(Syslog.critical("test message", Syslog::Facility::Daemon))
    typeof(Syslog.error("test message", Syslog::Facility::Daemon))
    typeof(Syslog.warning("test message", Syslog::Facility::Daemon))
    typeof(Syslog.notice("test message", Syslog::Facility::Daemon))
    typeof(Syslog.info("test message", Syslog::Facility::Daemon))
    typeof(Syslog.debug("test message", Syslog::Facility::Daemon))
  end

  it "handles prefix" do
    Syslog.prefix = "syslog.cr-test"
    Syslog.prefix.should eq("syslog.cr-test")
  end

  it "handles facility" do
    Syslog.facility = Syslog::Facility::Daemon
    Syslog.facility.should eq(Syslog::Facility::Daemon)
  end

  it "handles options" do
    Syslog.options = Syslog::Options::NoDelay | Syslog::Options::Console
    Syslog.options.should eq(Syslog::Options::NoDelay | Syslog::Options::Console)
  end

  it "handles mask" do
    Syslog.mask = 0x7f
    Syslog.mask.should eq(0x7f)
  end

  it "handles setup" do
    Syslog.setup("syslog.cr-test2", Syslog::Facility::News, Syslog::Options::Console, 0xAF)

    Syslog.prefix.should eq("syslog.cr-test2")
    Syslog.facility.should eq(Syslog::Facility::News)
    Syslog.options.should eq(Syslog::Options::Console)
    Syslog.mask.should eq(0xAF)
  end

  it "handles reset" do
    Syslog.reset_defaults

    Syslog.prefix.should eq(PROGRAM_NAME)
    Syslog.facility.should eq(Syslog::Facility::User)
    Syslog.options.should eq(Syslog::Options::None)
    Syslog.mask.should eq(0xFF)
  end

  it "handles closes" do
    Syslog.close
  end
end
