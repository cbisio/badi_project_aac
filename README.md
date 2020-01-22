# Bootcamp Ruby template
Here you will find the skeleton that you need to do a Rails project using the same toolset that we use @ badi.

## Requirements
- Ruby 2.5 or higher
- MySQL 5.7 or higher

Or Docker Compose with the same requirements.

## Recommended git workflow
You can work with only one special branch: `master`. Then, to add new features you can just use meaningful names to create a new branch that will be merged through a PR to `master`. Find more details about this git workflow [here](https://guides.github.com/introduction/flow/).

## Architecture
The architecture that we follow at the moment @ badi is heavily based on **service objects**. You can find tons of articles about this, but [this one](https://medium.com/selleo/essential-rubyonrails-patterns-part-1-service-objects-1af9f9573ca1) is quite simple and uses the same naming and conventions that we follow.

Also, keep in mind that we use **Grape over Rails**, which means that **we don't use Rails controllers**. Find everything related to endpoints in `app/api/badi/`.

## Testing
We don't mind if we prefer to use TDD or test it after developing the code. However, we expect to have a good code coverage, as close as you can to 100%, but also tests that are significant and stable.

To check your test suite you can simply run `bundle exec rspec`, and after the execution, you can open the coverage report `open coverage/index.html`.

## Guidelines
We encourage you to use [Rubocop](https://github.com/rubocop-hq/rubocop) and keep the code clean of offenses. Of course, you might find some rules that you don't like it, feel free to customize those if the team agreed.
