class Lookup < ActiveRecord::Base
  include Dictionary

  validates_presence_of :url
  validates_presence_of :token
  validates_uniqueness_of :token
  #validate TODO: validate lenght of token make sure its no over 255

  before_save :prepend_http_protocol
  before_update :prepend_http_protocol

  before_validation :base_36_encode
  before_update :base_36_encode

  def shortify
    loop do
      adj = rand_adj
      next_adj = different_rand_adj(adj)
      word = [adj, next_adj, rand_noun].join('-')
      break word unless Lookup.where(token: word).first.present?
    end
  end

  def prepend_http_protocol
    self.url = "http://#{url}" unless url.index('http://') == 0 || url.index('https://') == 0
  end

  def base_36_encode
    return if token.present?
    self.token = loop do
      random_id = rand(('z' * 8).to_i(36))
      break random_id.to_s(36) unless Lookup.where(token: random_id.to_s(36)).first.present?
    end
  end
end
