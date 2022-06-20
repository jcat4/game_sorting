# tdd-ruby-base-project
A skeleton project for TDD ruby development. Using rspec, guard, and ruby 3.1.0 (for now)

## TODO

- [ ] Set up rubocop (Shopify style guide?)
- [ ] Make sure personal machine is set up to use rubocop + formatter
- [x] Add support for shared examples
  - Add `spec/support/shared_examples` directory, change `spec_helper` to auto-require
  - [this link](https://relishapp.com/rspec/rspec-core/v/3-3/docs/example-groups/shared-examples) explains how
    ```ruby
    Dir["./spec/support/**/*.rb"].sort.each { |f| require f }
    ```
