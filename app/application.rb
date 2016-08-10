class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/testing/)
      resp.write "Route not found"
      resp.status = 404
    elsif req.path.match(/items/)
      item_request = req.path.split("/items/").last
      if item = @@items.find{|i| i.name == item_request}
        resp.write item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    end

    resp.finish
  end
end