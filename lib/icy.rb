require "pathname"

module Icy
  RUBY_EXTNAME = '.rb'

  def self.require_tree(pathname, exclude: nil)
    pathname = Pathname.new pathname
    pathname_exclusions = Array(exclude).map { |exclude| Pathname.new exclude }

    working_dir = if pathname.relative? || pathname_exclusions.any?
      calling_filepath = caller[0].split(':')[0]
      Pathname.new(calling_filepath).parent
    end

    pathname = working_dir.join(pathname) if pathname.relative?

    pathname_exclusions = pathname_exclusions.map do |pathname_exclusion|
      working_dir.join(pathname_exclusion) if pathname_exclusion.relative?
    end

    selected_children = pathname.children.reject do |child_pathname|
      pathname_exclusions.any? { |exl| child_pathname == exl }
    end

    selected_children.each do |child|
      if child.directory?
        require_tree child
      elsif child.extname == RUBY_EXTNAME
        require_relative child
      end
    end

    true
  end
end

Icy.require_tree 'icy'
