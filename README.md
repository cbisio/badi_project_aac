# Bootcamp Ruby template
Here you will find the skeleton that you need to do a Rails project using the same toolset that we use @ badi. This repository corresponds to the backend side of our Badi project, carried out by Arnald Aulí, Camilas Bisio and Albert Llebaria. Check out our [home wiki page](https://github.com/cbisio/badi_project_aac/wiki) to meet the team! :smile:

If any further information is required you can check our wiki, where we have tried to explain and justify everything that has been implemented.

## Requirements
- Ruby 2.6.5
- PostgreSQL 12

Or Docker Compose with the same requirements.

## Recommended git workflow
We basically merge our feature branches into dev for the development process and dev into master as for the deployment. You can find out a more detailed information about the git workflow that has been decided by the team in our git flow [wiki page](https://github.com/cbisio/badi_project_aac/wiki/Git-flow).

## Architecture
The architecture that we follow at the moment @ badi is heavily based on **service objects**. Also, keep in mind that we use **Grape over Rails** (you can check why and how we use it in our [grape wiki page](https://github.com/cbisio/badi_project_aac/wiki/Grape-Framework)), which means that **we don't use Rails controllers**. Moreover, you can find everything related to endpoints in our [endpoints wiki page](https://github.com/cbisio/badi_project_aac/wiki/APP-flow-with-Endpoints). 

We have also defined a set of models which will be used to accomplish our project goals. Their definition, attributes and associations can be found in our [models wiki page](https://github.com/cbisio/badi_project_aac/wiki/Models-Architecture). Furthermore, we have created a script which retrieves data and fills models information in our database (see our [retrieve data wiki page](https://github.com/cbisio/badi_project_aac/wiki/Retrieving-data)). To search for rooms (GET /rooms endpoint) we have implemented Elasticsearch. You can check more details on why and how we have used it in our project in our [Elasticsearch wiki page](https://github.com/cbisio/badi_project_aac/wiki/Elasticsearch).

For further scalability, we have also implemented an internationalization service so the API can use multiple languages in the future. You can find more details on how we have implemented it in our [I18n wiki page](https://github.com/cbisio/badi_project_aac/wiki/i18n-multiple-language-support).

## Geocoding service provider
Given that our search endpoint will provide locations obtained by a third party API, we've had to study different providers. We finally have selected TomTom's API but you can check our discussion about which approach to choose in our [Map API wiki page](https://github.com/cbisio/badi_project_aac/wiki/Map-API).

## Deployment
Our Ruby on Rails API runs in an AWS EC2 service. Find more details in our [AWS wiki page](https://github.com/cbisio/badi_project_aac/wiki/Amazon-Web-Services-(AWS)).

## Testing
We use TDD methodology. Thus, we expect to have a good code coverage, as close as you can to 100%, as well as tests that are significant and stable. However, if any areas are not covered by using TDD, testing will be refactored afterwards if coverage percentage needs to be increased.

To check your test suite you can simply run `bundle exec rspec`, and after the execution, you can open the coverage report `open coverage/index.html`.

## Guidelines
We have used [Rubocop](https://github.com/rubocop-hq/rubocop) to keep the code clean of offenses. We have customized some rules that the team agreed. Those can be found in the .editorconfig file.
