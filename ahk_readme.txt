heroku run console,

User.first.update_column(:role, 'admin')

heroku run rake db:migrate --app allahundkurser

git push git@heroku.com:allahundkurser.git master

allahundkurser.herokuapp.com




Production

Pre compile assets:

RAILS_ENV=production bundle exec rake assets:precompile

commit, push


https://devcenter.heroku.com/articles/rails-asset-pipeline


GIT

Rollback to last commit:

git reset --hard HEAD^  
git clean -f