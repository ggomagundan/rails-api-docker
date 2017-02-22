require 'elasticsearch/model'

class Market < ApplicationRecord

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  after_save :reload_cache

  def reload_cache

    $redis.del "markets"

  end

  market_setting = {
    index: {
      number_of_shards: 1,
      "analysis":{
        "analyzer":{
          "korean":{
            "type":"custom",
            "tokenizer":"mecab_ko_standard_tokenizer"
          }
        }
      }
    }
  }

  settings market_setting do
    mapping do 
      indexes :market_name, analyzer: 'korean', index_options: 'offsets'
      indexes :location, analyzer: 'korean', index_options: 'offsets'
    end
  end


  def self.search_name(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['market_name']
          }
        }
      }
    )
  end


end

Market.import force: true

