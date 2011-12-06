require File.join(File.dirname(__FILE__), %w[spec_helper])
require File.dirname(__FILE__) + "/../lib/processctl"

describe Processctl::Wrapper do
    it "can write and read a pid file" do
      Processctl::Wrapper.write_pid("/tmp/test.pid", 123)
      pid = Processctl::Wrapper.read_pid("/tmp/test.pid")
      pid.should eql(123)
    end

    it "starts and stops any process" do
      opts = {:home_dir => File.expand_path(File.dirname(__FILE__)) + "/dummy_process"}
      cmd = "tail -f #{opts[:home_dir] + '/some_file.txt'}"

      pid = Processctl::Wrapper.start(cmd, opts)

      Processctl::Wrapper.running?(opts).should eql(true)

      Processctl::Wrapper.stop(opts)

      Processctl::Wrapper.running?(opts).should eql(false)
    end

end
