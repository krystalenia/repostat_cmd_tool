module Organization

  # Displays the relevant with the input
  # organization names
  #
  # @param [JSON] orgsInfo (search org api response)
  # @return [Array] orgList (relevant org names)
  #
  def display_related_orgs(orgsInfo)
    orgList = []
    orgsInfo['items'].each do |item|
      orgList << item['login']
    end
    return orgList
  end

  # Checks if the organization (org) in the api response
  # matches the input organization name
  #
  # @param [String] org   (org Name)
  # @param [JSON] orgInfo (search org api response)
  #
  def orgMatch?(org, orgInfo)
    orgInput = orgInfo['items'][0]['login']
    return org.eql?(orgInput)

  end

end