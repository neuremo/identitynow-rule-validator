require 'json'
require 'colorize'
require 'program'

class IdentityNowRuleValidator

  #
  # This will collect findings for each file.
  #
  @@findings = []

  #
  # This holds details about the files.
  #
  @@filesCount = 0;

  #
  # These are the rules which are used for validation.
  #
  @@rules = []

  #
  # This will help determine if we're still showing findings for the same file.
  #
  @@previousFile = nil

  def self.validate_directory( directory )

    self.initialize

    puts "Validating files from directory: #{directory}"

    Dir.glob( File.join( directory + '**/*.xml' ) ).each do |file|

      self.analyze_file( file )

    end # files.each do |file|

    self.report_findings

    return @@findings

  end

  def self.validate_files( files )

    self.initialize

    puts "Validating files: #{files}"

    if ( !files.nil? && !files.empty? )

      files.each do |file|

        self.analyze_file( file )

      end # files.each do |file|

    end # if ( !files.nil? && !files.empty? )

    self.report_findings

    return @@findings

  end

  def self.validate_file( file )

    self.initialize

    puts "Validating file: #{file}"

    self.analyze_file( file )

    self.report_findings

    return @@findings

  end

  private

  def self.initialize

    #
    # Initialize findings to be empty.
    #
    @@findings = []

    #
    # Initialize filesCount to be 0.
    #
    @@filesCount = 0;

    #
    # Initialize rules from JSON.
    #
    @@rules = JSON.parse( File.read( File.join( __dir__, "rules.json" ) ) )

    #
    # Initialize previous file to empty
    #
    @@previousFile = nil

    #
    # Program Start / Version
    #
    Program.start( "IdentityNow Rule Validator", "Neil McGlennon (neil.mcglennon@sailpoint.com)", "1.0.1", "2020-05-12" )

  end

  def self.analyze_file( file )

    #
    # Make sure we are working with files, not directories.
    #
    if File.file?( file )

      @@filesCount += 1;
      puts "\t" + File.basename( file )

      File.readlines( file ).each_with_index do |line, lineNumber|

        @@rules.each do |rule|

          if line.valid_encoding?
            if( line.match( /#{rule['pattern']}/ ) )

              finding = {
                'file': file,
                'line': lineNumber + 1,
                'text': line.strip,
                'message': rule['message'],
                'type': rule['type']
              }
              @@findings.push finding
            end

          end # if( line.match( /#{rule['pattern']}/ ) )

        end # @@rules.each do |rule|

      end # File.readlines( file ).each_with_index do |line, lineNumber|

    end # if File.file?( file )

  end

  def self.report_findings

    #
    # If there are no findings, then we're good.  Display a success message.
    #
    if @@findings.nil? || @@findings.empty?

      puts "\n\t#{"Success".green}: No issues found!\n\n"

    #
    # We have some findings to show.
    #
    else

      #
      # Iterate through all of our findings.
      #
      @@findings.each do |finding|

        #
        # Output the file header
        #
        if ( finding[:file] != @@previousFile )
          puts File.dirname( finding[:file] ) + "\n"
          puts File.basename( finding[:file] ).bold + "\n\n"
        end

        #
        # Output the issue
        #
        puts "\tLine #{finding[:line]}: #{finding[:text][0..80].gsub(/\s\w+$/,'...').light_black}"
        type = ( finding[:type] == "error" ) ? "Error".red : "Warning".yellow
        puts "\t#{type}: #{finding[:message]}\n\n"

        #
        # Set this for the next iteration
        #
        @@previousFile = finding[:file]

      end

    end

    #
    # Completion!
    #
    Program.end

  end

end
