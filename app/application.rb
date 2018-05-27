class Application

  @@cart = Array.new
  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write dispay_cart
    elsif req.path.match(/add/)
      item_to_add = req.param["item"]
      resp.write add_item(item_to_add)
    else
      resp.write "Path Not Found"
    end

      resp.finish
    end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      puts "Couldn't find #{search_term}"
    end
  end

  def dispay_cart
    if @@cart.empty?
      return "Your cart is empty!"
    else
      return "Your cart contains #{@@cart.join("\n")}"
    end
  end

  def add_item(item_to_add)
    if @@cart.include?(item_to_add)
      @@cart << item_to_add
      return "#{item_to_add} has been added to the cart."
    else
      return "We don't have that item"
    end
  end
end
