# RailsMetadata

For adding fake fields stored in a hash in Rails.

More documentation to come when I'm less lazy.

## Installation

Add this line to your application's Gemfile:

    gem 'rails_metadata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_metadata

## Usage

For any model you want to use this on, add the following.
```
include RailsMetadata
serializable :metadata, Hash
```
And perform the following migration
```
add_column :table_name, :metadata, :text
```

The default limit on :text fields is 65535, so if you anticipate storing more
than that, you should set the limit higher on the column.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
