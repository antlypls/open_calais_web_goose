require_relative 'goose-2.1.22-jar-with-dependencies.jar'

class CalaisService
  include_package 'com.gravity.goose'

  CALAIS_SERVICE = 'https://api.opencalais.com/tag/rs/enrich'

  def initialize(api_key)
    @api_key = api_key
  end

  def analyze_url(url)
    calais_data = get_calais(url)
    process_data(calais_data)
  end

  private

  def build_topics(collection)
    hash = Hash.new { |hsh, key| hsh[key] = {} }
    collection.each_with_object(hash) do |e, acc|
      name = yield(e)
      acc[e.name][name] = build_topic_hash(e)
    end
  end

  def build_topic_hash(element)
    element.attributes.each_with_object({}) do |(k, v), acc|
      acc[k] = v.value
    end
  end

  def process_data(data)
    doc = Nokogiri::XML(data)
    simple = doc.xpath('//CalaisSimpleOutputFormat').first

    all_entries_nodes = simple.children.reject { |e| e.name == 'SocialTags' }
    all_entries = build_topics(all_entries_nodes) { |e| e.text }

    social_tags_nodes = simple.children.xpath('//SocialTags/SocialTag')
    social_tags = build_topics(social_tags_nodes) { |e| e.children.first.text }

    all_entries.merge(social_tags)
  end

  def get_calais(url)
    page = fetch_page(url)
    post_calais_request(page)
  end

  def fetch_page(url)
    configuration = Configuration.new
    extractor = Goose.new(configuration)
    article = extractor.extractContent(url)
    article.cleanedArticleText
  end

  def post_calais_request(data)
    response = Faraday.post do |req|
      req.url(CALAIS_SERVICE)
      req.headers['Content-Type'] = 'TEXT/HTML'
      req.headers['enableMetadataType'] = 'GenericRelations,SocialTags'
      req.headers['x-calais-licenseID'] = @api_key
      req.headers['outputFormat'] = 'Text/Simple'
      req.body = data
    end

    response.body
  end
end
