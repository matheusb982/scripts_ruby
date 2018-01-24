require 'aws-sdk'
require 'nokogiri'
require 'open-uri'

class Synthesizer
  def initialize(region='us-east-1')
    @polly = Aws::Polly::Client.new(region: region, credentials: Aws::Credentials.new('AKIAIDQGOCNUQNP6Y33Q', 'dYEVzLfW4ZfAhuuNC14Qw93tCtHAjbdba5bNx4Yj'))
  end

  def synthesize(text, file_name="./tmp.mp3", voice_id="Ricardo")
    @polly.synthesize_speech(
      response_target: file_name,
      text: text,
      output_format: "mp3",
      # You can use voice IDs http://docs.aws.amazon.com/polly/latest/dg/API_Voice.html
      # If you want to synthesize Japanese voice, you can use "Mizuki"
      voice_id: voice_id
    )
  end
end

module TextFetcher
  def self.fetch_text_from(url, xpath)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    node_texts = doc.xpath(xpath).map(&:text)

    combined_texts = []
    tmp_string = ""
    node_texts.each do |text|
      if tmp_string.size + text.size > 1500
        combined_texts << tmp_string
        tmp_string = text
      else
        tmp_string << " #{text}"
      end
    end
    combined_texts << tmp_string
  end
end

if __FILE__ == $0
  synthesizer = Synthesizer.new

  url = "https://medium.com/@chezou/building-predictive-model-with-ibis-impala-and-scikit-learn-356b41f404e0#.xeiwrmhhb"
  # This XPath assumes medium contents
  xpath = '//section//text()'
  input_texts = TextFetcher.fetch_text_from(url, xpath)
  text = 'Olá, Uilton viado'

  #input_texts.each.with_index do |text, i|
    synthesizer.synthesize(text, "./tmp_0.mp3")
    sleep(1)
  #end
  # You can combine mp3 with cat on Linux based system
  #`cat ./tmp_*.mp3 > ./combined.mp3`
end
