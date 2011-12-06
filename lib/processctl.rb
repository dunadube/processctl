require "processctl/version"

module Processctl
  #
  # Some utilites 
  #
  module Utils

    # kill a running process using its 
    # pidfile
    #
    def kill_if_running(pidfile, opts = {})
      return if !File.exists?(pidfile)

      pid = read_pid(pidfile)
      File.delete(pidfile)

      return if !alive?(pid)

      Process.kill(15, pid)

      (1..5).each do
        return if !alive?(pid)
        sleep 1
      end
      Process.kill(9, pid)
    end

    # run a process
    def run(cmd)
      io = IO.popen(cmd, "r")
      io.pid
    end

    # write the pid to a file
    def write_pid(pidfile, pid)
      File.open(pidfile, 'w') {|f| f.write(pid) }
    end

    def read_pid(pidfile)
      raise ArgumentError.new("Pidfile #{pidfile} does not exist") if !File.exists?(pidfile)

      read_file(pidfile).strip.to_i
    end

    def alive?(pid)
      begin
        Process.kill(0, pid)
        true
      rescue Errno::ESRCH
        false
      end
    end
    
    # ==========
    private
    # ==========

    def read_file(fn)
      begin
        file = File.open(fn, "r")
        res = file.read
      rescue
        file.close if file
        res
      end
    end

  end

  # 
  # Starts/Stops any process using a pid file
  #
  class Wrapper
     extend Processctl::Utils

    DefaultPidFileName = "process.pid"

    def self.running?(opts = {})
      opts = default_opts(opts)
      return false if !File.exists?(opts[:pid_file])

      pid = read_pid(opts[:pid_file])

      alive?(pid)
    end

    def self.start(cmd, opts={})
      opts = default_opts(opts)

      kill_if_running(opts[:pid_file])

      pid = run(cmd)

      write_pid(opts[:pid_file], pid)

      pid
    end

    def self.stop(opts = {})
      opts = default_opts(opts)

      kill_if_running(opts[:pid_file])
    end
    
    # ==========
    private
    # ==========

    def self.default_opts(opts)
      opts = {:home_dir => File.expand_path(".")}.merge!(opts)
      opts[:pid_file] = opts[:home_dir] + "/" + DefaultPidFileName 
      opts
    end

  end

end
