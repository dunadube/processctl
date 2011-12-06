processctl
==========

# SYNOPSIS

Simple process control in ruby. I was in need of a simple ruby wrapper which would start a process in the background and write a pid file for it so i can also stop it any time.
Unfortunately I could not find anything which would also work with JRuby.

# EXAMPLES

Simple usage

```ruby
require 'processctl'

Processctl.start("some_command")
=> <pid>
Processctl.stop

```

If don't want to run in the current directory you can do the following

```ruby
require 'processctl'

opts = {:home_dir => "/some/path"}
Processctl.start("some_command", opts)
=> <pid>
Processctl.stop(opts)

```
