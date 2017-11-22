module ApplicationHelpers
  def find_author(author)
    result = data.authors.select {|a| a.keys.first == author}
    raise ArgumentError unless result.any?
    result.first
  end
end
