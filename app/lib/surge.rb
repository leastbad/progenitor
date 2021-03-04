module Surge
  class Sidenav
    attr_accessor :nodes
    attr_reader :digest, :path
    delegate :render, to: ApplicationController

    def initialize(nodes, path)
      @nodes = nodes
      @path = path
      @digest = Digest::SHA256.hexdigest(nodes.to_s)
    end

    def build
      nodes.map do |node|
        if node[:type] == "submenu"
          paths = []
          node[:subitems].each do |subitem|
            subitem[:paths] ||= []
            subitem[:paths] << subitem[:url] unless subitem[:paths].include?(subitem[:url])
            paths << subitem[:paths]
          end
          subitems = node[:subitems]
          node[:active] = paths.flatten.include?(path)
          [ render(partial: "sidenav/submenu_open", locals: {node: OpenStruct.new(node)}),
            submenu(subitems),
            render(partial: "sidenav/submenu_close")
          ].join
        else
          node[:paths] ||= []
          node[:paths] << node[:url] unless node[:paths].include?(node[:url])
          node[:active] = node[:paths].include?(path)
          render(partial: "sidenav/#{node[:type]}", locals: {node: OpenStruct.new(node)})
        end
      end.join
    end

    private

    def submenu(subitems)
      subitems.map do |subitem|
        subitem[:active] = subitem[:paths].include?(path)
        render(partial: "sidenav/subitem", locals: {node: OpenStruct.new(subitem)})
      end.join
    end
  end
end