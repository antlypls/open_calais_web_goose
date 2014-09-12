# OpenCalais Web

This is a small web service to experiment with fetching semantic metadata using [OpenCalais](http://www.opencalais.com/).

## How To Run

First, you need to get an API key from the [OpenCalais web site](http://www.opencalais.com/APIkey).

You can run service locally with `foreman`, just add `.env` file like that:

```{sh}
OPEN_CALAIS_API_KEY=your_open_calais_api_key
PORT=9292 # or whatever port you like to run service on
AUTH_TOKEN=some_string # token is used to check access for the service
```

And then just run `foreman start`.

Or you can deploy service to Heroku.

```{sh}
heroku create
git push heroku master
heroku config:set OPEN_CALAIS_API_KEY=your_open_calais_api_key
heroku config:set AUTH_TOKEN=some_string
```

# How It Works

Service accepts POST requests to a `/url` endpoint, a request should contain two parameters: authorization token `auth_token` and `url` for analysis.

For example, try it using cURL:

```{sh}
curl -X POST --form 'auth_token=some_string' --form 'url=http://en.wikipedia.org/wiki/Ruby_(programming_language)' http://localhost:9292/url
```

Or just use a simple web interface available at the root,
go to `http://localhost:9292/` and try it.

# License

MIT. See the `LICENSE` file for more info.
