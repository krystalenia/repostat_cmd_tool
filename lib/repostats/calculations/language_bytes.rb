class LanguageBytesCalculator

  # Computes the total amount of code bytes per language
  #
  # @param [Array] lang_set (distinct languages values)
  # @param [Array of Hashes] lang_bytes (code language bytes for each repository)
  # @return [Hash] bytes_per_lang
  #
  def bytes_per_lang_toArr(lang_set, lang_bytes)
    bytes_per_lang = {}
    lang_set.each do |lang|
      bytes_per_lang[lang] = MathModule.sum_lang_bytes(lang_bytes, lang)
    end
    return bytes_per_lang
  end


  # Performs the division based on a parameter
  #
  # @param [Array] lang_set (distinct languages values)
  # @param [Array of Hash] lang_bytes (code language bytes for each repository)
  # @param [Integer] items (division parameter)
  # @return [Hash] avg_langBytes (avg bytes per language)
  #
  def statistic_per_lang (lang_set, lang_bytes, items)
    avg_langBytes = {}
    bytes_per_lang_toArr(lang_set, lang_bytes).each do |lang, bytes|
      lang_avg = MathModule.division(bytes, items).round(2)
      avg_langBytes[lang] = lang_avg
    end
    return avg_langBytes
  end


  # Computes the frequency for each language
  #
  # @param [Array] lang_set
  # @param [Array of Hash] lang_bytes
  # @return [Hash]
  #
  def lang_freq_toHash(lang_set, lang_bytes)
    lang_freq = {}
    lang_set.each do |lang|
      freq = MathModule.calc_lang_freq(lang_bytes, lang)
      lang_freq[lang] = freq
    end
    return lang_freq
  end


  # Calculates the language bytes percentage
  #
  # (sum_bytes_per_lang/sum_all_repositories_bytes)
  #
  # @param [Array] lang_set (distinct languages values)
  # @param [Array of Hash] lang_bytes (code language bytes for each repository)
  # @param [Integer] repos_bytes (total repositories bytes)
  # @return [Hash] lang_bytes_percentage hash
  #
  def lang_bytes_percentage_toHash(lang_set, lang_bytes, repos_bytes)
    lang_bytes_percentage = {}

    bytes_per_lang_toArr(lang_set, lang_bytes).each do |lang, bytes|
      lang_percentage = MathModule.calc_percentance(MathModule.division(bytes, repos_bytes))
      lang_bytes_percentage[lang] = lang_percentage
    end
    return lang_bytes_percentage
  end


  # Calculates the average language bytes per num of repositories
  #
  # (sum_bytes_per_lang/number_of_repositories)
  #
  # @param [Array] langArr (not distinct number of languages - used to count the repos)
  # @param [Array] lang_set (distinct languages values)
  # @param [Array] lang_bytes (code language bytes for each repository)
  #
  # @return [Hash] avg_langBytes
  #
  def avg_langBytes_per_repo_toHash(langArr, lang_set, lang_bytes)
    repos_num = MathModule.count_items(langArr)

    avg_langBytes = statistic_per_lang(lang_set, lang_bytes, repos_num)
    return avg_langBytes

  end


  # Calculates the average language bytes per num of languages
  #
  # (sum_bytes_per_lang/number_of_languages)
  #
  # @param [Array] lang_set (distinct languages values)
  # @param [Array] lang_bytes (code language bytes for each repository)
  # @return [Hash] avg_langBytes
  #
  def avg_langBytes_per_lang_toHash(lang_set, lang_bytes)
    lang_num = MathModule.count_items(lang_set)

    avg_langBytes = statistic_per_lang(lang_set, lang_bytes, lang_num)
    return avg_langBytes
  end


  # Calculate the languages usages per number of languages
  #
  # (lang_freq/number_of_not_distinct_languages)
  #
  # @param [Array] lang_set
  # @param [Array of Hash] lang_bytes
  # @param [Integer] lang_num
  # @return [Hash]
  #
  def langUsages_percent_toHash(lang_set, lang_bytes, lang_num)
    langUsage = {}

    lang_freq_toHash(lang_set, lang_bytes).each do |lang, freq|
      langFreq = MathModule.calc_percentance(MathModule.division(freq, lang_num))
      langUsage[lang] = langFreq
    end
    return langUsage
  end


  # Calculates the frequency of the languages used as main across all repos
  #
  # (main_lang_freq/number_of_repositories)
  #
  def mainlang_usages_percent_toHash(langArr)
    main_lang_freq = {}
    repos_num = MathModule.count_items(langArr)
    lang_set = MathModule.create_set(langArr)

    lang_set.each do |lang|
      lang_freq = MathModule.calc_main_lang_freq(langArr, lang)
      freq_percent = MathModule.calc_percentance(MathModule.division(lang_freq, repos_num))
      main_lang_freq[lang] = freq_percent
    end
    return main_lang_freq
  end

  private :statistic_per_lang

end