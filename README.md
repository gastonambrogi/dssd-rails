# README
## Install

* RVM 

`gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`

`\curl -sSL https://get.rvm.io | bash -s stable --ruby`

`rvm install ruby-2.2.1`

`rvm use --default 2.2.1`

* Ruby version

>2.2

* Dependencies

`gem install bundler`

`bundle install`

* Database creation (update ``config/database.yml`` with correct db user and pass )

`rake db:create`

* Database initialization

`rake db:migrate`

`rake db:seed`

* Run server 

`rails s`

* Admin 

>user: admin@admin.com

>pass: admindssd

* ...
