# keen-cli-mixpanel

Mixpanel plugin for the [keen-cli](https://github.com/keen/keen-cli).

### Installation

Install the keen-cli. You can find installation instructions [here](https://github.com/keen/keen-cli#installation).

Install the Mixpanel plugin:

``` shell
$ keen plugins:install mixpanel
```

Verify the `keen mixpanel` command is available in the list of `keen` commands by running it:

``` shell
Commands:
  ...
  keen mixpanel              # Manage the Mixpanel plugin
  ...
```

### Environment Configuration

The same rules that apply for `keen-cli` [environment variables](https://github.com/keen/keen-cli#environment-configuration) apply to the Mixpanel plugin, with the addition of Mixpanel specific API keys.

Add the following environment variables to your `.env` file in addition to your KEEN variables:

```
MIXPANEL_API_KEY=xxxxxxxxxxxxxxx
MIXPANEL_API_SECRET=yyyyyyyyyyyyyyy
```

If you run keen from a directory with this .env file, it will assume the project in context is the one specified by KEEN_PROJECT_ID.

To override the current context use the `--api-key` and `--api-secret` options:

``` shell
keen mixpanel export --api-key XXXXXXXXXXXXXXX --api-secret YYYYYYYYYYYYYYY
```

### Usage

keen-cli-mixpanel has a few core commands.

* `export` - Export events from Mixpanel to a file.
* `import` - Import events from Mixpanel directly to Keen IO.
* `version` - Print version information.

##### Export

`keen mixpanel export` - Export events to a file.

Parameters:

+ `--event`: The event that you wish to get data for.
+ `--from-date`: The date in yyyy-mm-dd format from which to begin querying for the event from. This date is inclusive.
+ `--to-date`: The date in yyyy-mm-dd format from which to stop querying for the event from. This date is inclusive.
+ `--file`: The output file.

##### Import

`keen mixpanel import` - Import events from Mixpanel directly to Keen IO.

Parameters:

+ `--event`: The event that you wish to get data for.
+ `--from-date`: The date in yyyy-mm-dd format from which to begin querying for the event from. This date is inclusive.
+ `--to-date`: The date in yyyy-mm-dd format from which to stop querying for the event from. This date is inclusive.
+ `--collection`, `-c`: The name of the Keen IO collection you wish to import your Mixpanel into.

Examples: 

``` shell
# export events from Mixpanel to a file
$ keen mixpanel export --event pageviews --from-date 2014/08/01 --to-date 2014/08/02 --file pageviews.json

# import events from Mixpanel directly to Keen IO
$ keen mixpanel import --event pageviews --from-date 2014/08/01 --to-date 2014/08/02 --collection pageviews_import
```

### Changelog

+ 0.1.0 - Initial version

### Contributing

keen-cli-mixpanel is open source, and contributions are welcome!

Running the tests with:

```
$ bundle exec rake spec
```
