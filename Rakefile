# encoding: utf-8

task :default => :local

desc "Create a new article."
task :new do
  url =ask('Url:')
  title=url
  #slug = title.empty?? nil : title.strip.slugize
  slug = url.empty?? nil : slugize(url.strip)
  article = "---\n"
  hash = {'title' => title,
          'date' => Time.now.strftime("%d/%m/%Y"),
          'slug' => slug,
          'layout' => 'post',
          'author' => '史英建' }
  hash.each{|key,value| article << ("#{key}: #{value}\n")}
  #article = {'title' => '','author'=>'史英建', 'date' => Time.now.strftime("%d/%m/%Y")}.to_yaml
  article << "---\n"
  article << "\n\n<!--break-->\n\n\n\n"
  article << "Powered by [Engin](/about.html) & jekyll"

  path = "_posts/#{Time.now.strftime("%Y-%m-%d")}#{'-' + slug if slug}.toto"

  unless File.exist? path
    File.open(path, "w:UTF-8") do |file|
      file.write article
    end
    puts "文章生成成功: #{path}."
  else
    puts "已存在#{path}文件!"
  end
end


desc "generate _site."
task :local do
    puts "deploying locally..."
    `jekyll --server`
end

def slugize str
  str.downcase.gsub(/&/, 'and').gsub(/\s+/, '-').gsub(/[^a-z0-9-]/, '')
end

def ask message
  print message
  STDIN.gets.chomp
end

