# encoding: UTF-8

require 'redcarpet' 
require 'coderay'
module Redcarpet
  module Render
    class HTMLwithSyntaxHighlight < HTML

      def initialize(extensions={})
        super(extensions.merge(:xhtml => true,
                               :no_styles => true,
                               :filter_html => true,
                               :hard_wrap => true))
      end

      def block_code(code, language)
        language = 'text' if language.nil? or language.empty?
        code = code[0...-1] if code[-1] == "\n" #delete the two \n made before the last ```
        begin
          CodeRay.scan(code,language).div(:line_numbers => :inline)
        rescue
          CodeRay.scan(code,:text).div
        end
      end

      def autolink(link, link_type)
        # return link
        if link_type.to_s == "email"
          link
        else
          begin
            # 防止 C 的 autolink 出来的内容有编码错误，万一有就直接跳过转换
            # 比如这句:
            # 此版本并非线上的http://yavaeye.com的源码.
            link.match(/.+?/)
          rescue
            return link
          end
          # Fix Chinese neer the URL
          bad_text = link.to_s.match(/[^\w\d:\/\-\,\$\!\_\.=\?&#+\|\%]+/im).to_s
          link = link.to_s.gsub(bad_text, '')
          "<a href=\"#{link}\" rel=\"nofollow\" target=\"_blank\">#{link}</a>#{bad_text}"
        end
      end
    end

    class HTMLwithTopic < HTMLwithSyntaxHighlight
      # Topic 里面，所有的 head 改为 h4 显示
      #def header(text, header_level)
       # "<h4>#{text}</h4>"
      #end
    end
  end
end

