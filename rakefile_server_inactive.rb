require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |test_file|
  test_file.libs << "test"
  test_file.test_files = FileList['test/*_test.rb']
  test_file.verbose = true
  test_file_array = FileList['test/*_test.rb']
  ruby test_file_array[0]
  ruby test_file_array[1]
  ruby test_file_array[4]
end
task default: :test
