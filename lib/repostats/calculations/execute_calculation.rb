class ExecuteCalculation

  def initialize(org, hashResults, subcommand, filename, onlycons = false)
    @langBytesCalc = LanguageBytesCalculator.new
    @org = org
    @result_collection = hashResults
    @subcommand = subcommand
    @filename = filename
    @onlycons = onlycons
  end

  #
  # case (1): langBytesPercent [subcommand: langBytesPerc]
  # (sum_bytes_per_lang/sum_all_repositories_bytes)
  #
  def langBytesPerc(all = false)
    results = @langBytesCalc.lang_bytes_percentage_toHash(@result_collection[:languages], @result_collection[:languages_bytes], @result_collection[:total_bytes])
    puts "|langBytesPercent| \n" + results.to_json.to_s unless all
    FileHandle.write_file(@org, results, @subcommand, @filename) unless all || @onlycons
    return results
  end

  #
  # case (2): avgPerRepository [subcommand: avgPerRepo]
  # (sum_bytes_per_lang/number_of_repositories)
  #
  def avgPerRepo(all = false)
    results = @langBytesCalc.avg_langBytes_per_repo_toHash(@result_collection[:main_languages], @result_collection[:languages], @result_collection[:languages_bytes])
    puts "|avgPerRepository| \n" + results.to_json.to_s unless all
    FileHandle.write_file(@org, results, @subcommand, @filename) unless all || @onlycons
    return results
  end

  #
  # case (3): avgPerLanguage [subcommand: avgPerLang]
  # (sum_bytes_per_lang/number_of_languages)
  #
  def avgPerLang(all = false)
    results = @langBytesCalc.avg_langBytes_per_lang_toHash(@result_collection[:languages], @result_collection[:languages_bytes])
    puts "|avgPerLanguage| \n" + results.to_json.to_s unless all
    FileHandle.write_file(@org, results, @subcommand, @filename) unless all || @onlycons
    return results
  end

  #
  # case (4): langPercent [subcommand: langPerc]
  # (number_of_lang_usages/number_of_languages)
  #
  def langPerc(all = false)
    results = @langBytesCalc.langUsages_percent_toHash(@result_collection[:languages], @result_collection[:languages_bytes], @result_collection[:total_repos_lang])
    puts "|langPercent| \n" + results.to_json.to_s unless all
    FileHandle.write_file(@org, results, @subcommand, @filename) unless all || @onlycons
    return results
  end

  #
  # case (5): mainlangPerRepoPercent [subcommand: mainLangPerc]
  # (sum_bytes_per_lang/number_of_languages)
  #
  def mainLangPerc(all = false)
    results = @langBytesCalc.mainlang_usages_percent_toHash(@result_collection[:main_languages])
    puts "|mainLanguagesPercent| \n" + results.to_json.to_s unless all
    FileHandle.write_file(@org, results, @subcommand, @filename) unless all || @onlycons
    return results
  end

  #
  # case (6): allLanguagesStatistics [subcommand: allStat]
  # includes cases 1-5
  #
  def allStats
    results = {}
    results[:langBytesPerc] = langBytesPerc(true)
    results[:avgPerRepo] = avgPerRepo(true)
    results[:avgPerLang] = avgPerLang(true)
    results[:langPerc] = langPerc(true)
    results[:mainLangPerc] = mainLangPerc(true)
    puts "|allLanguagesStatistics| \n" + results.to_json.to_s
    FileHandle.write_file(@org, results, @subcommand, @filename) unless @onlycons
    return results
  end


end