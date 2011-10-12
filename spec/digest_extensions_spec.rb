require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'digest/md5'

describe Digest::MD5 do
  describe "#marshal_dump" do
    it "can marshal md5 sum for empty object  " do
      digest = Digest::MD5.new
      digest.marshal_dump
    end

    it "returns a byte sequence that is larger than 176" do
      ## 88 bytes is minum state information for MD5
      digest = Digest::MD5.new
      digest.marshal_dump.should have_at_least(176).bytes.to_a
    end

  end

  describe "#marshal_load" do
    context "with a marshalled digest of empty byte sequence" do
      digest = Digest::MD5.new
      marshalled_digest = digest.marshal_dump

      it "can load to the correct digest" do
        Digest::MD5.new.tap{|h|h.marshal_load(marshalled_digest)}.hexdigest.should == digest.hexdigest
      end
    end

    context "with marshalled digest of a random byte sequence" do
      size = 10000
      byte_sequence = (0...size).map{|i| rand(256)}.pack('c*')
      digest = Digest::MD5.new
      digest << byte_sequence
      marshalled_digest = digest.marshal_dump
      
      it "can load to the correct digest " do
        Digest::MD5.new.tap{|h|h.marshal_load(marshalled_digest)}.hexdigest.should == digest.hexdigest
      end
    end
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

  context "with an array of parts" do
    size = 1000000
    byte_sequence = (0...size).map{|i| rand(256)}.pack('c*')
    parts = 100 + rand(900)
    max_size = size/parts #Integer
    parts_array = (0..parts).map{|p| byte_sequence[(p*max_size)...((p+1)*max_size)]}
    
    it "can be used to take a series of parts and compute the digest of the concatenation" do
      ## parts_array is provided.
      marshalled_digest_in_database = Marshal::dump(Digest::MD5.new) #An initial value
      parts_array.each do |part|
        marshalled_digest = Marshal::load(marshalled_digest_in_database) # Fetch from database
        marshalled_digest << part
        marshalled_digest_in_database = Marshal::dump(marshalled_digest) # Store from database
      end
      marshalled_digest = Marshal::load(marshalled_digest_in_database) # Fetch from database
      marshalled_digest.hexdigest.should == Digest::MD5.hexdigest(parts_array.inject("", :+))
    end
  end
end
