ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']

Elasticsearch::Model.client = Elasticsearch::Client.new log:true, host:'myph.herokuapp.com'