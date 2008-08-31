require 'rubygems'
require 'rake'
require 'rake/testtask'

desc "TMBundle Test Task"
task :default => [ :test ]
Rake::TestTask.new { |t|
  t.libs << "test"
  t.pattern = 'Support/test/test_*.rb'
  t.verbose = true
  t.warning = false
}
Dir['Support/tasks/**/*.rake'].each { |file| load file }


desc "Scrape protocol signatures from iPhone SDK docco"
task :scrape_protocols do
  require "rubygems"
  gem 'hpricot'
  require "hpricot"
  require "yaml"
  doc_root = "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone2_0.iPhoneLibrary.docset/Contents/Resources/Documents/documentation"
  protocol_docs = Dir[doc_root + "/*/Reference/*_Protocol/*/*.html"]
  protocol_definitions = protocol_docs.inject({}) do |docs, path|
    doc = Hpricot(open(path))
    name       = doc.search("h1").inner_html.gsub(/\s+Protocol Reference/, "")
    next docs if name == "Index" || name.index(" ")
    method_interfaces = doc.search("p.spaceabovemethod").map { |method| method.inner_html.gsub(/<[^>]*>/,'') }
    compact_methods = method_interfaces.inject({}) do |mem, method|
      compact = method.gsub(/\([^)]+\)/,'').scan(/\w+\:/).join # TODO - only methods with args, no properties or no-arg methods
      mem[compact] = method
      mem
    end
    required   = []
    optional   = []
    method_index = doc.search("li.tooltip span")
    method_index.each do |method|
      compact_name = method.search("code a").inner_html.gsub("&#8211;", "").gsub("&#xA0;", "")
      next if compact_name.length == 0
      full_spec   = compact_methods[compact_name]
      if method.search("span.task_api_suffix").size == 0
        required << full_spec
      else
        optional << full_spec
      end
    end
    docs[name] = { :name => name, :path => path, :required => required, :optional => optional }
    print '.'
    docs
  end
  File.open(File.dirname(__FILE__) + "/Support/protocols.yml", "w") do |f|
    f << YAML.dump(protocol_definitions)
  end
end