# PivotalMarkdown

[![Build Status](https://app.codeship.com/projects/1b599e00-73d5-0134-dfe0-4a3fe60937a4/status?branch=master)](https://app.codeship.com/projects/179042)
[![Code Climate](https://codeclimate.com/github/philliplongman/pivotal_markdown/badges/gpa.svg)](https://codeclimate.com/github/philliplongman/pivotal_markdown)
[![Coverage Status](https://coveralls.io/repos/github/philliplongman/pivotal_markdown/badge.svg?branch=master)](https://coveralls.io/github/philliplongman/pivotal_markdown?branch=master)

PivotalMarkdown is a gem to facilitate posting stories to PivotalTracker. I was writing all of the stories for my team, and I found it was easiest for me to compose them in Markdown prior to posting them.

This gem is intended to take Markdown files in the format I used, parse them into stories and epics, and add them to a PT project.

The gem was meant to be an expansion of the `pivotal-uploader` ([here](https://github.com/philliplongman/pivotal-uploader)) script I wrote at Launch Academy's Ship It Saturday hackathon. Right now it only handles setting your API token and a default project in a `.pivotal_markdown` file.

Since I am no longer writing stories for that team, I have stopped developing the gem for now.

## Usage

```
Commands:
  ptmd help [COMMAND]   # Describe available commands or one specific command
  ptmd project COMMAND  # Configure project to default to when none is specified
  ptmd token COMMAND    # Configure API token to access Pivotal Tracker

  ptmd project check           # Check configured default project
  ptmd project help [COMMAND]  # Describe subcommands or one specific subcommand
  ptmd project reset           # Clear configured API token
  ptmd project set PROJECT_ID  # Set default project

  ptmd token check           # Check configured API token
  ptmd token help [COMMAND]  # Describe subcommands or one specific subcommand
  ptmd token set TOKEN       # Set API token to access
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/philliplongman/pivotal_markdown. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
