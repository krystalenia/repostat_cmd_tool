# Parse data given

class ParseData
  include Organization, Validations

  def parse_org_response(org, response)
    response = JSON.parse(response)
    orgsNum = response['total_count'].to_i
    case
      when orgsNum == 0
        return "Organization was not found"
      when orgsNum == 1
        isMatch = orgMatch?(org, response)
        unless isMatch
          return "Organization found does not match with the input one"
        end
        return isMatch
      when orgsNum > 10
        return "More than 10 organizations found"
      when orgsNum <= 10
        return "Related Organizations: " + display_related_orgs(response).join(", ")
      else
        raise "Unexpected Error"
    end

  end


  def collect_repos(gitApiCalls, org)
    reposCollection=[]
    lastPage = false
    currentPage = 1
    until lastPage
      response = gitApiCalls.get_repositories(org, "sources", currentPage)
      reposCollection << response[:data]
      lastPage = lastPage?response[:links]
      currentPage += 1
    end
    return reposCollection
  end

  def collect_languages(repos_collection, gitApiCalls, vcs)
    reposLanguages = []
    reposLangBytes = []
    mainLanguages = []
    totalBytes = 0
    totalLanguages = 0
    repos_collection.each do |repoArray|
      JSON.parse(repoArray, :symbolize_names => true).each do |repo|
        unless repo[:private] || repo[:language].nil? || repo[:language].empty?
          mainLanguages << repo[:language]
          tempBytes = JSON.parse(gitApiCalls.get_languages(repo[:languages_url].sub! RepostatsDefaults.vcsoptions[vcs][:url], ''))
          reposLanguages += tempBytes.keys - reposLanguages
          reposLangBytes << tempBytes
          totalBytes += MathModule.sum_repo_bytes(tempBytes)
          totalLanguages += MathModule.count_items(tempBytes)
        end
      end
    end
    return {:main_languages => mainLanguages, :languages => reposLanguages, :languages_bytes => reposLangBytes, :total_bytes => totalBytes, :total_repos_lang => totalLanguages}
  end

end