# vcsApiCalls includes methods about the
# api calls that need to be implemented

class VCSApiCalls

  attr_reader :conn

  # Initialize Faraday Connection
  #
  # @param [String] baseUrl
  #
  def initialize(baseUrl)
    @baseUrl = baseUrl
  end

  # Establish new connection
  #
  def establish_connection(header, cachefile)
    @conn = Faraday.new(:url => @baseUrl)
    # @conn.use Faraday::Response::Logger
    @conn.use Faraday::HttpCache, store: cachefile, logger: RepoLogger.get_logger, shared_cache: false
    @conn.adapter Faraday.default_adapter
    @conn.response :logger, RepoLogger.get_logger
    conn_headers(header)
  end

  # Set connection headers
  #
  def conn_headers(headersMap)
    @conn.headers = headersMap
  end

  def get_organization
    raise NotImplementedError, "NotImplementedError: method get_organization"
  end

  def get_repositories
   raise NotImplementedError, "NotImplementedError: method get_repositories"
  end

  def get_languages
    raise NotImplementedError, "NotImplementedError: method get_languages"
  end

end