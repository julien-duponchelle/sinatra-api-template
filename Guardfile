guard 'rspec', :cli => "--color" do
  watch(%r{^[\/]+\.rb$}) do
    ["spec/application_spec.rb"]
  end
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/controllers/(.+)\.rb$}) do |m|
    "spec/controllers/#{m[1]}_spec.rb"
  end
  watch(%r{^lib/models/(.+)\.rb$}) do |m|
    ["spec/models/#{m[1]}_spec.rb", "spec/controllers/#{m[1]}_spec.rb" ]
  end
  watch('spec/spec_helper.rb')  { "spec" }
end

