AssetTimestampsCache
====================

Asset timestamping for Rack apps. Adapted from asset timestamping functionality in ActionPack.


View Helper
===========

AssetTimestampsCache::ViewHelper contains an timestamped_asset_path method,
which appends a timestamp of the file's last modified time to the asset path.

So,

    <%= timestamped_asset_path "images/logo.png" %>

will output:

    "images/logo.png?1267564623"

This timestamp value is cached, so that subsequent calls don't need to hit the filesystem.

Sinatra setup example:

    class MyApp < Sinatra::Base
      helper AssetTimestampsCache::ViewHelper

      # etc...
    end


Direct Cache Access
===================

    # Will look for "public/images/log.png" and get last modified time.
    # Subsequent lookups will read from internal hash cache instead of filesystem
    AssetTimestampsCache["images/logo.png"] # => "1267564623"

    # Change asset directory from default of "public"
    AssetTimestampsCache.asset_dir = 'assets'

    # Clear cache
    AssetTimestampsCache.clear


Caveat: NOT THREADSAFE. This shouldn't be a problem if you're deploying to Passenger.
One could always add a Mutex around cache writes (as ActionPack does) if thread safety
is an issue.
