module ApplicationHelpers
  def find_author(author)
    result = data.authors.select {|a| a.keys.first == author}
    raise ArgumentError unless result.any?
    result.first
  end

  def svg(name)
    root = Middleman::Application.root
    images_path = config[:images_dir]
    file_path = "#{root}/source/#{images_path}/#{name}.svg"

    return File.read(file_path) if File.exists?(file_path)
    "(SVG not found)"
  end

  def video(link)
    if link
      "<iframe width='100%' height='500' src='#{link}' frameborder='0' allowfullscreen></iframe>"
    end
  end
end
