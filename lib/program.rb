# require "./lib/timer.rb"
require "json"

#
# Time Utility
#
module Timer
  @@timeStart = nil
  @@timeEnd = nil

  #
  # Starts the timer
  #
  def self.start
    @@timeStart = Process.clock_gettime( Process::CLOCK_MONOTONIC )
  end

  #
  # Stops the timer
  #
  def self.stop
    @@timeEnd = Process.clock_gettime( Process::CLOCK_MONOTONIC )
  end

  #
  # Gets elapsed time
  #
  def self.elapsed
    unless @@timeEnd.nil? || @@timeStart.nil?

      elapsed = @@timeEnd.to_i - @@timeStart.to_i # distance between t1 and t2 in seconds

      resolution = if elapsed > 29030400 # seconds in a year
        [(elapsed/29030400), 'years']
      elsif elapsed > 2419200
        [(elapsed/2419200), 'months']
      elsif elapsed > 604800
        [(elapsed/604800), 'weeks']
      elsif elapsed > 86400
        [(elapsed/86400), 'days']
      elsif elapsed > 3600 # seconds in an hour
        [(elapsed/3600), 'hours']
      elsif elapsed > 60
        [(elapsed/60), 'minutes']
      else
        [elapsed, 'seconds']
      end

      if resolution[0] == 1
        return resolution.join(' ')[0...-1]
      else
        return resolution.join(' ')
      end

    else
      return nil
    end
  end

end

#
# Program Utility
#
module Program

  #
  # Utility method for printing messages.
  #
  def self.line( )
    puts ( "-" * 62 )
  end

  #
  # Utility method for printing messages.
  #
  def self.output( message )
    Program.line
    puts " #{message}"
    Program.line
  end

  #
  # Utility to start the program
  #
  def self.start( name, author, version, date )
    Timer.start

    Program.line
    puts " #{name} "
    Program.line
    puts " Version: #{version}"
    puts " Date: #{date}"
    puts " Author: #{author}"
    Program.line

    $tenant = nil

    unless $tenant.nil?
      puts " Tenant: #{$tenant}"
      Program.line
    end

  end

  #
  # Utility to end the program
  #
  def self.end( )
    Timer.stop
    output( "Process completed in #{Timer.elapsed}" )
  end


  #
  # Utility method to write output files to a directory.
  #
  def self.write_file( directory, name, text )
    name.gsub!(/[^0-9A-Za-z. -]/,"-")
    FileUtils.mkdir_p directory
    File.open( File.join( directory, name ), 'w+') { |file| file.write( text ) }
  end

  def self.get_filenames( directory )
    output = Array.new
    Dir.glob("#{directory}/*.json") do |file|
      #tmp = file.slice! "#{directory}/"
      output.push(file)
    end
    return output
  end

  def self.read_directory( directory )
    output = Array.new
    Dir.glob("#{directory}/*.json") do |file|
      output.push(Program.read_file(file))
    end
    return output
  end

  #
  # Utility method to read output files to a directory.
  #
  def self.read_file( directory, name )
    return Program.read_file("#{directory}/#{name}")
  end

  def self.read_file( name )
    output = ""
    #name.gsub!(/[^0-9A-Za-z. -]/,"-")
    f = File.open( name, 'r')
    f.each_line do |line|
      output += line
    end
    f.close
    return output
  end

  def self.write_csv(directory, name, content)
    if !File.file?("#{directory}/#{name}")
      Program.write_file(directory, name, "")
    end
    CSV.open("#{directory}/#{name}", "ab") do |csv|
      csv << content
    end
  end
end
