# README

# Screenshot

![alt tag](https://raw.githubusercontent.com/ltfschoen/rails_csv_app/master/screenshot3.png)

---

# Table of Contents
  * [Instructions](#part-500)
  * [Goals](#part-750)
  * [System Requirements and Info](#part-1000)
  * [Database](#part-1100)
  * [Documentation Links](#part-1500)
  * [Setup - Legacy Initial Steps](#part-2000)
  * [Setup - Replace Unit Test with RSpec](#part-3000)
  * [Setup - Git Repo](#part-4000)
  * [Setup - Git Releases and Tags](#part-5000)
  * [Feature - CSV Upload and Display](#part-6000)
  * [Feature - Search and Filter Data Uploaded from CSV with Pagination](#part-7000)
  * [Feature - Bootstrap](#part-8000)
  * [Feature - Fake CSV Generator](#part-9000)

---

## Instructions <a id="part-500"></a>

* Install System Requirements
* Install Gems `bundle install`
* Run PostgreSQL
* Run Rails Server `rails s`
* Go to http://localhost:3000
* Click "Choose File" (to upload a CSV)
* Select the [products.csv](https://github.com/ltfschoen/rails_csv_app/blob/master/products.csv) file located in the root directory
* Click "Import CSV"
* Click the "1", "2", "Next" or "Previous" to change Page using Pagination
* Click the column Labels (i.e. "Uid", "Name", "Price", "Quantity", "Released") to filter ordering ascending/descending
* Enter a value in the input field (case sensitive). Click "Search" to filter list.

## Goals <a id="part-750"></a>

* [X] - Import pre-populated CSV into database from web form.
* [X] - Present populated data from database in table view
* [X] - Use AJAX and apply basic filters on table so data updated without refreshing whole page.
* [X] - Use Sass instead of CSS
* [X] - Add Bootstrap 4 styling for buttons and tables and Responsive grid
* [X] - Generate Fake CSV Data
* [X] - Add Images using LorelPixel
* [ ] - Switch front-end to React.js or Angular.js instead of jQuery
* [ ] - Add more Unit Tests

## System Requirements and Info<a id="part-1000"></a>
* Show System Setup
    `rails about`

* Versions used:
    * Rails - 5.0.2
    * Ruby - 2.4.0-p0 (see .ruby-version)
    * RubyGems - 2.6.10
    * Ruby Gemset - rails_csv_app (see .ruby-gemset)
    * Rack - 2.0.1
    * Node.js - 7.7.1 (V8 runtime)
    * PostgreSQL - 9.6.2
    * RSpec - 3.5.4
    * OS - macOS El Capitan

* Show Codebase Stats
    `rails stats`

## Database <a id="part-1100"></a>

* Run PostgreSQL without background service:
	`pg_ctl -D /usr/local/var/postgres start`
* Configure to start PostgreSQL and restart at login using launchd background service:
	`brew services start postgresql`
* Open PostgreSQL Database console automatically http://guides.rubyonrails.org/command_line.html
    `rails dbconsole`

* Show database table contents
    ```
    select * from products;
    ```

## Documentation Links <a id="part-1500"></a>

* Testing
    * RSpec Rails https://github.com/rspec/rspec-rails

## Setup - Legacy Initial Steps <a id="part-2000"></a>

* Create Project
	```
	rails new rails_csv_app --database=postgresql
	rvm list
	```

* Install latest RVM to install and use latest Ruby version. Update PostgreSQL.
	```
	rvm get master
	rvm install ruby-2.4.0
	brew upgrade bash
	brew update
	brew reinstall postgresql
	rvm reinstall ruby-2.4.0
	rvm use ruby-2.4.0
	```

* Update to latest RubyGems version https://rubygems.org/pages/download
    ```
    gem install rubygems-update
    update_rubygems
    gem update --system
    ```

* Update to latest JavaScript Runtime. Install NVM.
  Check latest stable Node.js version https://nodejs.org
  Check current version and update.
  Install latest version of NPM.
    ```
    node -v
    npm install -g npm
    nvm install 7.7.1
    nvm use 7.7.1
    ```

* Create custom Gemset with RVM
	```
	rvm gemset create rails_csv_app
	rvm --ruby-version use 2.4.0@rails_csv_app
	```

* Check latest Rails version that is available: https://rubygems.org/gems/rails/versions
* Install latest specific Rails version
	`gem install rails --version 5.0.2`

* Check database.yml is setup correctly for development

* Check that using custom GemSet. Install default Gems in Gemfile
    ```
    rvm --ruby-version use 2.4.0@rails_csv_app
    gem install bundler
	bundle install
	```

* Migrate into PostgreSQL Database
	```
	rake db:create db:migrate RAILS_ENV=development
	```

* Launch the Rails server in separate Terminal tab automatically and opens it in web browser after 10 seconds using Shell Script:
    `bash launch.sh`

    * Alternatively: Run server command, and then manually go to url, or in a separate tab run command to open app in browser
    	`rails s`
    	`open http://localhost:3000`

## Setup - Replace Test Unit / Minitest with RSpec <a id="part-3000"></a>

* Optionally run Test Unit one last time before sending it to oblivion
    `rake test`

* Remove Test Unit's directory and files
    `rm -rf test/`

* Add RSpec to test group within Gemfile to retrieve latest patch https://github.com/rspec/rspec-rails
    `gem 'rspec-rails', '~> 3.5.2'`

* Check that using Custom GemSet. Install Gems
    ```
    rvm --ruby-version use 2.4.0@rails_csv_app
    bundle install
    ```

* Initialise /spec directory
    `rails generate rspec:install`

* Run RSpec tests
    `rspec`

## Setup - Git Repo <a id="part-4000"></a>

* Create new project on GitHub with MIT licence i.e. https://github.com/ltfschoen/rails_csv_app

* Show remote branches for current repo
    `git remote -v`

* Set a remote URL using SSH
    `git remote add origin git@github.com:ltfschoen/rails_csv_app.git`

* Use [Bulletproof Git Workflow](https://gist.github.com/ltfschoen/3c7a085f132baf4aff13c9d561b35d03) to rebase with remote branch and get the MIT licence before pushing new changes
    `git pull --rebase origin master`

* Force push to remote branch to overwrite existing history
    `git push -f origin master`

## Setup - Git Release and Tags <a id="part-5000"></a>

* Create New Release https://github.com/ltfschoen/rails_csv_app/releases/new
    * Pre-Release (non-production) i.e. v0.1

## Feature - CSV Upload and Display <a id="part-6000"></a>

### CSV Setup

* Create new Git branch
	```
	git checkout -b feature/csv
	```

* Generate Model
    ```
    rails g model Product name:string quantity:integer price:decimal comments:string
    ```

* Modify the migration file as follows:
	`t.decimal :price, precision: 12, scale: 2`

* Migrate
    `rake db:migrate RAILS_ENV=development`

* Generate Controller with index and import Actions
    `rails g controller Products index import`

* Modify Routes as follows:
	```
	resources :products do
	  collection { post :import }
	end

	root to: "products#index"
	```

* Update Product Model import function to accept CSV and process each row by
comparing with Product table of database, and either updating or creating new entry

* Update Product Controller's index action to fetch all Products to be available in view
as @products. Also update its import action to call the Product Model's import function
passing a given file parameter as argument, and then redirecting user to the root url

* Update Product's index View to display list of products, including form allowing user to
upload the CSV by submitting form

* Create a CSV file called products.csv

* Run server and upload the CSV file, then check it exists in database. Drop database and re-migrate to further test
	```
	rails dbconsole
	select * from products;
	rake db:drop
	rake db:create db:migrate RAILS_ENV=development
	```

* Add Unit Tests by adding the following gem to allow use of `assigns` in Controller tests
	`gem 'rails-controller-testing', '~> 1.0.1'`

* Modify Unit Tests for Product Controller and Model
	* Reference: http://stackoverflow.com/questions/15175970/undefined-method-when-running-rspec-test-using-a-stub

* Create New Release https://github.com/ltfschoen/rails_csv_app/releases/new
    * Feature Release (non-production) i.e. v0.2

## Feature - Search and Filter Data Uploaded from CSV with Pagination <a id="part-7000"></a>

* References
	* http://stackoverflow.com/questions/28603881/how-to-create-a-ajax-filter-in-the-index-page
	* http://railscasts.com/episodes/240-search-sort-paginate-with-ajax
* Update to jQuery v3 and install jQuery UI Rails
	* https://github.com/rails/jquery-rails
		* Updating app/assets/javascripts/application.js with:
			```
			//= require jquery3
			//= require jquery_ujs
			```
		* Install jquery-ui-rails Gem
			* https://github.com/jquery-ui-rails/jquery-ui-rails

* Add Willpaginate Gem
	* https://github.com/mislav/will_paginate

* Since using latest version of Rails 5.0.2 and Ruby 2.4.0 it was
necessary to make the following key changes to the RailsCast #240 code that was
written for Rails 3 back in 2010, to make it run without error:
    * Replaced `scope` with `where(nil)` in app/models/product.rb
    * Replaced `params.merge` with `request.parameters` in app/helpers/application_helper.rb
    * Replaced `sort_column` with `self.sort_column`, and `sort_direction` with `self.sort_direction` in app/helpers/application_helper.rb
    * Added `include ApplicationHelper` in app/controllers/products_controller.rb
    * Whitelisted parameters in app/controllers/products_controller.rb with the following and by accessing parameters with `product_params[:search]` instead of just `params[:search]`:
        ```
          def product_params
            params.permit(:id, :uid, :name, :price, :released_at, :search, :page, :sort, :utf8, :direction, :_)
          end
        ```
    * In app/assets/javascripts/application.js, change jQuery `.live`(deprecated) to `.on`
    * In app/views/products/index.html.erb had to change code to dynamically display title of page by using `<% content_for :title, "Products" %>` instead of just `<% title "Products" %>`

* Add Sass Rails Gem
    * http://stackoverflow.com/questions/15257555/how-to-reference-images-in-css-within-rails-4

## Feature - Bootstrap <a id="part-8000"></a>

* Bootstrap 4 tables https://v4-alpha.getbootstrap.com/content/tables/

### Feature - Fake CSV Generator <a id="part-9000"></a>

* Faked CSV Gem https://github.com/jiananlu/faked_csv
    * Create file `fake_csv_config.csv.json`
    * Configure it to output CSV data in format desired and supports Faker Gem https://github.com/stympy/faker
    * Execute it with the following to generate random CSV:
        `faked_csv -i fake_csv_config.csv.json -o products.csv`
    * Insert the Labels at the top of the generated file, i.e.
        `uid,name,quantity,price,comments,released_at`
    * Convert image to display correctly
