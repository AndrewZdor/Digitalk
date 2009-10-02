namespace :uml do
  desc "Generate an XMI db/schema.xml file describing the current DB as seen by AR. Produces XMI 1.1 for UML 1.3 Rose Extended, viewable e.g. by StarUML"
  task :schema => :environment do
    load RAILS_ROOT + '/vendor/plugins/uml/lib/uml_dumper.rb'
    
    File.open("db/schema.xml", "w") do |file|
      ActiveRecord::UmlDumper.dump(ActiveRecord::Base.connection, file)
    end 
    puts "Done. Schema XMI created as db/schema.xml."
  end
end