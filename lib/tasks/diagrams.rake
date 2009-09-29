# 'rake doc:diagrams' produces 'doc/models.pdf' and 'doc/controllers.pdf'

# In order to view/export the DOT diagrams, you'll need the processing tools
# from Graphviz (http://www.graphviz.org/).

namespace :doc do
  namespace :diagram do
    desc "Produces doc/models.pdf diagram"
    task :models do
      sh "railroad -i -l -a -m -M | dot -Tpdf > doc/models.pdf"
    end

#  XMI output not yet implemented in Railroad

#    desc " Produces model XMI for UML tools"
#    task :xmi do
#      sh "railroad -i -l -x -M > doc/models.xmi"
#    end

  end

  task :diagrams => %w(diagram:models)
end