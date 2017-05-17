require_relative 'env'

class App
  def self.start
    # get "block"
    models.marshal

    # OP_RETURN
    tx bitcoin -> models unmarshal
  end

  # net + block explorer host
  #
  # def self.get(url)
  #   url  = URI.parse url
  #   resp = Net::HTTP.get_response url
  #   Oj.load resp.body
  # end


end

App.start
