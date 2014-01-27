# encoding: UTF-8

require 'redcarpet'
module Jekyll
  class MarkdownExt < Converter

    def matches(ext)
      ext =~ /toto/i
    end

    def output_ext(ext)
      '.html'
    end

    def convert(content)
      mark = Redcarpet::Markdown.new(Redcarpet::Render::HTMLwithTopic.new, {
        :autolink => true,
        :fenced_code_blocks => true,
        :strikethrough => true,
        :space_after_headers => true
      })
      content.gsub!("```","\n```")
      mark.render(content)
    end

  end
end
