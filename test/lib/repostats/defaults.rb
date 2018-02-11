class RepostatsDefaults
  VCSOPTS = {
                :github => {
                  :url => 'https://api.github.com/', 
                  :media_type => 'application/vnd.github.v3+json'
                }
              }
  VCSHOSTS = [:github]

  def self.vcsoptions
    VCSOPTS
  end

  def self.vcshosts
    VCSHOSTS
  end


end