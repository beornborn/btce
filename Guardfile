# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec do
  watch(%r{^spec/models/.+_spec\.rb$}) 
  watch(%r{^app/models/(.+)\.rb$})              { |m| "spec/models/#{m[1]}_spec.rb" }
  
  watch(%r{^spec/models/concerns/.+_spec\.rb$}) 
  watch(%r{^app/models/concerns/(.+)\.rb$})     { |m| "spec/models/concerns/#{m[1]}_spec.rb" }
  
  watch('spec/spec_helper.rb')  { "spec" }
end

