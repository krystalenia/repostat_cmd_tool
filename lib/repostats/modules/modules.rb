module UnescapeEncoder

  def self.encode(params)
    if params
      params.each do |key, value|
        return "#{key.to_s}=#{value}"
      end
    else
      return ''
    end
  end

end

# Handles the file transaction
# in order to write the results
#
module FileHandle


  # Writes the results in json format in a file
  #
  # @param [String] org
  # @param [Hash] json
  # @param [String] calc_type
  # @param [Object] fname
  #
  def self.write_file(org, json, calc_type, fname = nil)

    fname = "#{org}_#{calc_type}_#{Time.now.to_i}.txt" if fname.nil? || fname.empty? || File.exist?(fname)

    File.open(fname, "w") do |file|
      file.write(json.to_json)
    end
  end

end


module RepoLogger

  @loggerfile = File.open('logs_repostats.log', 'a')
  @logger = Logger.new(@loggerfile)

  def self.writelog(type, msg)
    case type
      when 'fatal'
        @logger.fatal msg
      when 'error'
        @logger.error msg
      else
        @logger.info msg
    end

  end

  def self.get_logger
    @logger
  end

end