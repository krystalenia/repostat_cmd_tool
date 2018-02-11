require 'repostats/version.rb'
require 'faraday'
require 'active_support/all'
require 'logger'
require 'faraday-http-cache'


# Modules
require 'repostats/modules/modules.rb'
require 'repostats/modules/organization.rb'
require 'repostats/validations/validations.rb'
require 'repostats/modules/calculations/math_module.rb'

# Classes
require 'repostats/defaults.rb'
require 'repostats/vcsApiCalls/vcs_api_calls.rb'
require 'repostats/vcsApiCalls/git/github_api_calls.rb'
require 'repostats/parser/parse_data.rb'
require 'repostats/calculations/language_bytes.rb'
require 'repostats/calculations/execute_calculation.rb'



# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file
