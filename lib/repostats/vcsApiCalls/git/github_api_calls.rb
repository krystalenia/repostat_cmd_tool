class GithubApiCalls < VCSApiCalls

  def initialize(baseUrl)
    super(baseUrl)
  end

  # Establishes new unencoded connection
  #
  # @param [Hash] header
  #
  def unencoded_connection(header)
    @conn = Faraday.new(:url => @baseUrl, :request => {:params_encoder => UnescapeEncoder})
    # @conn.use Faraday::Response::Logger
    @conn.adapter Faraday.default_adapter
    @conn.response :logger, RepoLogger.get_logger
    conn_headers(header)
  end

  # Performs query to search users API
  #
  # @param [String] org
  # @return [JSON] response body
  #
  def get_organization(org)
    response = @conn.get 'search/users', {:q => "#{org}+type:org"}
    Validations.checkHttpStatus(response)
    return response.body
  end

  # Performs query to Search Repositories API
  #
  # @param [String] org
  # @param [Integer] pageNumber
  # @return [Hash] response body and header links
  #
  def get_repositories(org, type = 'all', pageNumber = 1)
    response = @conn.get 'orgs/' + org + '/repos', {:type => type, :page => pageNumber}
    Validations.checkHttpStatus(response)
    raise "No Repositories Found" if response.body.empty?
    return {:data => response.body, :links => parse_header_links(response)}
  end

  # Performs query to Languages API
  #
  # @param [String] langUrl
  # @return [JSON] response body
  #
  def get_languages(langUrl)
    response = @conn.get langUrl
    Validations.checkHttpStatus(response)
    return response.body
  end


  # Parse Links from Response header
  # Handle pagination info
  #
  # @param [Object] response
  # @return [Array] links
  #
  def parse_header_links(response)
    links = response.headers['link'].to_s.split(',')
    links.each { |link| link.strip!}
    return links
  end

end