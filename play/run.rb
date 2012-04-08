$: << 'lib'
require 'space'

app = Space::App.new('travis')
app.run
# @repo = Space::Model::Repo.new(project, '.')
# @repo.git.refresh

