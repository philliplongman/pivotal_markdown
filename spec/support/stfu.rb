module STFU
  # Surpresses stdout in console during tests, but allows it to still be tested
  # Copied from https://jacob.hoffman-andrews.com/README/ruby-function-stfu-temporarily-redirect-noisy-stdout-writes-to-devnull/

  def stfu
    begin
      orig_stderr = $stderr.clone
      orig_stdout = $stdout.clone
      $stderr.reopen File.new('/dev/null', 'w')
      $stdout.reopen File.new('/dev/null', 'w')
      retval = yield
    rescue Exception => e
      $stdout.reopen orig_stdout
      $stderr.reopen orig_stderr
      raise e
    ensure
      $stdout.reopen orig_stdout
      $stderr.reopen orig_stderr
    end
    retval
  end

end
