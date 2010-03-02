module AssetTimestampsCache

  @@asset_timestamps_cache = {}
  @@asset_dir = 'public'

  def self.asset_dir
    @@asset_dir
  end

  def self.asset_dir=(val)
    @@asset_dir = val
  end

  def self.[](asset_path)
    if timestamp = @@asset_timestamps_cache[asset_path]
      timestamp
    else
      file_path = File.join(*[@@asset_dir, asset_path].compact)
      timestamp = File.exist?(file_path) ? File.mtime(file_path).to_i.to_s : ''
      @@asset_timestamps_cache[asset_path] = timestamp
    end
  end

  def self.clear
    @@asset_timestamps_cache.clear
  end

  def self.timestamped_asset_path(asset_path)
    timestamp = self[asset_path]
    "#{asset_path}?#{timestamp}"
  end

  module ViewHelper
    def timestamped_asset_path(asset_path)
      AssetTimestampsCache.timestamped_asset_path(asset_path)
    end
  end

end
