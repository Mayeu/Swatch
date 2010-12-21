module Swatch

  module_function

  # Test if there is a task currently running. Return true if there is
  def running_task?
    line = ''
    IO.popen("tail -n 1 #{TRACK_FILE}") { |f| line = f.gets }
    #puts line
    if(line != nil && (!line.match '^.+\t\d+\t\d+$'))
      true
    else
      false
    end
  end

  # Return the name of the last task
  def get_last_task_name
    line = ''
    IO.popen("tail -n 1 #{TRACK_FILE}") { |f| line = f.gets }
    m = line.match '^(.+)\t\d+(\t\d+)?'
    m[1]
  end

  # Go out of the current task running
  def task_out
    if running_task?
      puts "Stop task: " + get_last_task_name
      f = File.open(TRACK_FILE, "a")
      f.print "\t#{Time.now.to_i}\n"
      f.close
    else
      puts "There is no task running"
    end
  end

  # Start a task
  def task_in (task)
    # don't go here if ARGV is null !
    if task.strip.empty?
      puts "No task specified"
      exit
    end

    # if there is a task running, we get out of it
    if running_task?
      #puts "There is a task running, getting out of this one"
      task_out
    end

    if(!File.exist?(TRACK_FILE))
      #puts "Create a new task file"
      out = File.new(TRACK_FILE, "w")
    else
      #puts "Use #{TRACK_FILE}"
      out = File.open(TRACK_FILE, "a")
    end

    #print the task in the file
    out.print "#{task}\t#{Time.now.to_i}"
    out.close

    puts "Start task: #{task}"
  end
end
