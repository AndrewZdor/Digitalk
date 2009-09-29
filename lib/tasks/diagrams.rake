# 'rake doc:diagrams' produces 'doc/models.svg' and 'doc/controllers.svg'
# In order to view/export the DOT diagrams, you'll need the processing tools
# from Graphviz (http://www.graphviz.org/).

namespace :doc do
  namespace :diagram do
    task :models do
      sh "railroad -i -l -a -m -M | dot -Tpdf' > doc/models.pdf"
    end

    task :controllers do
      sh "railroad -i -l -C | neato -Tpdf' > doc/controllers.pdf"
    end
  end

  task :diagrams => %w(diagram:models diagram:controllers)
end