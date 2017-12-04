module ApplicationHelpers
  def find_author(author)
    result = data.authors.select { |a| a.keys.first == author }
    raise ArgumentError unless result.any?
    result.first
  end

  def find_course(course)
    result = data.courses.select { |c| c.keys.first == course }
    raise ArgumentError unless result.any?
    result.first
  end

  def link_to_course(course)
    link_to find_course(course).name, course_path(course)
  end

  def list_of_courses
    sitemap.resources.map { |res| res.data.course }.compact.uniq.sort
  end

  def find_category(category)
    result = data.categories.select { |c| c.keys.first == category }
    raise ArgumentError unless result.any?
    result.first
  end

  def link_to_category(category)
    link_to find_category(category).name, category_path(category)
  end

  def list_of_categories
    sitemap.resources.map { |res| res.data.category }.compact.uniq.sort
  end

  def svg(name)
    root = Middleman::Application.root
    images_path = config[:images_dir]
    file_path = "#{root}/source/#{images_path}/#{name}.svg"

    return File.read(file_path) if File.exist?(file_path)
    '(SVG not found)'
  end

  def video(link)
    return unless link
    "<iframe width='100%' height='500' src='#{link}' frameborder='0' allowfullscreen></iframe>"
  end
end
