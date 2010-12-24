#
#------------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <mayeu.tik@gmail.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return. Matthieu Maury
#------------------------------------------------------------------------------
#

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

  # Return the todo associated to the given number
  def get_todo (nb)
    # TODO: parse todo to remove the priority
    IO.readlines(TODO_FILE)[nb-1]
  end

  # Going in a task with a todo from todo.txt
  def task_in_todo (nb)
     t = get_todo (nb)
    if t
      task_in t.chomp
    else
      puts "No task specified"
    end
  end
end
