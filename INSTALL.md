### copied from http://blog.bell-n-whistle.com/2011/06/08/tutorial-ruby-on-rails-3-and-faye/

* open a shell
```sh
git clone git://github.com/mvj3/rails3-todo-app.git && cd rails3-todo-app
export RAILS_ENV=production
bundle install
bundle exec rake db:create && rake db:migrate
bundle exec rails s
```

* open another shell
```sh
bundle exec rackup faye.ru -s thin -E production
```

* open http://your_local_ip:3000/projects/7 in window 1, and create a task
* open another http://your_local_ip:3000/projects/7 in window 2, and you'll see the task that created just now
* change to window1, and update state to 'in-process', and it'll placed in "In Process" Section
* change to window2, you'll see it happened too.
* so this is the live chat.
