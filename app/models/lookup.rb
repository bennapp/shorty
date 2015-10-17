class Lookup < ActiveRecord::Base
  validates_presence_of :url
  validates_presence_of :token
  validates_uniqueness_of :token

  before_save :prepend_http_protocol
  before_update :prepend_http_protocol

  def prepend_http_protocol
    self.url = "http://#{url}" unless url.index('http://') == 0 || url.index('https://') == 0
  end
end
