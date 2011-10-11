require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'digest/md5'

describe Digest::MD5 do
  describe "#marshal_dump" do
    it "returns a byte sequence that is larger than 176" do
      ## 88 bytes is minum state information for MD5
      digest = Digest::MD5.new
      digest.marshal_dump.should have_at_least(176).bytes.to_a
    end

    it "returns a byte sequence that is accepted by marshal_load" do
      Digest::MD5.new.marshal_load(Digest::MD5.new.marshal_dump)
    end
  end
  it "can marshal md5 sum for empty object  " do
    digest = Digest::MD5.new
    digest.marshal_load(Digest::MD5.new.marshal_dump)
    digest.hexdigest.should == Digest::MD5.new.hexdigest
  end
  it "can marshal md5 sum objects " do
    byte_sequence = rand(256).chr("binary") * 100000
    hex_digest = Digest::MD5.hexdigest(byte_sequence)
    d = Digest::MD5.new
    d << byte_sequence
    md = d.marshal_dump
    Digest::MD5.new.tap{|h|h.marshal_load(md)}.hexdigest.should == hex_digest
  end
  it "can continue on partial digestions " do
    size = 10000
    byte_sequence = (0...size).map{|i| rand(256)}.pack('c*')
    hex_digest = Digest::MD5.hexdigest(byte_sequence)
    d = Digest::MD5.new
    split = rand(size)
    d << byte_sequence[0..split]
    continue = Digest::MD5.new
    continue.marshal_load(d.marshal_dump)
    continue << byte_sequence[split+1..-1]
    continue.hexdigest.should == hex_digest
  end
end
