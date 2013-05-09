
----------------------------------------------------
####### DEPLOY #####################################
----------------------------------------------------

heroku run console,

User.first.update_column(:role, 'admin')

heroku run rake db:migrate --app allahundkurser

git push git@heroku.com:allahundkurser.git master

allahundkurser.herokuapp.com

----------------------------------------------------
####### PROD SETTINGS ##############################
----------------------------------------------------

Production

Pre compile assets:

RAILS_ENV=production bundle exec rake assets:precompile

commit, push


https://devcenter.heroku.com/articles/rails-asset-pipeline

----------------------------------------------------
####### GIT ########################################
----------------------------------------------------

Rollback to last commit:

git reset --hard HEAD^  
git clean -f


----------------------------------------------------
####### SETUP ######################################
----------------------------------------------------

Install instructions:

http://www.creativereason.com/how-to-install-ruby-on-rails-mountain-lio.html
http://bigbangtechnology.com/post/installing_postgresql_on_mac_os_x/

Tutorial to getting started with rails:

http://guides.rubyonrails.org/getting_started.html 


1 - Install xcode
2 - Install homebrew
3 - Install Git
4 - Install RVM
5 - Install Ruby
6 - Install Rails 
7 - Install Postgres


1. Xcode

Download/update from Istore


2. Homebrew

ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

brew doctor


3. Git

brew install git

4. RVM

bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

Test to make sure it's working: 
type rvm | head -1 (if success "rvm is a function")

restart terminal


5. Ruby

rvm install 1.9.3

restart terminal


6. Rails 

gem install rails

rails --version (3.2.x)

rails new blog 

cd blog 


Setup gemfile (gem 'pg') + database.yml: 

development:

  adapter: postgresql

  encoding: unicode

  database: blog_development

  pool: 5

  username: mikaelfalgard



7. Postgres

Edit /etc/paths like this:

/usr/local/bin
/usr/local/sbin
/usr/bin
/bin
/usr/sbin 
/sbin

brew install postgres

>Init DB 
>Setup to run using launch
>Install pg gem:
ARCHFLAGS="-arch x86_64" gem install pg

which psql (should be /usr/local/bin/psql)

create admin user as superuser (or use default user ex mikaelfalgard)
createuser 

bundle install (or bundle update)

rake db:create:all

Start rails 
rails s 

Go to localhost:3000

Close rails 
ctrl + C


Allahundkurser

git checkout (download github app) 
Fix gemfile + database.yml
rake db:migrate
start rails 
rails s
Go to localhost:3000


PSQL Commands
http://manikandanmv.wordpress.com/tag/basic-psql-commands/

psql allahundkurser_development

\l - list all
\c allahundkurser_development - connect to db
\dt - view list of tables 
\q - quit

SELECT * FROM users;
UPDATE users SET role='superuser' WHERE id = 1;

