module Swatch

  module_function

  # Test if there is a task currently running. Return true if there is
  def running_task?
    line = ''
    IO.popen("tail -n 1 #{TRACK_FILE}") { |f| line = f.gets }
    puts line
    if(line != nil && (!line.match '^.+\t\d+\t\d+$'))
      true
    else
      false
    end
  end

  # Go out of the current task running
  def task_out
    if running_task?
      puts "There is a task running"
      f = File.open(TRACK_FILE, "a")
      f.print "\t#{Time.now.to_i}\n"
      f.close
    else
      puts "There is no task running"
    end
  end

  # Start a task
  def task_in (task)
    # TODO don't go here if ARGV is null !
    # if there is a task running, we get out of it
    if running_task?
      puts "There is a task running, getting out of this one"
      task_out
    end

    if(!File.exist?(TRACK_FILE))
      puts "Create a new task file"
      stdout = File.new(TRACK_FILE, "w")
    else
      puts "Use #{TRACK_FILE}"
      stdout = File.open(TRACK_FILE, "a")
    end
    stdout.print "#{task}\t#{Time.now.to_i}"
    stdout.close
  end
end
