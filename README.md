# PivotalMarkdown

[![Build Status](https://app.codeship.com/projects/1b599e00-73d5-0134-dfe0-4a3fe60937a4/status?branch=master)](https://app.codeship.com/projects/179042)
[![Code Climate](https://codeclimate.com/github/philliplongman/pivotal_markdown/badges/gpa.svg)](https://codeclimate.com/github/philliplongman/pivotal_markdown)
[![Coverage Status](https://coveralls.io/repos/github/philliplongman/pivotal_markdown/badge.svg?branch=master)](https://coveralls.io/github/philliplongman/pivotal_markdown?branch=master)

PivotalMarkdown is a command line gem to facilitate posting stories to PivotalTracker. It's an expansion of a [script](https://github.com/philliplongman/pivotal-uploader) I wrote at Launch Academy's Ship It Saturday hackathon.

At the time, I was writing all of the user stories for my team, and I found it was easiest for me to compose them in Markdown prior to posting them. The `pivotal_markdown` gem is intended to take Markdown files like the ones I was writing, parse them into stories, and add them to a PT project.

The gem was nearing its initial release, but since I am no longer writing stories for PivotalTracker, I have stopped developing it for now.

## Usage

```
Commands:
  ptmd help [COMMAND]          # Describe available commands or one specific command
  ptmd project COMMAND         # Configure project to default to when none is specified
  ptmd token COMMAND           # Configure API token to access Pivotal Tracker
  ptmd upload FILE             # Parse Markdown file and upload stories to Pivotal Tracker

  ptmd project check           # Check configured default project
  ptmd project reset           # Clear configured API token
  ptmd project set PROJECT_ID  # Set default project

  ptmd token check             # Check configured API token
  ptmd token set TOKEN         # Set API token to access

  ptmd upload FILE             # Parse Markdown file and upload stories to Pivotal Tracker
```

Your API token and default project are stored in a `.pivotal_markdown` file.

## Markdown story format

```markdown
Project: 1234567


# Example feature

As a product manager,
I want to write user stories in markdown and upload them to Pivotal Tracker,
so that I can do less work setting them up.

Notes:
* Asterisk bullet points should be considered part of the description.

Labels: example feature, pretend label

- Every # header should begin a new story.
- Story type should be at the end of the story name, in parenthesis. Default is feature.
- Labels should be prefixed by 'Labels:' and be comma-separated.
- Tasks should appear at the end as hyphen bullet points.


# Example bug (bug)

This is a bug. Something is wrong with the example feature. This story has a label.

Labels: example feature


# Example chore (chore)

This is a chore and isn't written with all those bells and whistles.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/philliplongman/pivotal_markdown. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
