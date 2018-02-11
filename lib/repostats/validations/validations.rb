# Validations module includes methods
# for validating conditions

module Validations

  def lastPage?(links)
    if links.length > 0
      links.each do |link|
        return false if link.include? "next"
      end
      return true
    else
      return true
    end
  end

  def self.checkHttpStatus(response)
    if (400...600).include?(response.status)
      case response.status
      when 401
        raise "Invalid token"
      when 403
        raise "You have reached the request limit" if response.headers['x-ratelimit-remaining'].to_i <= 0
        raise "Unexpected Error"
      else
        raise "Unexpected Error"
      end
    end
  end

end