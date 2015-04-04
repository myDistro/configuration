
require 'rake/clean'
require 'json'

test_path = './.test_path'  # temporarly install module for testing here

CLEAN.include('pkg/')
CLEAN.include(test_path)


# extracts a key from the Modulefile
def module_extract(value)
    json = JSON.parse( File.open('metadata.json', 'r').read)
    return json[value]
end

desc 'build puppet module'
task :build do
    sh 'puppet module build'
end

def install_package(path = nil )
    if path  
        sh "puppet module install pkg/#{module_extract('name')}-#{module_extract('version')}.tar.gz --modulepath=#{path}"
    else
        sh "puppet module install -f pkg/#{module_extract('name')}-#{module_extract('version')}.tar.gz"
    end
end

desc 'install puppet module'
task :install => ['build'] do
    install_package
end

desc 'test puppet module'
task :test => ['build'] do 
    # install stuff in an area for testing (including dependencies)
    install_package(test_path)
    # run tests with that area as module area
    sh "puppet apply --noop tests/init.pp --modulepath=#{test_path}"
end




