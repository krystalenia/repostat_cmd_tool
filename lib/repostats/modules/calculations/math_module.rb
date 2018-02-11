module MathModule

  # Sums the bytes of a repository
  #
  # @param [Hash] repository (key: lang, value: bytes)
  # @return [Integer] total bytes per repository
  #
  def self.sum_repo_bytes(repository)
    return repository.sum {|key, value| value}
  end


  # Counts the length of an Array
  #
  # @param [Array] arr (reposArr / langArr)
  # @return [Integer] total number of repos / languages
  #
  def self.count_items(arr)
    unless arr.empty?
      return arr.length
    else
      raise "MathModule => Array should not be empty"
    end     
  end


  # Calculates the total bytes of all repos
  #
  # @param [Array] reposArr
  # @return [Integer] sum_bytes (total amount of bytes across all repos)
  #
  def self.total_repos_bytes(reposArr)
    sum_bytes = 0
    reposArr.each do |repo|
      sum_bytes += self.sum_repo_bytes(repo)
    end
    return sum_bytes
  end


  # Sums the code bytes written for a specific language
  #
  # @param [Array] reposArr
  # @param [String] lang
  # @return [Integer] sum_bytes (total amount of bytes per language)
  #
  def self.sum_lang_bytes(reposArr, lang)
    sum_bytes = 0
    reposArr.each do |repo|
      sum_bytes += repo[lang] unless repo[lang].nil?
    end
    return sum_bytes
  end


  # Counts the amount of times a language has been used across all repos
  #
  # @param [Array] reposArr
  # @param [String] lang
  # @return [Integer] lang_freq (frequency of a specific language)
  #
  def self.calc_lang_freq(reposArr, lang)
    lang_freq = 0
    reposArr.each do |repo| 
      lang_freq += 1 unless repo[lang].nil?
    end
    return lang_freq
  end


  # Calculates the times the same language has been used as main across all repos
  #
  # @param [Array] langArr
  # @param [String] lang
  # @return [Integer]
  #
  def self.calc_main_lang_freq(langArr, lang)
    return langArr.count(lang)
  end


  # Division between two integer values
  #``
  # @param [Integer] value_A
  # @param [Integer] value_B
  # @return [Integer] division result
  #
  def self.division(value_A, value_B)
    unless value_B.eql?(0)
      return value_A.to_f / value_B.to_f
    else
      raise "MathModule => Division error: perhaps value_B is zero"
    end
  end


  # Calculates the percentage of a value
  # rounded to 2 decimal digits
  #
  # @param [Integer] value
  # @return [Integer] the percentage
  #
  def self.calc_percentance(value)
    return (value * 100).round(2) unless value < 0
  end

  # Create set from an array
  #
  # @param [Array] langArr
  # @return [Array] array with unique values
  #
  def self.create_set(langArr)
    return langArr.uniq
  end
end