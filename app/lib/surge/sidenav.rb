module Surge
  class Sidenav
    attr_reader :nodes, :digest, :path
    delegate :render, to: ApplicationController

    def initialize(nodes, path)
      @nodes = nodes
      @path = path
      @digest = Digest::SHA256.hexdigest(nodes.to_s)
    end

    def to_s
      Rails.cache.fetch("sidenav:#{path}:#{digest}") { build.html_safe }
    end

    def build
      nodes.map { |node|
        if node[:type] == "submenu"

          paths = []

          node[:subitems].each do |subitem|
            subitem_paths = subitem[:paths] || []
            subitem_paths << subitem[:url] unless subitem_paths.include?(subitem[:url])
            paths << subitem_paths
          end

          [render(
            partial: "sidenav/submenu_open",
            locals: {
              node: OpenStruct.new(node),
              active: paths.flatten.include?(path)
            }
          ),
            submenu(node[:subitems]),
            render(partial: "sidenav/submenu_close")].join
        else
          paths = node[:paths] || []
          paths << node[:url] unless paths.include?(node[:url])

          render(
            partial: "sidenav/#{node[:type]}",
            locals: {
              node: OpenStruct.new(node),
              active: paths.include?(path)
            }
          )
        end
      }.join
    end

    private

    def submenu(subitems)
      subitems.map { |subitem|
        subitem_paths = subitem[:paths] || []
        subitem_paths << subitem[:url] unless subitem_paths.include?(subitem[:url])

        render(
          partial: "sidenav/subitem",
          locals: {
            node: OpenStruct.new(subitem),
            active: subitem_paths.include?(path)
          }
        )
      }.join
    end
  end
end
