#
# Extend the numeric class with the "duration" method that print a
# duration in human langage.
# This code was found at:
# http://stackoverflow.com/questions/1679266/can-ruby-print-out-time-difference-duration-readily
#

class Numeric
   def duration
      secs  = self.to_int
      mins  = secs / 60
      hours = mins / 60
      days  = hours / 24

      if days > 0
         "#{days} days and #{hours % 24} hours"
      elsif hours > 0
         "#{hours} hours and #{mins % 60} minutes"
      elsif mins > 0
         "#{mins} minutes and #{secs % 60} seconds"
      elsif secs >= 0
         "#{secs} seconds"
      end
   end
end

