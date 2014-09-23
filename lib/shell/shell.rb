class Shell
  require 'open3'

  class << self

    # Mostly copied from Discourse's Docker Manager
    def run(dir, cmd)
      log "$ #{cmd}"
      msg = ""
      clear_env = {}
      clear_env["TERM"] = 'dumb' # claim we have a terminal

      retval = nil
      Open3.popen2e(clear_env, "cd #{dir} && #{cmd} 2>&1") do |_in, out, wait_thread|
        out.each do |line|
          line.rstrip! # the client adds newlines, so remove the one we're given
          log(line)
          msg << line << "\n"
        end
        retval = wait_thread.value
      end

      unless retval == 0
        STDERR.puts("FAILED: '#{cmd}' exited with a return value of #{retval}")
        STDERR.puts(msg)
        raise RuntimeError
      end
    end

    def log(msg)
      puts msg
    end
    
  end
end