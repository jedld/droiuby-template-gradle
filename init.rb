require 'thor'

class Init < Thor

  include Thor::Actions

  source_root File.join(File.dirname(__FILE__), 'templates')

  desc "init [java package] [archive] [name]", "initialize this template project"
  method_option :hybrid, :type => :boolean, :default=>false

  def init(package, archive, name = 'HelloWorld')
    package_folders = package.split('.')
    dest_folder = File.join('app','src','main')
    @package_name = package
    @archive_name = archive
    @project_name = name
    template File.join('AndroidManifest.xml.erb'), File.join(dest_folder, "AndroidManifest.xml")
    template File.join('strings.xml.erb'), File.join(dest_folder, 'res','values','strings.xml')
    if (options[:hybrid])
      template File.join('index.xml.erb'), File.join(dest_folder, 'res','layout','index.xml')
    end

    @sdk_dir = `which android`.sub('/tools/android','')

    template File.join('local.properties.erb'), 'local.properties'
    template File.join('StartupActivity.java.erb'), File.join(dest_folder, 'java', *package_folders, "StartupActivity.java")
    template File.join('DroiubyActivity.java.erb'), File.join(dest_folder, 'java', *package_folders, "DroiubyActivity.java")
  end
end
