# Bigbrotha

Allows you to find taboo words, censor them and keep track of who created them.
Optionally you can generate ActiveAdmin pages to import taboo words and keep track of the generated TabooPosts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bigbrotha'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bigbrotha

## Usage

### Initialization
In order to create migrations for the models and the setup file in initializers, use: 
`bin/rails generate big_brotha:initializer`

#### Migrations
Running the migrations will generate tables for two models: Taboo and TabooPost. 
- **Taboo**: is where all the taboo words are saved. 
    You can *Add* taboo word by calling the method `BigBrotha.add_taboo!(taboo_word)`.
    *Remove* taboo by calling `BigBrotha.remove_taboo(taboo_word)`.
    *Find* taboo object by calling `BigBrotha.find_taboo(taboo_word)`.
- **TabooPost**: where the content from the columns with taboos is saved, with reference to the user who created it and reference to all the taboos found in that content.

**!** Before you run `db:migrate` make sure you have a **User** model that TabooPost can reference. 

#### Configuration
In *"config/initializers/bigbrother.rb"* you configure all the necessary places where checks for taboos need to be done.

Example configurations:
```sh
BigBrotha.configure do |config|
 config.add(User, :self, [:username, :comment], :after, :save)
 config.add(Room, :creator, :message, :before, :update)
end
```

In the **add** method you have to set the following parameters: **Model**, **:relation_name**, **:column_names**, **:timing**, **:event**

- **Model**: is the ActiveRecord model on which you want to append the callback function for taboo checks
- **relation_name**: is the name of the relation to the *User* model that will be saved as the creator of the taboo post. 
           The **:self** symbol can be passed **only** for the **User** model, where the **:create** event has to be called with timing **:after**, OTHERWISE *user_id* won't be added to the TabooPost object.
- **column_names**: are the names of the columns in the Model, that need to be checked for any taboos
- **timing**: indicates whether the callback is to be run :before, :after, or :around the event.
- **event**: indicates around which event (:save, :update, :create ... ) the callback is to be run.



### ActiveAdmin
To create active admin pages for Taboos and TabooPosts run: `bin/rails generate big_brotha:active_admin`.

Optionally you can add a button for importing taboos in csv format. To do this, you have to add
`gem 'active_admin_importable'` to your Gemfile, run `bundle install` and uncomment in *"app/admin/taboo.rb"* the block that allows you this option. 
The *csv files* in the first line, have to contain the word: **keyword**

You can edit the active admin pages as you want, for more info go to: [ActiveAdmin](https://github.com/activeadmin/activeadmin) and [ActiveAdmin importable](https://github.com/krhorst/active_admin_importable).

### Full Example
1.Configure
```sh
BigBrotha.configure do |config|
 config.add(User, :self, :username, :after, :save)
end
```
2.Add Taboos
```sh
>> BigBrotha.add_taboo!("princess")
```
3.Create User
```sh
>> user = User.create(username: "I'm princessita")
```
4.Result
```sh
>> user.username
"I'm *******ita"
```
5.Check TabooPost
```sh
>> BigBrotha::TabooPost.where(user: user)

#<BigBrotha::TabooPost id: 1, content: "I'm princessita", content_column: "User.username", user_id: 1>
```
## Additional methods
Censor class contains additional method which you can use to censor text.
```sh
>> BigBrotha::Censor.censor_taboos_in_text("This is an example text with few taboos", ["example","taboo"])
"This is an ******* text with few *****s"
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SnezanaDichevska/bigbrotha. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

