require 'asset_timestamps_cache'
require 'test/unit'
require 'fileutils'
require 'rubygems'
require 'mocha'

class TestAssetTimestampsCache < Test::Unit::TestCase
  def setup
    AssetTimestampsCache.clear
    FileUtils.mkdir_p 'public'
    FileUtils.touch 'public/fixture.txt'
  end

  def test_returns_mtime_for_file
    mtime = File.mtime('public/fixture.txt').to_i.to_s
    assert_equal mtime, AssetTimestampsCache['fixture.txt']
  end

  def test_returns_blank_string_for_nonexistent_file
    assert_equal '', AssetTimestampsCache['nonexistent.txt']
  end

  def test_only_calls_file_mtime_once_on_repeated_access
    File.expects(:mtime).once.returns '12345'
    5.times do
      assert_equal '12345', AssetTimestampsCache['fixture.txt']
    end
  end
end

class TestAssetTimestampsCacheViewHelper < Test::Unit::TestCase
  class Foo; include(AssetTimestampsCache::ViewHelper); end

  def setup
    AssetTimestampsCache.clear
    FileUtils.mkdir_p 'public'
    @scope = Foo.new
  end

  def test_timestamped_asset_path
    FileUtils.touch 'public/fixture.txt'
    mtime = File.mtime('public/fixture.txt').to_i.to_s
    assert_equal "fixture.txt?#{mtime}", @scope.timestamped_asset_path('fixture.txt')
  end

  def test_timestamped_asset_path_for_nonexistent_asset
    assert_equal "nonexistent.txt?", @scope.timestamped_asset_path('nonexistent.txt')
  end
end
